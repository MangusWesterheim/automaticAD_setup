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


