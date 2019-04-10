Feature: Sending a Next Move DPF message

  Background:

    Given a "GET" request to "http://localhost:9099/identifier/987464291?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/987464291.json"
    And a "GET" request to "http://localhost:9099/identifier/910075924?notification=obligated&process=urn:no:difi:profile:eFormidling:ver2.0" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910075924.json"
    And a "GET" request to "http://localhost:9099/identifier/910075924?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910075924.json"
    And a "GET" request to "http://localhost:9099/identifier/910077473?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910077473.json"
    And a SOAP request to "https://test.svarut.ks.no/tjenester/forsendelseservice/ForsendelsesServiceV9" will respond with the following payload:
    """
    <ser:sendForsendelseMedIdResponse xmlns:ser="http://www.ks.no/svarut/servicesV9">
       <!--Optional:-->
       <return>?</return>
    </ser:sendForsendelseMedIdResponse>
    """

  Scenario: As a user I want to send a DPF message
    Given I POST the following message:
    """
    {
        "standardBusinessDocumentHeader": {
            "businessScope": {
                "scope": [
                    {
                        "scopeInformation": [
                            {
                                "expectedResponseDateTime": "2019-05-10T00:31:52Z"
                            }
                        ],
                        "identifier": "urn:no:difi:profile:eFormidling:ver2.0",
                        "instanceIdentifier": "45efbd4c-413d-4e2c-bbc5-257ef4a65a91",
                        "type": "ConversationId"
                    }
                ]
            },
            "documentIdentification": {
                "creationDateAndTime": "2019-04-11T15:29:58.753+02:00",
                "instanceIdentifier": "abc8849c-e281-4809-8555-7cd54952b916",
                "standard": "urn:no:difi:meldingsutveksling:2.0",
                "type": "DPO",
                "typeVersion": "2.0"
            },
            "headerVersion": "1.0",
            "receiver": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "9908:910075924"
                    }
                }
            ],
            "sender": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "9908:910077473"
                    }
                }
            ]
        },
        "dpo": {
          "securityLevel": "3",
          "primaryDocumentFilename": "arkivmelding.xml"
        }
    }
    """
    And I upload a file named "arkivmelding.xml" with mimetype "text/xml" and title "Arkivmelding" with the following body:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <arkivmelding xmlns="http://www.arkivverket.no/standarder/noark5/arkivmelding" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.arkivverket.no/standarder/noark5/arkivmelding arkivmelding.xsd">
        <system>LandLord</system>
        <meldingId>3380ed76-5d4c-43e7-aa70-8ed8d97e4835</meldingId>
        <tidspunkt>2017-05-23T12:46:00</tidspunkt>
        <antallFiler>1</antallFiler>

        <mappe xsi:type="saksmappe">
            <systemID>43fbe161-7aac-4c9f-a888-d8167aab4144</systemID>
            <tittel>Nye lysrør Hauketo Skole</tittel>
            <opprettetDato>2017-06-01T10:10:12.000+01:00</opprettetDato>
            <opprettetAv/>
            <klassifikasjon>
                <referanseKlassifikasjonssystem>Funksjoner</referanseKlassifikasjonssystem>
                <klasseID>vedlikehold av skole</klasseID>
                <tittel>vedlikehold av skole</tittel>
                <opprettetDato>2017-05-23T21:56:12.000+01:00</opprettetDato>
                <opprettetAv>Knut Hansen</opprettetAv>
            </klassifikasjon>
            <klassifikasjon>
                <referanseKlassifikasjonssystem>Objekter</referanseKlassifikasjonssystem>
                <klasseID>20500</klasseID>
                <tittel>Hauketo Skole</tittel>
                <opprettetDato>2017-05-23T21:56:12.000+01:00</opprettetDato>
                <opprettetAv>Knut Hansen</opprettetAv>
            </klassifikasjon>
            <basisregistrering xsi:type="journalpost">
                <systemID>430a6710-a3d4-4863-8bd0-5eb1021bee45</systemID>
                <opprettetDato>2012-02-17T21:56:12.000+01:00</opprettetDato>
                <opprettetAv>LandLord</opprettetAv>
                <arkivertDato>2012-02-17T21:56:12.000+01:00</arkivertDato>
                <arkivertAv>LandLord</arkivertAv>
                <referanseForelderMappe>43fbe161-7aac-4c9f-a888-d8167aab4144</referanseForelderMappe>
                <dokumentbeskrivelse>
                    <systemID>3e518e5b-a361-42c7-8668-bcbb9eecf18d</systemID>
                    <dokumenttype>Bestilling</dokumenttype>
                    <dokumentstatus>Dokumentet er ferdigstilt</dokumentstatus>
                    <tittel>Bestilling - nye lysrør</tittel>
                    <opprettetDato>2012-02-17T21:56:12.000+01:00</opprettetDato>
                    <opprettetAv>Landlord</opprettetAv>
                    <tilknyttetRegistreringSom>Hoveddokument</tilknyttetRegistreringSom>
                    <dokumentnummer>1</dokumentnummer>
                    <tilknyttetDato>2012-02-17T21:56:12.000+01:00</tilknyttetDato>
                    <tilknyttetAv>Landlord</tilknyttetAv>
                    <dokumentobjekt>
                        <versjonsnummer>1</versjonsnummer>
                        <variantformat>Produksjonsformat</variantformat>
                        <opprettetDato>2012-02-17T21:56:12.000+01:00</opprettetDato>
                        <opprettetAv>Landlord</opprettetAv>
                        <referanseDokumentfil>test.txt</referanseDokumentfil>
                    </dokumentobjekt>
                </dokumentbeskrivelse>
                <tittel>Nye lysrør</tittel>
                <offentligTittel>Nye lysrør</offentligTittel>

                <virksomhetsspesifikkeMetadata>
                    <forvaltningsnummer>20050</forvaltningsnummer>
                    <objektnavn>Hauketo Skole</objektnavn>
                    <eiendom>200501</eiendom>
                    <bygning>2005001</bygning>
                    <bestillingtype>Materiell, elektro</bestillingtype>
                    <rammeavtale>K-123123-elektriker</rammeavtale>
                </virksomhetsspesifikkeMetadata>

                <journalposttype>Utgående dokument</journalposttype>
                <journalstatus>Journalført</journalstatus>
                <journaldato>2017-05-23</journaldato>
                <korrespondansepart>
                    <korrespondanseparttype>Mottaker</korrespondanseparttype>
                    <korrespondansepartNavn>elektrikeren AS, Veien 100, Oslo</korrespondansepartNavn>
                </korrespondansepart>
            </basisregistrering>
            <saksdato>2017-06-01</saksdato>
            <administrativEnhet>Blah</administrativEnhet>
            <saksansvarlig>KNUTKÅRE</saksansvarlig>
            <saksstatus>Avsluttet</saksstatus>
        </mappe>
    </arkivmelding>
    """
    And I upload a file named "test.txt" with mimetype "text/plain" and title "Test" with the following body:
    """
    Testing 1 2 3
    """
    And I send the message
    Then an upload to Fiks is initiated with:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <ns2:sendForsendelseMedId xmlns:ns2="http://www.ks.no/svarut/servicesV9"
                              xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
        <forsendelse>
            <avgivendeSystem>p360</avgivendeSystem>
            <dokumenter>
                <data><!--encrypted content--></data>
                <ekskluderesFraPrint>false</ekskluderesFraPrint>
                <filnavn>test.txt</filnavn>
                <mimetype>text/plain</mimetype>
                <skalSigneres>false</skalSigneres>
            </dokumenter>
            <eksternref>45efbd4c-413d-4e2c-bbc5-257ef4a65a91</eksternref>
            <krevNiva4Innlogging>false</krevNiva4Innlogging>
            <kryptert>true</kryptert>
            <kunDigitalLevering>false</kunDigitalLevering>
            <metadataFraAvleverendeSystem>
                <journalaar>0</journalaar>
                <journaldato/>
                <journalpostnummer>0</journalpostnummer>
                <journalposttype>Utgående dokument</journalposttype>
                <journalsekvensnummer>0</journalsekvensnummer>
                <journalstatus>Journalført</journalstatus>
                <saksaar>0</saksaar>
                <sakssekvensnummer>0</sakssekvensnummer>
                <tittel>Nye lysrør</tittel>
            </metadataFraAvleverendeSystem>
            <mottaker>
                <digitalAdresse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                xsi:type="ns2:organisasjonDigitalAdresse">
                    <orgnr>910075924</orgnr>
                </digitalAdresse>
                <postAdresse>
                    <land>Norge</land>
                    <navn>TEST - C4</navn>
                    <postnr>0192</postnr>
                    <poststed>Oslo</poststed>
                </postAdresse>
            </mottaker>
            <printkonfigurasjon>
                <brevtype>BPOST</brevtype>
                <fargePrint>false</fargePrint>
                <tosidig>true</tosidig>
            </printkonfigurasjon>
            <signaturtype xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
            <signeringUtloper xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
            <svarPaForsendelse>19efbd4c-413d-4e2c-bbc5-257ef4a65b38</svarPaForsendelse>
            <svarPaForsendelseLink>false</svarPaForsendelseLink>
            <svarSendesTil>
                <digitalAdresse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                xsi:type="ns2:organisasjonDigitalAdresse">
                    <orgnr>910077473</orgnr>
                </digitalAdresse>
                <postAdresse>
                    <land>Norge</land>
                    <navn>TEST - C4</navn>
                    <postnr>0192</postnr>
                    <poststed>Oslo</poststed>
                </postAdresse>
            </svarSendesTil>
            <tittel>Nye lysrør</tittel>
        </forsendelse>
        <forsendelsesid>45efbd4c-413d-4e2c-bbc5-257ef4a65a91</forsendelsesid>
    </ns2:sendForsendelseMedId>
    """
    And the content of the file named "test.txt" is:
    """
    Testing 1 2 3
    """
