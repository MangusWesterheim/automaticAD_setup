# Prosjektplan 

### Introduksjon
I dette prosjektet skal vi designe og implementere en organisasjonsstruktur for et fiksjonelt hotell (navn på hotell). Organisasjonsstrukturen skal settes opp i Active Directory på en domenekontroller ved bruk av PowerShell-skript. Dette vil også innebære å legge til tre andre maskiner i domenet, samt lage "organizational units”, brukere, grupper og “group policies”. Hvordan organisasjonen settes opp i Active Directory vil demonstreres i en kort film. 

### Prosjektbegrunnelse
* **Hensikt**
    *  Lære om hvordan en setter opp et mindre AD-miljø i en fiktiv bedrift.   
* **Effektmål**
    * Kompetanse innenfor planlegging, oppsett og utførelse av et Windows AD-miljø. Kunnskaper om skripting og automatisering av ulike oppgaver i Powershell. 
    * Kompetanse innenfor samhandling med bruk av Git. 
* **Resultatmål**
    * Ha skript som setter opp et Active Directory-miljø med gjeldende best-practices og anbefalinger for Grunnprinsipper for IKT-sikkerhet av NSM.
    * Videopresentasjon som presenterer prosjektet og skriptene 
    * Sluttrapport som går gjennom utfordringer langs veien og hvordan vi løste dem. 


### Prosjektgjennomføring
Prosjektbeskrivelsen fastsetter noen aktiviteter og oppgaver som må med i gjennomføringen av prosjektet: 

* **Overordnene aktiviteter** 
    * Lage organisasjonskart 
    * Powershell-skript som automatiserer AD-setup 
    * Videopresentasjon  
    * Lage sluttrapport 

### Prosjektfaser:

* **Idefasen - UKE 9**
    * Forstå hva oppgaven spør om
    * Diskutere mulige løsninger på oppgaven
    * Komme til enighet om løsning av oppgaven

* **Oppstart og konkretisering av oppgaven/prosjektet – UKE 9/10**
    * Fastsetting av ideen - skript/produkt
    * Oppretting av timeplan
    * Lage oversikt over arbeidsoppgaver 
    * Fordele arbeidsoppgaver

* **Designe organisasjonsstrukturen: PowerShell scripts - UKE 10/11**
    * Utarbeide organisasjonsstrukturen, OUer, aksesskontroll, group policies. 

* **Ferdigstilling av prosjektet - UKE 11**
    * Planlegge og lage videopresentasjon
    * Sluttrapport 

### Timeplan 

|  | Mandag | Tirsdag | Onsdag | Torsdag | Fredag | Lørdag | Søndag |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| **Uke 9** |  |  | 15:15-17:00 |  |  |  |  |
| **Uke 10** | | 14:15-16:00 | 18:15-20:00 |  | |  |  |
| **Uke 11** | 08:15-09:00 | 14:15-16:00 | 08:15-12:00 |  | 08:15-12:00  |  |  |

### Roller
* Sekretær: Skrive møtereferater 
    * Sara
* Møteinnkalling: Kalle inn til møter med agenda, og booke rom for møtet 
    * Magnus
* Koordinator: Ha oversikt over at vi følger planen og at alt blir gjort. 
    * Daniel
* Kontaktperson
    * Markus

Utover disse rollene har vi valgt å ha en flat struktur uten noen leder, fordi vi legger opp til å arbeide mye sammen og sammen bli enig om fordeling av arbeidsoppgaver.  


***


# Møtereferat 8. mars

1. Finne ut hva vi må gjøre
* Vi begynner med samme infrastruktur.
* Følger kompendiet først (bare minimum) og legger til andre ting senere.

Oversikt sammen over hva som må gjøres, de ulike stegene:

 1) Sette opp infrastrukturen, AD og joine maskiner
 2) Sette opp OUer (Sara)
 3) Opprette brukere (NB: ikke tilfeldig fordeling i OUer) (Magnus)
 4) Opprette grupper (Daniel)
 5) Sette opp Group Policies (Markus)

Kan se på hvordan NTNU har gjort det for inspirasjon:
* Last ned AD-explorer (funker ikke så bra på Mac). 

2. Fordele arbeid
Fordeler punkt 2-5 mellom oss (se fordeling over):

: Alle leser seg opp på sitt punkt og samler et basic skript fra kompendiet, og ser evt. hva som må endres med tanke på vår bedrift/infrastruktur (og evt. om det er noe vi kan legge til, men dette kan vi også se på senere). 

Husk å kommentere/notere det vi gjør (til rapporten) og henvise til NSMs grunnprinsipper for IKT-sikkerhet.

3. Bli enig om GIT-kommentering
* ‘docs’ for dokumentet
* ‘feat’ for feature
* ‘fix’ da fikser du en ting
* Eksempel – endre på formatering: ‘docs: update formatting/spellcheck/etc.’

4. Til neste gang/på neste møte (onsdag 9. mars)
* Alle ser på sin del av oppsettet av infrastrukturen (se over).
* Finne navn til hotellet




# Møtereferat 2.mars

1. Gå igjennom prosjektet/prosjektbeskrivelsen, bli enig om bedrift
* Bedrift for prosjekt: Hotell

2. Møtetider
* Faste møter tirsdager 14.15-16.00, i tillegg til andre møter når det passer for alle. Se prosjektplan for oversikt over alle møter.

3. Roller
* Alle får hver sin administrative rolle. Se prosjektplan for oversikt. Fordeling av arbeidsoppgaver relatert til prosjektet tar vi stilling til fortløpende.

4. Prosjektplan og organisasjonskart
* Skriver prosjektplan sammen og laster opp i git. 
* Finner inspirasjon til organisasjonskartet på nett, Markus ordner dette til neste gang. 

5. Annet
* Git – commentaire conventions (se link i discord), alle setter seg inn i dette.

6. Til neste gang:
* Markus ordner organizational chart
* Alle setter seg inn i GIT, og kloner repoet.


-------------


# Møtereferat 9.mars

1. Finne ut hva vi trenger av Group Policies, grupper, brukere og OUer.

* Mest hensiktsmessig å først lage GPer og så OUer basert på grupper og GPer. 


### Group policy

* Generell GP som fungerer for alle datamaskiner (brukere), folder i direction, ikke alle har en fast PC på hotellet. Brukermappa lages ikke lokalt, men på en server, så de har tilgang til dokumenter 

* GP for Internet explorer, chrome, edge.

* GP for Office, lage template så det blir ‘applayet’ automatisk (maler for bedriften)

* Baseline policy for klient-sikkerhet.

* En policy for Preferences som brukeren kan endre (ulikt fra Policy som er låst) – preference for baseline.

* App blocker, kun godkjente programmer skal få kjøre

* NPS - network policy server

* Pushe ut lokal admin, hvis lokal bruker skal ha admin rettigheter (for eksempel IT-brukere, som vil ha full tilgang til å gjøre ting på maskinen)

* Desktop settings (bakgrunn, taskbar, hvordan man skal pushe ut snarveier på skrivebordet)

* Servere, policy som låser serveren ned. 

(AVANSERT: 10. Rotserver med sertifikat og ruller ut sertifikat til hver PC …)

=> Prøver å samle de litt: Baseline trenger ikke å være så streng og kan være til alle maskinene. Desktop settings.


### Grupper

Vi lager en egen OU for grupper for å få mer oversikt, som i stor grad vil følge OUene. 

Eksempler/ideer: 


* **Idefasen - UKE 9**
    * Forstå hva oppgaven spør om
    * Diskutere mulige løsninger på oppgaven
    * Komme til enighet om løsning av oppgaven

* **IT-rettigheter**
    * Klient-admin, pushes ut med GP. En separat gruppe som gir tilgang til å logge på med full admin rettigheter til domenet. (Samme med servere)

* **Sikkerhetsgruppe for økonomi-avdelingen (og for ulike avdelinger) med shares og lignende. Automatisere shares så de blir automatisk lagt til på PCen.**
    * Markedsføring
    * Økonomi
    * ??

* **Tillate for trådløst nett**

* ** RDP-tilgang**

Vi må lage grupper sånn at ingen har tilgang til ALT. Domene-admin rollen skal deles opp i mindre rettigheter. 
- Helpdesk som har lov til å endre passord/opprette bruker. 


## Brukere

Generere en CSV-fil med navn og passord og legge det inn via et annet script. 

Oppsett av brukere og tildeling av grupper:
* CSV-fil som importeres inn. Vi setter hvilken avdeling de skal tilhøre, istedenfor å generere det tilfeldig i et script. 

Hva skal (kan) være i CSV-fila:
Navn, tittel, telefon, ansatt iD, mail, beskrivelse, OU, grupper, enablet, passord.

Kan ta utgangspunkt i det scriptet som Erik har lagd til å generere random brukere osv. 


### OUer

* Dele computers og users
* Dele inn i subOUer

Overordnet inndeling (Grafisk utkast til OU-design ligger i sharepoint), tre hoved-OUer:

1. Computers 
    – Klienter (kiosk og ansatte)
    – Servere
2. Users
    – Flere sub-OUer.
3 Groups
    – IT
    – Flere sub-OUer?


### Avanserte tillegg

AVANSERT: rulle ut oppdateringer (NPS går litt over det)
AVANSERT: sette opp et intranett med autentisering


2. Til neste gang/På neste møte
* Lese seg opp på GP best practices
* Begynne på skriftene.


