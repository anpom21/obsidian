Hvis man skal bruge person tilmelding og betaling så kan denne guide bruges til at tage imod tilmeldinger gennem google forms og samtidig sende en confirmation email når betaling er modtaget.

## 1) Log ind med google konto
Email: `robraadet.sdu@gmail.com`
Kodeord:  


## 2) Kopier dokumenter
Naviger til `Template - Event Registration`, så burde du se:
![[Pasted image 20260204210757.png]]
Disse skal bare kopieres og omdøbes. Eksempel:
![[Pasted image 20260204210828.png]]

## 3) Knyt Sheets til Forms
Det næste skridt er at knytte `Sheets` med `Forms` dokumentet. 
- Åben `Forms`
- Tryk på `svar`
- Tryk på `Knyt til Sheets`
- Tryk på `Vælg et eksisterende regneark`
- Vælg det omdøbte `Sheets` dokument 
![[Pasted image 20260204211751.png]]
![[Pasted image 20260313161608.png|640]]
## 4) Åben `Apps Script` i `Sheets`
Find den under.
- -> `Udvidelser`-> `Apps Script`
![[Pasted image 20260204213024.png]]
Når den har åbnet burde du se noget lignende:
![[Pasted image 20260313163112.png]]
**!!!!!!!!OBS!!!!!!!!!** 
Hvis du får en fejl her og siden ikke vil loade så log ind igen i privat/ incognito browser.

## 5) Forbind `Apps Scripts` med `Sheets` og `Forms`

For at forbinde `Apps Scripts` med `Sheets` og `Forms` skal 3 ID'er hentes. De kan alle findes i URL'et til `Sheets` eller `Forms`.
- `SHEET_ID`
- `TAB_ID`
- `FORMS_ID`
`SHEET_ID` og `TAB_ID` kan findes i `Sheets` URL. Eksempel:
![[Pasted image 20260313163905.png]]
`FORMS_ID` kan lige ledes findes i `Forms` URL. Eksempel:
![[Pasted image 20260313163725.png]]
Nu kan de 3 ID'er
`SHEET_ID = 1ScPs07XmhQi_Orlmkszh6QleLMcP1fDJhtOPVD9MZVc`
`TAB_ID = 765643494`
`FORMS_ID = 1nPzhUTQMuYbC-x_J5Ge0lxvviDzkQiy11FphkkDno0Q`
Indsættes i `Apps Script`:
![[Pasted image 20260313164249.png]]

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
- Time: 19:00 - 21:00
- Location: Papas papbar
- Payment: 50 DKK
Then a desired email could look like:
```java
/***** EMAIL *****/
// Email Subject // UPDATE THIS
const SUBJECT = "🎲 Robrådet Board game registration confirmation";

  
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