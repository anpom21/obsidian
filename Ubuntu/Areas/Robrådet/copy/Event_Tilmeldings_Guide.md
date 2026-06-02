# Event Tilmeldings Guide

Hvis man skal bruge person tilmelding og betaling så kan denne guide bruges til at tage imod tilmeldinger gennem google forms og samtidig sende en confirmation email når betaling er modtaget.

## Indholdsfortegnelse

- [1) Log ind med google konto](#1-log-ind-med-google-konto)
- [2) Kopier dokumenter](#2-kopier-dokumenter)
- [3) Knyt Sheets til Forms](#3-knyt-sheets-til-forms)
- [4) Åben Apps Script i Sheets](#4-åben-apps-script-i-sheets)
- [5) Forbind Apps Scripts med Sheets og Forms](#5-forbind-apps-scripts-med-sheets-og-forms)
- [8) Enable email trigger](#8-enable-email-trigger)
- [9) Offentligør forms](#9-offentligør-forms)
- [10) Test email service](#10-test-email-service)
- [Troubleshooting](#troubleshooting)
- [Debugging](#debugging)

## 1) Log ind med google konto

Email: `robraadet.sdu@gmail.com`

Kodeord: **spørg bestyrelsen**

## 2) Kopier dokumenter

Naviger til `Template - Event Registration`, så burde du se:
![template-event-registration-folder-overview.png](template-event-registration-folder-overview.png)

Disse skal bare kopieres og omdøbes. Eksempel:

![copied-and-renamed-google-files.png](copied-and-renamed-google-files.png)

## 3) Knyt Sheets til Forms

Det næste skridt er at knytte `Sheets` med `Forms` dokumentet.

- Åben `Forms`
- Tryk på `svar`
- Tryk på `Knyt til Sheets`
  ![forms-link-to-sheets-response-tab.png](forms-link-to-sheets-response-tab.png)
- Tryk på `Vælg et eksisterende regneark`
  ![forms-select-existing-spreadsheet.png](forms-select-existing-spreadsheet.png)
- Vælg det omdøbte `Sheets` dokument

`Forms` burde åbne `Sheet` automatisk, og når den gør det så sørg for at tilføje 2 felter nemlig:

- `Paid ?` - Bruges til manuelt at angive om betaling er modtaget.
- `Email Sent At` - Når en email er send succesfuldt vil et timestamp komme ind her
  Efter kolonnerne er tilføjet burde det ligne det her:
  ![sheets-paid-and-email-sent-columns.png](sheets-paid-and-email-sent-columns.png)

## 4) Åben `Apps Script` i `Sheets`

Find den under.

- -> `Udvidelser`-> `Apps Script`
  ![sheets-open-apps-script-menu.png](sheets-open-apps-script-menu.png)
  Når den har åbnet burde du se noget lignende:
  ![apps-script-editor-initial-view.png](apps-script-editor-initial-view.png)
  **!!!!!!!!OBS!!!!!!!!!**

  Hvis du får en fejl her og siden ikke vil loade så log ind igen i privat/ incognito browser.

## 5) Forbind `Apps Scripts` med `Sheets` og `Forms`

For at forbinde `Apps Scripts` med `Sheets` og `Forms` skal 3 ID'er hentes. De kan alle findes i URL'et til `Sheets` eller `Forms`.

- `SHEET_ID`
- `TAB_ID`
- `FORMS_ID`

`SHEET_ID` og `TAB_ID` kan findes i `Sheets` URL. Eksempel:
![sheets-url-sheet-id-and-tab-id.png](sheets-url-sheet-id-and-tab-id.png)
`FORMS_ID` kan lige ledes findes i `Forms` URL.

Eksempel:
![forms-url-form-id.png](forms-url-form-id.png)
Nu kan de 3 ID'er

- `SHEET_ID = 1ScPs07XmhQi_Orlmkszh6QleLMcP1fDJhtOPVD9MZVc`
- `TAB_ID = 765643494`
- `FORMS_ID = 1nPzhUTQMuYbC-x_J5Ge0lxvviDzkQiy11FphkkDno0Q`

Indsættes i `Apps Script`:
![apps-script-insert-sheet-tab-form-ids.png](apps-script-insert-sheet-tab-form-ids.png)

## 7) Configure email.

The default template email is:

```java
/***** EMAIL *****/
// Email Subject // UPDATE THIS
const SUBJECT = "EMOJI Robrådet XX registration confirmation";


// Email Body // UPDATE THIS
function renderBody_(name) {
return `Hi ${name},

Your registration to the Robrådet XX event and YY DKK payment has been confirmed.

<strong>Event details:</strong>
📅 <strong>Date:</strong> dd mm
🕕 <strong>Time:</strong> tt:tt - TT:TT
📍 <strong>Location:</strong> Location

EMOJI <strong>What to bring:</strong> Student ID.

Bla bla bla

If you have any questions or can no longer attend, please contact us at 👉 robraadet@sdu.dk


See you there,
Robrådet - Robotics Student Council`;
}
```

Lets say i want to host a boardgame night with the following details:

- Participants: 30
- Date: 13/3/2026
- Time: 19:00 - 21:00
- Location: Papas papbar
- Payment: 50 DKK
  Then a desired email could look like:

```java
/***** EMAIL *****/
// Email Subject // UPDATE THIS
const SUBJECT = "🎲 Robrådet board game event confirmation";


// Email Body // UPDATE THIS
function renderBody_(name) {
return `Hi ${name},

Your registration to the Robrådet board game event and 50 DKK payment has been confirmed.

<strong>Event details:</strong>
📅 <strong>Date:</strong> 13-03-2026
🕕 <strong>Time:</strong> 19:00 - 21:00
📍 <strong>Location:</strong> Papas Papbar (Sankt Knuds Kirkestræde 2, 5000 Odense)
🎲 <strong>What to bring:</strong> Student ID.

Bring your best luck for this awesome board game night.

If you have any questions or can no longer attend, please contact us at 👉 robraadet@sdu.dk


See you there,
Robrådet - Robotics Student Council`;
}
```

### HUSK AT TRYKKE GEM!!

## 8) Enable email trigger

To make the emailing process semi-automatic a trigger needs to be setup to run the script every time the sheets document is edited - dont worry it will only send an email if the paid column gets a new `Yes` entry.

- Tryk på `Triggers`
  ![apps-script-open-triggers-menu.png](apps-script-open-triggers-menu.png)
- Tryk `Tilføj trigger`
- Indstil trigger til følgende indstillinger:
  ![apps-script-trigger-settings.png](apps-script-trigger-settings.png)
- Tryk `Gem`
- Nu får du sikkert denne besked:
  ![apps-script-authorization-required.png](apps-script-authorization-required.png)
- Det sker fordi vi skal give `Apps Script` lov til at sende emails på vegne af Robrådet (`robraadet.sdu@gmail.com`)
- Tryk på `Advanced` -> `Go to Auto update forms (unsafe)`
- Tryk på `Allow`

![apps-script-allow-unsafe-access.png](apps-script-allow-unsafe-access.png)

Du burde nu se en en trigger poppe op.

## 9) Offentligør forms

For at kunne teste email service skal forms dokumentet offentligøres.
![forms-publish-form.png](forms-publish-form.png)

## 10) Test email service

Udfyld en forms tilmelding med dine kontakt informationer og tryk indsend.
Hvis alt går vel burde du se dine informationer i google `Sheets`

Eksempel:
![sheets-registration-response-example.png](sheets-registration-response-example.png)

Så er tanken at så snart en deltager har betalt på mobilepay så skriver man `Yes` i `Paid?` kolonnen:
![sheets-mark-paid-yes.png](sheets-mark-paid-yes.png)
Og hvis alt så går som det skal burde der poppe et tidsstempel op når mailen er sendt.
![sheets-email-sent-timestamp.png](sheets-email-sent-timestamp.png)
Bekræft også at mailen går igennem:
![confirmation-email-received.png](confirmation-email-received.png)

SÅDAN! Hvis du nåede det hertil fejlfrit burde hele moletjavsen være klar til et fedt event :D

**Hvis det ikke virker i første hug** så er det tit fordi at kolonne titlerne:
![sheet-column-headers-must-match.png](sheet-column-headers-must-match.png)
Ikke matcher med `COL`variablen i `Confirmation email.gs`:

![confirmation-email-gs-col-variable.png](confirmation-email-gs-col-variable.png)

Sørg for at de matcher 1:1, og til sidst er det også vigtigt at forms felterne:
![forms-fields-match-sheet-columns.png](forms-fields-match-sheet-columns.png)

Også matcher med kolonnerne (men det burde de hvis templaten bare er kopieret.)

## Tilføj flere user inputs.

Man kan også tilføje flere user inputs hvis brugeren f.eks skal tilføje mad ønske til en julefrokost eller lignende.  
For at kunne bruge disse inputs i emailen f.eks skal følgende ændres:

- `COL` variabel
- `renderBody_(name, <NEW_INPUT>)`
  Det anbefales at bruge chatten til at få lidt hjælp her.

# Troubleshooting

### Debugging

Der er en rigtig god debugging side i `Apps Scrips` under `Udførelser` her:
![apps-script-executions-debugging-page.png](apps-script-executions-debugging-page.png)
Her kommer hver enkelt trigger ind og man kan så se fejlkoden hvis de ikke gik igennem.
Eksempelvis fik jeg den her da jeg prøvede at teste det uden at have offentliggjort `Forms`:
![apps-script-form-not-published-error.png](apps-script-form-not-published-error.png)

Og hvis fejlen ikke giver mening er Chatten til god hjælp.

Og sådan her ser en korrekt udførelse ud:
![apps-script-successful-trigger-execution.png](apps-script-successful-trigger-execution.png)
![apps-script-successful-execution-details.png](apps-script-successful-execution-details.png)
Denne besked kan også komme ind i mellem men den er ufarlig så længe de andre triggers kører fint:
![apps-script-harmless-intermittent-message.png](apps-script-harmless-intermittent-message.png)

### Hvis alt andet fejler

Chatten er ret god til den her så giv den lige et skud med kontekst fra scriptet og hvad du har prøvet.
