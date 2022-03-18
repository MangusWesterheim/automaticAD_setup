# Active Directory – Hotell Contoso

[[_TOC_]]

## Prosjektbeskrivelse
I dette prosjektet har vi lagd og implementert Active Directory med en organisasjonsstruktur for det fiktive hotellet "Contoso", et middels stort hotell med ... ansatte, som vist i [organisasjonskartet](LINK).

### Mål
Målet med prosjektet er å lage og kjøre script/kommandoer i PowerShell som vil sette opp en fungerende organisasjonsstruktur/AD-struktur for hotellet Contoso. Oppsettet av AD-strukturen er presentert i en instruksjons-[video] (LINK). 

Utover den grunnleggende infrastrukturen (OUer, grupper, brukere og group policies) har vi som mål å implementere noen ekstra funksjoner/...: ...

Se mer i [prosjektplan](LINK).


## Design og struktur
AD-strukturen er inndelt i fire topp-OUer, for AllUsers (alle ansatte), Clients og Servers (PCer og tjenere) og Groups (alle gruppene). Se den [grafiske] fremstillingen av strukturen for en oversikt over hierarkiet i de fire topp-OUene. 

Grupper har blitt lagt i sin egen OU for mer oversikt, men følger i stor grad ... 
Brukere ..
Maskinene har fått to topp-OUer, én for tjenere (SRV1) og en for klienter (MGR og CL1).

Se mer under [refleksjon](#toc_?)
 

### Navnekonvensjon 


## Script (og videomanual?)
De ulike scriptene .... Noen av scriptene leser fra csv-filer...automatisering. Switch?


## Refleksjon


### Script
#### Utfordringer og løsninger

**Opprettelse av OUer og flytting av maskiner fra container til OU:**
* Under testing av opprettelsen av organizational units ga 'Remove-ADOrganizationalUnit' feilmeldingen 'Access denied...' – løsning: -ProtectedFromAccidentalDeletion må settes til $false.

* Prøvde å finne en måte å flytte MGR og CL1 fra container til OU samtidig, men dette krevde en loop. Det var dermed mer hensiktsmessig å flytte én og én for å sikre at de to riktige maskinen ble flyttet.

* Fikk ikke lagd OU med navn "Computers" fordi containeren "Computers" har samme navn – Løsning: lage to topp-OUer ("Clients" og "Servers") istedenfor "Computers".
   * Følgeproblem: Omdirigeringen fra 'Computers'-containeren må endres – Løsning: I og med at det i de fleste tilfeller vil være snakk om klienter som joiner domenet, ble omdirigeringen endret til "Clients"-OUen.

* Tok utgangspunkt i script fra [denne siden] (https://activedirectorypro.com/create-bulk-organizational-units-ou-in-active-directory-with-powershell/). Fikk feilmelding om at parameteren 'Name' var tom. – Løsning: fjerne det ene trinnet med kopiering over i variabel (samt legge til -Delimiter ";"). 

### Gruppearbeid 
Vi startet med å lage en [prosjektplan](LINK) hvor administrative roller ble fordelt, mål for prosjektet ble satt og  ...

Gjennom prosjektet har vi hatt jevnlige møter for å planlegge og delegere oppgaver, samt for å jobbe sammen på prosjektet. Vi har hatt en tydelig fordeling av ansvarsområder/oppgaver fra start, men de hyppige møtene har gjort at vi hele tiden har kunnet følge med på hva hverandre gjør. Dette har vært en god løsning både fordi de ulike scriptene/delene av AD-strukturen henger tett sammen, og med tanke på å kunne hjelpe hverandre noe som har vært helt essensielt på grunn av ulike forkunnskaper i gruppa. 

For mer informasjon om prosessen se [møtereferater og prosjektplan](LINK).


## Konklusjon
