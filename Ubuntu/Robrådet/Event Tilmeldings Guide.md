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
![[Pasted image 20260313162307.png]] 

**!!!!!!!!OBS!!!!!!!!!** 
Hvis du får en fejl her og siden ikke vil loade så log ind igen i privat/ incognito browser.

## 5) Forbind `Apps Scripts` med `Sheets` og `Forms`

For at forbinde `Apps Scripts` med `Sheets` og `Forms` skal 3 ID'er hentes. 
- Spreadsheet ID
- Sheet ID
- Forms ID
