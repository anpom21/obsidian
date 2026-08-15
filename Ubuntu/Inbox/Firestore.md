---
created: 2026-06-09
tags:
  - ARIS
  - Documentation
source:
aliases:
---
![[Firestore overview.excalidraw]]
# 1. The mental model

Insights is a **thin client on top of Firestore**. There is almost no backend API — the React app talks to Firestore directly, downloads raw documents, and does all aggregation in the browser. The only server code is a handful of Cloud Functions ([functions/index.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/index.js)) that maintain derived counters, plus one callable used for user names.

Three JavaScript things to know for reading this repo:

- **Contexts** (`react-app/src/contexts/*`) are shared state. `useUser()`, `useSecondHeader()`, `useUnitDataCache()` are how pages get data without passing props down. They're set up in [index.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/index.js) and read anywhere below.
- **`useEffect(fn, [deps])`** = "run `fn` when any value in `deps` changes." Most Firestore fetches in this codebase hang off one of these. When you see a fetch happen twice or in the wrong order, it's almost always the dependency array.
- **`onSnapshot` vs `getDocs`**: `onSnapshot` opens a live subscription (updates push in, must be unsubscribed in the effect's return function); `getDocs` is a one-shot read. Admin pages use `onSnapshot` heavily; the dashboard uses `getDocs`.

# 2. The collections

```
users/{uid}                             ← identity + all access control
companies/{companyId}                   ← {waste_receiver}
  locations/{locationId}                ← name, poster_url, units[] | display_units[]
  dangerous-waste-config/{doc}
units/{unitId}                          ← config: deployment_config, custom_categories, company
  inference-records/{recordId}          ← the main data: timestamp, eval, is_test, user_evals
    point-annotations/{id}
  dangerous-waste-records/{recordId}    ← same role, dangerous-waste product line
  state-logs/{recordId}                 ← {timestamp, state: Ready|Warning|Error}
waste_receivers/{id}                    ← columns, grouping_columns, sorting_list
company_app_records/{companyId}/dangerous-waste-records/{id}   ← mobile app scans
waste_receiver_app_records/{id}/...     ← same, receiver-owned
waster_receiver_app_records/{id}/...    ← legacy misspelling, still read
record_categories/{id}                  ← {unit, name, votes} — vote ranking for custom categories
admin/inference_time                    ← {<category>: avg, <unitId>: avg, total: avg}
admin/usage-by-day/{category}/{YYYY-MM-DD}  ← {count}
admin/general/warnings
unit_filter_environments/{excluded_from_statistics|excluded_from_recent_images}
unit_filter_sections/{id}/groups        ← roll-out targeting
```

Cloud Storage: `images/{img_name}`, `unit_screenshots/{name}`, `location_posters/`, `unit_posters/`, `wade_report/partner_logos/`, and per-owner app-record folders.

**Key structural fact:** a machine appears in _two_ places. `units/{unitId}` is the machine's own document, but a location's `display_units[]` array holds a **copy** of `deployment_config` plus `unit_ranges` that stitch several physical units into one logical unit over time. When both exist, the location's copy wins ([SecondHeaderContext.js:23-38](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/SecondHeaderContext.js#L23-L38)). This duplication is the source of a lot of the branching you'll see (`if (currentUnit.unit_ranges) … else …` appears in nearly every data path).

# 3. Who writes what

|Writer|Writes|
|---|---|
|The machines (outside this repo)|`inference-records`, `dangerous-waste-records`, `state-logs`, `unit.last_screenshot_*`, `unit.system_version`, `unit.memory_use`|
|Mobile app (outside this repo)|`company_app_records/*/dangerous-waste-records`|
|Cloud Functions|`unit.firstUse`, `record.eval`/`broad_class_name`/`is_test` (from `specific_class_name`), `record.highest_voted_eval`, `admin/usage-by-day/*`, `admin/inference_time`, `users/{uid}` on signup/delete|
|This web app|`user_evals`/`admin_evals` on records, `custom_categories`/`aris_custom_categories` on units, `record_categories.votes`, `deployment_config` (RollOut), `waste_receivers` + `companies.waste_receiver` + `users.waste_receivers` (Setup)|

# 4. Page → data

|Page|Reads|Notes|
|---|---|---|
|[HomePage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/HomePage/HomePage.jsx)|`users`, `companies`, `companies/*/locations`, `state-logs` (live), probe of app-record collections|Location cards + "App scanninger" cards. Live dot = worst `state` in the last hour|
|[UnitsPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/UnitsPage/UnitsPage.jsx) + [UnitCard.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/UnitsPage/UnitCard/UnitCard.jsx)|`location.display_units`, all `inference-records` per range, `state-logs`|`activations` and `latest_use` are computed here, not stored|
|[DashBoardSubPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DashBoardPage/sub-pages/DashBoardSubPage/DashBoardSubPage.jsx)|`units/{id}` config + `inference-records` in range|4 cards, all from one client-side fetch. Category logic per my previous answer|
|[ImagesSubPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DashBoardPage/sub-pages/ImagesSubPage/ImagesSubPage.jsx)|same records + `storage:images/{img_name}`|Writes `user_evals`/`admin_evals`; CSV/ZIP export|
|[RecordDialog.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DashBoardPage/sub-pages/ImagesSubPage/RecordDialog/RecordDialog.jsx)|one record + `point-annotations`||
|[WadeReportPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/WadeReportPage/WadeReportPage.jsx) / Week / Month|same contexts as the dashboard|Print-style report views|
|[DangerousWasteImagesPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DangerousWasteImagesPage/DangerousWasteImagesPage.jsx)|`units/*/dangerous-waste-records` **or** `*_app_records/*/dangerous-waste-records`, `waste_receivers`, `companies`|`record.eval` is an **object** here, keyed by `waste_receivers.columns[].id`; grouping from `grouping_columns`; review queue from `user_eval_requests`|
|[DangerousWasteSortingListPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DangerousWasteSortingListPage/DangerousWasteSortingListPage.jsx)|`waste_receivers` (live), `companies`, locations|Writes `sorting_list`|
|[SetupPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/SetupPage/SetupPage.jsx) (admin)|`users` (live), `companies`, `waste_receivers`|The only place couplings and memberships are edited; batched writes|
|[RollOutPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/RollOutPage/RollOutPage.jsx) (admin)|all `units`, all locations, `unit_filter_sections`, `unit_filter_environments`|Writes `deployment_config` to units _and_ into `location.display_units[i]`|
|[AdminPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/Admin/AdminPage/AdminPage.jsx)|`admin/usage-by-day`, `admin/inference_time`, all `units`, collectionGroup on both record types, `company_app_records`|The fleet dashboard|
|[InferenceTimesPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/Admin/InferenceTimesPage/InferenceTimesPage.jsx)|`admin/inference_time`, `units`, per-unit records||
|[WeeklyUsagePage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/Admin/WeeklyUsagePage/WeeklyUsagePage.jsx) / UnitsPage|all `units` + 7 days of records **per unit**, `excluded_from_statistics`|Recomputes from raw records rather than using `usage-by-day`|
|[RecentPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/Admin/RecentPage/RecentPage.jsx) / [ScreenMonitoringPage.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/Admin/ScreenMonitoringPage/ScreenMonitoringPage.jsx)|live `state-logs`, latest record per unit, `unit.last_screenshot_*` + storage||
|[AppHeader.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/components/NavigationFrame/AppHeader/AppHeader.jsx)|`waste_receivers` (live), `users`|Nav visibility|
|[Warnings.jsx](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/components/Warnings/Warnings.jsx)|`admin/general/warnings` (live)|Banner|

# 5. Concerns

I'd treat the first two as things to raise with the team this week; the rest are ordinary tech debt.

### Security

**The database is world-readable.** [firestore.rules:5-8](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/firestore.rules#L5-L8) opens with `match /{document=**} { allow read: if true; }`. Firestore ORs all matching rules together — a later, stricter rule cannot take away what an earlier one granted. So every carefully written `canSeeCompany` / `canSeeRecord` function below it is decorative for reads: anyone with the project ID (which is in [firebase.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/firebase.js), shipped to every browser) can read every user document, every company, and every record without logging in. The two `canAccessUnit()` / `canAccessLocation()` helpers that `return true` ([firestore.rules:327-333](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/firestore.rules#L327-L333)) do the same for writes to `units/**` for any logged-in user, with a comment saying to tighten it later.

If this is the dev project only and prod has different rules, then it's just the dev data. If the same file is deployed to prod (`make deploy-rules`), it's a live exposure. Worth confirming which, first thing.

### Correctness

**`where("is_test", "!=", true)` silently drops records that have no `is_test` field.** Firestore inequality filters only match documents where the field _exists_. This filter is on nearly every record query ([unitDataHooks.js:288-299](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/hooks/unitDataHooks.js#L288-L299), [UnitDataCacheContext.js:433](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L433), the `activityOverTime` function). `is_test` is only written by `updateCategoryOnCreate`, and only for records that have `specific_class_name` ([functions/index.js:310-323](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/index.js#L310-L323)). Any record without that field is invisible to the entire dashboard. If totals have ever looked low, this is the first place I'd look.

**The category whitelist deletes data from the totals.** Covered in my previous answer — records whose `eval` isn't in the unit's category list are dropped from the fetch, so they don't appear anywhere, not even in the activation count.

**A failed fetch poisons the cache.** [UnitDataCacheContext.js:415](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L415) marks `[from, to]` as cached _before_ running the query, and the `catch` block only logs. If the query fails, that range is permanently recorded as fetched-and-empty for the session, and every later request for it returns nothing.

**`record.user_eval` is a typo for `user_evals`.** [ImagesSubPage.jsx:109](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DashBoardPage/sub-pages/ImagesSubPage/ImagesSubPage.jsx#L109) and [DangerousWasteImagesPage.jsx:1311](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/DangerousWasteImagesPage/DangerousWasteImagesPage.jsx#L1311) gate the vote tally on a field nothing ever writes, so `users_voted` stays empty and user votes are ignored in that display — only admin votes count. Two-character fix, but check whether anything downstream now depends on the current behavior.

**`updateHighestVotedEval` writes to the document that triggered it**, with no guard comparing old and new values ([functions/index.js:333-366](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/index.js#L333-L366)). A write that changes nothing still fires `onUpdate`. Worth verifying in the logs that this isn't looping.

**Counters use read-then-write instead of `FieldValue.increment`** ([functions/index.js:57-78](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/index.js#L57-L78), and the `record_categories` votes in [UnitDataCacheContext.js:121-148](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L121-L148)). Two records landing in the same second both read `count: 5` and both write `6`. Usage numbers drift low over time.

**`getUsersInfo` passes an unbounded array to `where('user_id','in',...)`** ([dashboard.js:119](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/dashboard/dashboard.js#L119)), which Firestore caps at 30 values. Past that it throws and the function returns `{error: ...}` — actor names just disappear.

### Cost and performance

- **`updateInferenceTimeAverages` runs on every single record creation** and, each time, reads _all_ unit documents plus a collection-group query over 7 days of both record collections ([functions/index.js:110-126](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/index.js#L110-L126)). This is your most expensive code path by a wide margin, and it scales with traffic squared.
- **UnitsPage downloads every record a unit has ever produced** just to display "activations today" and "latest use" ([UnitsPage.jsx:37-42](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/pages/UnitsPage/UnitsPage.jsx#L37-L42)), because `getRecordsFromUnitRange` starts at the range's `start_date` with no limit. The legacy path used a server-side count for this; the display-unit path lost that.
- **`getWarnings` loops every unit with two sequential queries each** ([unitDataHooks.js:415-505](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/hooks/unitDataHooks.js#L415-L505)).
- **WeeklyUsagePage recomputes from raw records** what `admin/usage-by-day` already stores.
- The dashboard pulls a full year of records into the browser to draw four charts. It works today; it won't at 10× the record volume.

### Maintainability

- **"What are the categories" is implemented three times**: [unitCategories.js:47](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/common/unitCategories.js#L47) (the clean one, with tests), [UnitDataCacheContext.js:43](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L43) (a copy with `console.log`s), and [UnitDataParserContext.js:141-162](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataParserContext.js#L141-L162) (a third variant that omits `aris_custom_categories`). They already disagree.
- **`display_units` duplicates `deployment_config`** from the unit document, and RollOutPage has to write both. Any drift between them changes what the dashboard shows.
- **Schema typos are load-bearing**: `no_show_coloumns`, and the `waster_receiver_app_records` collection. Both are read in the app and named in the rules, so they can't be renamed casually — only migrated ([scripts/migrate_waste_receiver_app_records.py](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/scripts/migrate_waste_receiver_app_records.py) is the pattern).
- **`firebase.js` hardcodes the dev project** with no environment switching, so prod builds must be doing something outside the repo.
- **Heavy `console.log` in hot loops** (every record fetch logs its full output array) — noticeable in dev tools and a minor perf cost.
- **Timezones are inconsistent**: `usage-by-day` keys on UTC days ([functions/index.js:53](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/functions/index.js#L53)), the heatmap buckets on the browser's local `getDay()` ([UnitDataCacheContext.js:541](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L541)), and the migration script uses Europe/Copenhagen. The same activation can land on different days in different views.

# 6. Where I'd start reading

[UserContext.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UserContext.js) → [SecondHeaderContext.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/SecondHeaderContext.js) → [UnitDataCacheContext.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js) → [UnitDataParserContext.js](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataParserContext.js). That's the whole spine: who am I → which unit am I looking at → fetch its records → shape them into charts. Every page is a variation on it. [CONTEXT.md](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/CONTEXT.md) is the domain glossary and is genuinely accurate — read it before naming anything.

Say the word if you'd like this as a doc in the repo, or a diagram of the collection relationships


---

**1. `users/{uid}`** — the entry point ([UserContext.js:19](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UserContext.js#L19)). Fields that matter: `companies[]`, `location_companies[]`, `waste_receivers[]`, `isAdmin`, `company_memberships` (per-company permission flags), `language`.

Example 1:
![[Pasted image 20260811090113.png]]
Example 2:
![[Pasted image 20260811090129.png]]
**2. `companies/{companyId}`** — thin; mostly the `waste_receiver` coupling string. Access to a company comes either from `users.companies` containing it, or from the user being on a waste receiver whose `companies[]` lists it ([unitDataHooks.js:24-56](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/hooks/unitDataHooks.js#L24-L56)).

**3. `companies/{companyId}/locations/{locationId}`** — what the home page lists. Each location carries either a legacy `units[]` (array of unit ids) or `display_units[]`. A `display_unit` is a virtual unit: `{ unit_ranges: [{unit_id, start_date, end_date, current}], deployment_config, firstUse }`, so one dashboard tile can stitch together several physical machines over time ([SecondHeaderContext.js:81-124](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/SecondHeaderContext.js#L81-L124)). The URL `:unitId` is a real unit id in the legacy case and an **index into `display_units`** in the new case.

**4. `units/{unitId}`** — the config document: `company`, `deployment_config.classification.{class_names, fractions, category}`, `custom_categories`, `aris_custom_categories`.

**5. `units/{unitId}/inference-records/{recordId}`** — the actual data points behind every number on the dashboard. Relevant fields: `timestamp` (epoch ms), `eval` (the model's category), `is_test`, `user_evals: {uid: category}`, `admin_evals: {uid: category}`. All four cards (activations total, donut, weekly heatmap, activations-over-time) are computed client-side from one time-windowed fetch of this subcollection ([UnitDataCacheContext.js:429-435](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L429-L435)); for a display unit, one fetch per range, merged.

**6. `record_categories`** — `{unit, name, votes}`, one doc per unit+custom category. Only used to rank custom categories in the eval dropdown, not for the charts.

## How categories are derived

Two separate things: the **category axis** (which rows/slices exist) and the **category of a record**.

**The axis** — `getAllCategories(unit)` ([unitCategories.js:47-70](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/common/unitCategories.js#L47-L70)), the union, in order, of:

1. `unit.deployment_config.classification.class_names` — the model's classes
2. `unit.custom_categories` — added by customer users
3. `unit.aris_custom_categories` — added by ARIS admins
4. `UNDEFINED`, always appended, and reordered to sit last ([SecondHeaderContext.js:40-47](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/SecondHeaderContext.js#L40-L47))

For display units, `deployment_config.classification` from the location's `display_units` entry **overrides** the unit doc's ([SecondHeaderContext.js:23-38](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/SecondHeaderContext.js#L23-L38)).

**Per record** — depends on the `showUserEvaluations` toggle (ThirdHeaderContext):

- **Off**: category = `record.eval` straight from the document.
- **On**: majority vote over `record.user_evals` values; a tie becomes `"Uafgjort"`, no votes falls back to `record.eval` for the donut/activations and to `"Ikke vurderet"` for the heatmap and bar chart ([UnitDataParserContext.js:71-120](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataParserContext.js#L71-L120)).

Two behaviors worth knowing since they're easy to misread as bugs:

- **The axis is a whitelist filter, not just a label set.** Records whose `eval` isn't in `getAllCategories` are dropped from the fetch entirely, so they don't count toward the activations total either ([UnitDataCacheContext.js:446-452](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataCacheContext.js#L446-L452)). Dangerous-waste units bypass this because their evals are object shapes, not class names ([unitCategories.js:76](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/common/unitCategories.js#L76)).
- **The parser rebuilds its own axis** from `class_names` + `custom_categories` only — `aris_custom_categories` are not seeded there, so admin-only categories appear only if a record actually lands on them ([UnitDataParserContext.js:141-162](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataParserContext.js#L141-L162)).

Colors come off a separate list (`categoryNames` = `class_names` + custom eval categories + leftover `fractions`), with `UNDEFINED`, `"Kan ikke vurderes"`, and `"Ikke vurderet"` pinned to fixed greys ([UnitDataParserContext.js:59-69](vscode-webview://1q0mks9ubatnfn625rvr7no03n2520e9qduorfollisgff89bf59/react-app/src/contexts/UnitDataParserContext.js#L59-L69)).

## The dangerous-waste line is a different path

When `deployment_config.category == 'dangerous_waste'`, records live in `units/{id}/dangerous-waste-records` or `company_app_records/{companyId}/dangerous-waste-records` (mobile app scans), and there is no category axis at all — rows are grouped by the composite key formed from `waste_receivers/{id}.grouping_columns`, per CONTEXT.md's "Record Group" definition.