[[_TOC_]] 

 

# Rapport: Active Directory – Hotell Contoso 

 

## Prosjektbeskrivelse 

I dette prosjektet har vi lagd og implementert Active Directory med en organisasjonsstruktur for det fiktive hotellet Contoso, et middels stort hotell med 100 ansatte. 

 

### Mål og gjennomføring 

Det overordnede målet med prosjektet er å implementere Active Directory for det fiktive hotellet Contoso i henhold til punktene i [prosjektbeskrivelsen](https://gitlab.com/erikhje/dcsg1005/-/blob/master/project-ad.md). 

På bakgrunn av prosjektbeskrivelsen har vi formulert hensikt-, effekt- og resultatmål, samt en plan for hvordan vi skal gjennomføre alle delene av prosjektet. Dette finnes i [prosjektplanen](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/MINUTES.md), som ble skrevet på begynnelsen av prosjektperioden.  

 

## Design og struktur 

En essensiell del å sette opp et AD-miljø er implementering av organizational units, grupper, brukere og group policies. AD-strukturen er delt i fire topp-OUer, én for [brukere](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/img/ou_users.png) (alle ansatte), to for [maskiner](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/img/ou_computers.png) (for klienter og servere) og én for [sikkerhetsgrupper](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/img/ou_groups.png) (linker til grafisk fremstilling av OU-hierarkiene).  

  

### Navnekonvensjon for grupper og group policy  

Navngiving av sikkerhetsgrupper skiller mellom “dl_” for domenelokale grupper og “G_” for globale grupper. Videre følger gruppene ellers OU-strukturen for maskiner og til slutt en indikasjon på gruppas funksjon/medlemmer (e.g., dl_it_client_localadmin). Gruppene for filtilgang starter med “file_” (de er alle domenelokale, “dl_” er derfor utelatt), og følger deretter OU-strukturen for brukere med navn på avdeling og til slutt en beskrivelse som indikerer hvilken share gruppemedlemmene har tilgang til (e.g., file_adm_logistics). 

Group policy objects følger også en satt navnekonvensjon for å gjøre identifisering lettere. For eksempel så skiller en mellom policy objects for klienter, servere og brukere. Policyen “CONTOSO-CLIENT_AppLocker” en datmaskinpolicy som er tilknyttet klientmaskiner. Brukerpolicyer navngis på en lignende måte, men da som for eksempel “CONTOSO-USER_RelevantPolicy”. 
 

## Refleksjon  

### IKT-sikkerhet			 

Ved siden av å gjøre organisasjonsstrukturen mer oversiktlig, er et godt AD-miljø nøkkelen til å en sikker infrastruktur. [Active Directory “skogen” fungerer som sikkerhetsgrensen](https://gitlab.com/erikhje/dcsg1005/-/blob/master/compendia.md#thinking-security) til, i vårt tilfelle, Contoso-infrastrukturen. Den digitale utviklingen har skjedd raskt, og en ser nå at det ikke lenger er nok å kun fokusere på perimetersikring, da det likeså godt kan finnes trusler på innsiden. I utviklingen av AD-strukturen for hotell Contoso har vi derfor forsøkt å ha en zero trust-tankegang ved å forholde oss aktivt til [NSMs grunnprinsipper for IKT-sikkerhet](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/introduksjon-1/), spesielt [kapittel 1 – Identifisere og kartlegge](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/identifisere-og-kartlegge/kartlegg-styringsstrukturer-leveranser-og-understottende-systemer/) og [kapittel 2 – Beskytte og opprettholde](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/ivareta-sikkerhet-i-anskaffelses-og-utviklingsprosesser/).  

Arbeidet med prosjektet startet med å lage et [organisasjonskart](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/img/Org_Chart_V2.png) for hotell Contoso, og ut ifra det [kartlegge brukere og behov for tilgang](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/identifisere-og-kartlegge/kartlegg-brukere-og-behov-for-tilgang/). Dette la til rette for utviklingen av AD-miljøet for hotellet, bestående av OUer, sikkerhetsgrupper og group policies som vi har brukt for å dele opp IKT-systemet “avhengig av tillitsnivå”([2.2](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/etabler-en-sikker-ikt-arkitektur/)) og for å få oversikt og kontroll over “identiteter og kontoer”([2.6](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/ha-kontroll-pa-identiteter-og-tilganger/)). Spesifikke tiltak vi har implementert er blant annet: 

* Dele opp domenearkitekturen slik at servere (SRV1) og klienter (MGR og CL1) holdes adskilt i ulike OUer med ulike policyer. ([2.2.5](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/etabler-en-sikker-ikt-arkitektur/#:~:text=2.2.5-,Del,-opp%20domenearkitekturen%20iht)). 

* “Minimere rettigheter på driftskontoer" ([2.6.5](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/ha-kontroll-pa-identiteter-og-tilganger/#:~:text=2.6.5-,Minimer,-rettigheter%20p%C3%A5%20drifts)) ved å opprette ulike kontoer for ulike oppgaver/personal, og bruke sikkerhetsgrupper for å 1) gi to IT-ansatte tilgang til kontoer med serveradmin- og domeneadministrasjons-rettigheter (hhv., dl_it_server_localadmin og G_it_AD-Admin) og 2) gi IT-ansatte rettigheter til lokal administrator på klientmaskiner gjennom sikkerhetsgruppen dl_it_client_localadmin.   

* Importere GPOer for å sette standard sikkerhetskonfigurasjoner på alle klienter og på servere ([2.3.4](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/ivareta-en-sikker-konfigurasjon/#:~:text=2.3.4-,Etabler,-og%20vedlikehold%20standard)). Dette innebærer blant annet GPO for å “konfigurere klienter slik at kun kjent programvare kjører på dem” (i.e., AppLocker) ([2.3.2](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/ivareta-en-sikker-konfigurasjon/#:~:text=2.3.2-,Konfigurer,-klienter%20slik%20at)), og GPOer for å “tillate kun virksomhetsgodkjente programtillegg” ([2.8.4](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/beskytt-e-post-og-nettleser/#:~:text=2.8.4-,Tillat,-kun%20virksomhetsgodkjente%20programtillegg)) (i.e., uBlock Origin og Bitwarden Passordbehandler) Vi tok i stor grad utgangspunkt i Microsoft egne Security Baseline for opprette en sikker infrastruktur.  

* “Aktivere brannmur på alle klienter og servere” ([2.4.4](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/beskytt-virksomhetens-nettverk/#:~:text=2.4.4-,Aktiver,-brannmur%20p%C3%A5%20alle)) med egen policy for servere og klienter (i.e., contoso-client_firewall og contoso-server_firewall). 

*  “Etablere evne til gjenoppretting av data” ([2.9](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/etabler-evne-til-gjenoppretting-av-data/)) med Restic som tar regelmessig sikkerhetskopier av virksomhetsdata og programvare ([2.9.1](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/etabler-evne-til-gjenoppretting-av-data/#:~:text=2.9.1-,Legg,-en%20plan%20for)).  

* Opprette fil-mapper (shares) for generell tilgangskontroll med tilhørende sikkerhetsgrupper ([2.6](https://nsm.no/regelverk-og-hjelp/rad-og-anbefalinger/grunnprinsipper-for-ikt-sikkerhet-2-0/beskytte-og-opprettholde/ha-kontroll-pa-identiteter-og-tilganger/)) for de ulike delene av administrasjonen, samt egne fil-rettigheter basert på sikkerhetsgrupper for sensitive skript, for eksempel Restic (se punktet over) (i.e., file_it_scripts).   

 

### Beslutninger, utfordringer og løsninger 

**Bruk av Heat Orchestration** 

* For å spare tid ved testing, ønsket vi å automatisere jobben med å promotere DC1 til domenekontroller og koble klientene til domenet. Nå funker Heat-templaten slik at DC1 automatisk promoteres til en aktiv domenekontroller og klienter blir en del av domenet. Hovedutfordringen med dette var å få klientene til å vente til AD var klar og satt opp og deretter bli med i domenet. Her testet vi ulike løsninger, blant annet en while-løkke som ventet til DC svarte på DNS-forespørsler - dette fungerte delvis, men det endte ofte opp med at Cloudbase ble ferdig med skriptet før DC var satt opp. Vi endte til slutt opp med en løsning som benytter seg av Telnet for å sjekke om LDAP-port 389 er oppe på DC, og inntil den er det, venter skriptet. Dette fungerte mye bedre, og klienter ble raskt en del av domenet. En annen utfordring var å bli kjent med nettverkskonfigurasjon i Heat – klientene er avhengige av å få DNS-adressen til DC, ikke fra Neutron som OpenStack vanligvis leverer. Her var det mye prøving og feiling, men vi endte opp med å finne en konfigurasjonsløsning som gir DC1 en forutsigbar intern adresse hver gang, for og så tildele dette som DNS-server for klienter.

 

**Folder Redirection** 

* For hotellnæringen er det naturlig å tenke seg at ikke alle ansatte benytter seg av en egen datamaskin, og Folder Redirection ble raskt sett på som en mulighet for å løse denne problemstillingen. Ansatte forventer at filer de har jobbet på alltid skal være tilgjengelig hvor enn de går, samtidig som de er sikkert lagret og sikkerhetskopiert. Ved å benytte seg av en Folder Redirection policy løser vi dette, ved at alle brukerprofiler blir lagret på en sentral plass (SRV1), men mulighet for enkel sikkerhetskopiering (Restic).   

**Importering av GPO** 

* Hovedønsket vårt var å automatisere mest mulig, og her kommer group policyer også inn i bildet. Microsofts håndtering av Group Policy er eldre, og det er begrenset hva som er mulig å automatisere med for eksempel commandlets. For å redusere arbeidsmengden ved oppsett av servere, fant vi ut av at den beste måten var å lage grunnpolicyer som det tas sikkerhetskopi av og som blir importert inn til nye installasjoner. Utfordringen her var i hovedsak at GPOer ofte knytter grupper opp mot unike Security Identifieres (SID). Det vil derfor være problematisk å kun overføre sikkerhetskopierte GPOer, da mange av policyene vil bli ødelagte. En løsning som fungerer tilstrekkelig for vårt brukstilfelle er Migration Tables, som kan tilordne kildegrupper til destinasjonsgrupper. Dette er imidlertid ikke perfekt, da noen SIDer er mer hardkodede i Group Policyen enn andre. Vi var derfor nødt til å tilpasse policyene slik at det var mulig å portere dem over. En annen mulig løsning var å gå gjennom GPOene og endre SIDene manuelt i sikkerhetskopien, men det ville både vært en tidkrevende og teknisk avansert løsning.     

 

**Opprettelse av OUer og flytting av maskiner fra container til OU:**  

* I utgangspunktet skulle vi lage en OU med navn "Computers". Dette viste seg imidlertid ikke mulig fordi containeren "Computers" har samme navn. Løsningen ble å lage to topp-OUer ("Clients" og "Servers") istedenfor "Computers". 

    * Dette ga et følgeproblem med den automatiske omdirigeringen fra 'Computers'-containeren. I og med at det i de fleste tilfeller vil være snakk om klienter som joiner domenet, ble omdirigeringen endret til "Employee"-OUen. 

 

**IIS-skript** 

* ScriptAnalyzer protesterer på å hardkode ComputerName "SRV1" med Invoke-Command. Vi hentet hjelp fra [Microsofts dokumentasjon](https://docs.microsoft.com/en-us/powershell/utility-modules/psscriptanalyzer/rules/avoidusingcomputernamehardcoded?view=ps-modules) og la servernavnet (SRV1) i en variabel.  

 

 **Bruker-skript** 

* Vi tok utgangspunkt i skriptet fra [kompendiet](https://gitlab.com/erikhje/dcsg1005/-/blob/master/compendia.md#adding-users) for oppretting av brukere, men la til Title og Description. Disse ekstra delene med brukerinformasjon gjør at vi enklere kan sortere serveradmin og klientadmin inn i sikkerhetsgrupper med de tillatelsene de skal ha. 

* For å sørge for at IT-avdelingen får de brukerne de skal ha, og at disse brukerne alltid blir opprettet, var det lettest å hardkode IT-brukerne. 

* I opprettelsen av brukerkontoenes tilfeldig genererte passord kommer tidvis feilmeldingen: “The password does not meet the length, complexity, or history requirement of the domain.” Dette er ikke et sikkerhetsproblem i og med at passordene blir kryptert i AD og må resettes før de tas i bruk. For å unngå problemet med manglende kompleksitet valgte vi allikevel å legge til 8 ekstra spesialtegn (tilfeldig valgt på samme måte som de første 16 tegnene). Da dette fortsatt ikke er en helt tilstrekkelig løsning, har vi hardkodet passord for IT-ansattes kontoer med admin-rettigheter til klienter og servere. Dette gjorde også at testing og feilsøking underveis ble mulig.  

* Linjen “-AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force)” går (som kjent) ikke gjennom pipelinen. Ved hjelp av [PSScript Analyzer Github](https://github.com/PowerShell/PSScriptAnalyzer/blob/master/README.md#suppressing-rules) og [Microsofts Dokumentasjon om funksjoner](https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.2) lagde vi en funksjon som stanset de unødvendige reglene, og kalte denne for å legge inn brukernes passord.  

 

### Gruppearbeid  

Gruppearbeidet startet med at vi lagde en [prosjektplan](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/MINUTES.md#prosjektplan) for å fordele det administrative, sette mål for prosjektet og legge en gjennomføringsplan.  

Gjennom prosjektet har vi hatt jevnlige møter for å planlegge og delegere oppgaver, samt for å jobbe sammen på prosjektet. Møtene har blitt dokumentert i [møtereferatene](https://gitlab.stud.idi.ntnu.no/daniehin/dcsg-1005/-/blob/main/MINUTES.md#m%C3%B8tereferat-8-mars). Vi har hatt en tydelig fordeling av ansvarsområder/oppgaver fra start, men har i økende grad sittet sammen og jobbet fordi de ulike scriptene/delene av AD-strukturen henger tett sammen. Dette har også gjort at vi har kunnet hjelpe hverandre noe som har vært helt avgjørende for å på grunn av sprikende forkunnskaper i gruppa. Daniel har større kompetanse enn alle øvrige gruppemedlemmer. Dette har både vært en utfordring med tanke på at mye tid har gått med til å øke forståelsen, men det har også gjort prosessen veldig lærerik.  

Selv om vi har jobbet jevnt gjennom hele prosjektperioden, kunne vi med fordel ha begynt på skriptene tidligere for å ta bort noen av timene med arbeid den siste helgen. 
