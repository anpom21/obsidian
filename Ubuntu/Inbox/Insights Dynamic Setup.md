---
created: 2026-06-09
tags:
source:
aliases:
---

Setup
- Kolonner og kolonne visnings navn
- Skjulte kolonner
- Oplæste kolonner

## Dynamic columns


## Skjulte kolonner:
From now on the sortinglist shown in @sortinglist should show all available columns from the firebase sortinglist, but hidden columns / no_show_columns should be shown with a dark grey tint.
## Run insights locally
```
cd react-app
npm start
```
Open http://localhost:3000

## APP
Repo summary
`/home/ap/Repositories/wade-system-dangerous-waste-mobile`

> **System prompt** → [src/constants/prompt.txt](vscode-webview://0qu18l05b07t3985b5aesvfn0gi072jikio6mmecih9b54hms696/src/constants/prompt.txt). It's a plain text file bundled as an Expo asset. It gets assembled at runtime in [classificationAssets.ts:15](vscode-webview://0qu18l05b07t3985b5aesvfn0gi072jikio6mmecih9b54hms696/src/services/classificationAssets.ts#L15) as: `prompt.txt` + the Firestore sorting list (TSV) + a hard-coded trailing paragraph about the JSON keys. So if you want to change the JSON-output rules, note that rule 3 in `prompt.txt` and that trailing paragraph both cover it — edit both. Changes to `prompt.txt` require a rebuild/redeploy (it's bundled, not fetched).

>**Sorting list** → not in the repo. It lives in Firestore at `waste_receivers/{wasteReceiverId}.sorting_list.sorting_items` ([firebaseSortingList.ts:19-45](vscode-webview://0qu18l05b07t3985b5aesvfn0gi072jikio6mmecih9b54hms696/src/services/firebaseSortingList.ts#L19-L45)), reloaded on every classification, so edits there take effect without a rebuild. The `wasteReceiverId` comes from the logged-in user's `waste_receivers` field ([App.tsx:188](vscode-webview://0qu18l05b07t3985b5aesvfn0gi072jikio6mmecih9b54hms696/App.tsx#L188)).

> To preview it, open the Firestore console for project `aris-platform-dev`: `https://console.firebase.google.com/project/aris-platform-dev/firestore/data/~2Fwaste_receivers`

> The app itself only shows the receiver name + `sorting_list.version` line at the bottom of the screen — there's no in-app list view. If you want a `npm run print:sorting-list` script that logs in and dumps the exact TSV the model sees, say the word and I'll add it.

> **Your deploy error** was the npm-exec arg passing: `npm exec firebase-tools hosting:channel:deploy …` handed everything after the package name to npm, not to firebase. I fixed all three scripts in [package.json:12-14](vscode-webview://0qu18l05b07t3985b5aesvfn0gi072jikio6mmecih9b54hms696/package.json#L12-L14) by inserting `--`:

```
npm exec firebase-tools -- hosting:channel:deploy dev-preview --expires 7d
```

>You'll also need `npx firebase login` once if you haven't. Note `npm exec firebase-tools` re-downloads firebase-tools 15.x each time (it's not a devDependency) — worth adding to `devDependencies` if you deploy often.

### Idea
Prompt and sorting list should be fetched whenever a new version is detected in the cloud.