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
![[Pasted image 20260204215246.png]]
- Tryk `Tilføj trigger`
- Indstil trigger til følgende indstillinger:
![[Pasted image 20260313165807.png]]
- Tryk `Gem`
- Nu får du sikkert denne besked:
![[Pasted image 20260313165915.png]]
- Det sker fordi vi skal give `Apps Script` lov til at sende emails på vegne af Robrådet (`robraadet.sdu@gmail.com`)
- Tryk på `Advanced` -> `Go to Auto update forms (unsafe)`
- Tryk på `Allow`
![[Pasted image 20260313170127.png]]

Du burde nu se en en trigger poppe op. 
## 9) Offentligør forms
For at kunne teste email service skal forms dokumentet offentligøres.
![[Pasted image 20260313171100.png]]

## 10) Test email service
Udfyld en forms tilmelding med dine kontakt informationer og tryk indsend.
Hvis alt går vel burde du se dine informationer i google `Sheets`
Eksempel:
![[Pasted image 20260313171747.png]]

Så er tanken at så snart en deltager har betalt på mobilepay så skriver man `Yes` i `Paid?` kolonnen:
![[Pasted image 20260313171855.png]]
Og hvis alt så går som det skal burde der poppe et tidsstempel op når mailen er sendt.
![[Pasted image 20260313172226.png]]
Bekræft også at mailen går igennem:
![[Pasted image 20260313172203.png]]

SÅDAN! Hvis du nåede det hertil fejlfrit burde hele moletjavsen være klar til et fedt event :D


## Troubleshooting
### Der sker ikke noget efter jeg har skrevet `yes` i `Paid ?` kolonnen
Der er en rigtig god debugging side i `Apps Scrips` under `Udførelser` her:
![[Pasted image 20260313172430.png]]
Her kommer hver enkelt trigger ind og man kan så se fejlkoden hvis de ikke gik igennem.
Eksempelvis fik jeg den her da jeg prøvede at teste det uden at have offentliggjort `Forms`:
![[Pasted image 20260313172604.png]]
Og hvis fejlen ikke giver mening er Chatten til god hjælp.

### Hvis alt andet fejler
Chatten er ret god til den her så giv den lige et skud med kontekst fra scriptet og hvad du har prøvet.