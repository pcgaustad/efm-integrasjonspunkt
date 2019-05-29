Feature: Sending a Next Move DPO message

  Background:
    Given a "GET" request to "http://localhost:9099/identifier/910075918?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910075918.json"
    And a "GET" request to "http://localhost:9099/identifier/910077473?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910077473.json"
    And a "GET" request to "http://localhost:9099/identifier/974720760?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/974720760.json"

  Scenario: As a user I want to send a DPO message
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
                        "identifier": "urn:no:difi:profile:arkivmelding:administrasjon:ver1.0",
                        "instanceIdentifier": "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
                        "type": "ConversationId"
                    }
                ]
            },
            "documentIdentification": {
                "creationDateAndTime": "2019-03-25T11:35:00Z",
                "instanceIdentifier": "ff88849c-e281-4809-8555-7cd54952b916",
                "standard": "urn:no:difi:arkivmelding:xsd::arkivmelding",
                "type": "arkivmelding",
                "typeVersion": "2.0"
            },
            "headerVersion": "1.0",
            "receiver": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "0192:910075918"
                    }
                }
            ],
            "sender": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "0192:910077473"
                    }
                }
            ]
        },
        "arkivmelding": {
          "sikkerhetsnivaa": 3,
          "primaerDokumentNavn": "arkivmelding.xml"
        }
    }
    """
    And the response status is "OK"
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
    Then an upload to Altinn is initiated with:
    """
    <?xml version='1.0' encoding='UTF-8'?>
    <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
      <S:Body>
        <ns2:InitiateBrokerServiceBasic xmlns="http://schemas.altinn.no/services/ServiceEngine/Broker/2015/06" xmlns:ns2="http://www.altinn.no/services/ServiceEngine/Broker/2015/06" xmlns:ns3="http://www.altinn.no/services/common/fault/2009/10" xmlns:ns4="http://www.altinn.no/services/2009/10" xmlns:ns5="http://schemas.microsoft.com/2003/10/Serialization/" xmlns:ns6="http://schemas.altinn.no/services/serviceEntity/2015/06">
          <ns2:systemUserName>testuser</ns2:systemUserName>
          <ns2:systemPassword>testpass</ns2:systemPassword>
          <ns2:brokerServiceInitiation>
            <Manifest>
              <ExternalServiceCode>4192</ExternalServiceCode>
              <ExternalServiceEditionCode>270815</ExternalServiceEditionCode>
              <ArrayOfFile>
                <File>
                  <FileName>sbd.zip</FileName>
                </File>
              </ArrayOfFile>
              <Reportee>910077473</Reportee>
              <SendersReference>19efbd4c-413d-4e2c-bbc5-257ef4a65b38</SendersReference>
            </Manifest>
            <RecipientList>
              <Recipient>
                <PartyNumber>910075918</PartyNumber>
              </Recipient>
            </RecipientList>
          </ns2:brokerServiceInitiation>
        </ns2:InitiateBrokerServiceBasic>
      </S:Body>
    </S:Envelope>
    """
    And the sent Altinn ZIP contains the following files:
      | filename       |
      | manifest.xml   |
      | recipients.xml |
      | sbd.json       |
      | asic.zip       |
    And the content of the Altinn ZIP file named "manifest.xml" is:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <ns0:BrokerServiceManifest xmlns:ns0="http://schema.altinn.no/services/ServiceEngine/Broker/2015/06">
       <ns0:ExternalServiceCode>v3888</ns0:ExternalServiceCode>
       <ns0:ExternalServiceEditionCode>70515</ns0:ExternalServiceEditionCode>
       <ns0:SendersReference>19efbd4c-413d-4e2c-bbc5-257ef4a65b38</ns0:SendersReference>
       <ns0:Reportee>910077473</ns0:Reportee>
       <ns0:FileList>
          <ns0:File>
             <ns0:FileName>sbd.json</ns0:FileName>
          </ns0:File>
       </ns0:FileList>
    </ns0:BrokerServiceManifest>
    """
    And the content of the Altinn ZIP file named "recipients.xml" is:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <ns0:BrokerServiceRecipientList xmlns:ns0="http://schema.altinn.no/services/ServiceEngine/Broker/2015/06">
       <ns0:Recipient>
          <ns0:PartyNumber>910075918</ns0:PartyNumber>
       </ns0:Recipient>
    </ns0:BrokerServiceRecipientList>
    """
    And the JSON content of the Altinn ZIP file named "sbd.json" is:
    """
    {
      "standardBusinessDocumentHeader" : {
        "headerVersion" : "1.0",
        "sender" : [ {
          "identifier" : {
            "value" : "0192:910077473",
            "authority" : "iso6523-actorid-upis"
          },
          "contactInformation" : [ ]
        } ],
        "receiver" : [ {
          "identifier" : {
            "value" : "0192:910075918",
            "authority" : "iso6523-actorid-upis"
          },
          "contactInformation" : [ ]
        } ],
        "documentIdentification" : {
          "standard" : "urn:no:difi:arkivmelding:xsd::arkivmelding",
          "typeVersion" : "2.0",
          "instanceIdentifier" : "ff88849c-e281-4809-8555-7cd54952b916",
          "type" : "arkivmelding",
          "creationDateAndTime" : "2019-03-25T11:35:00Z"
        },
        "businessScope" : {
          "scope" : [ {
            "type" : "ConversationId",
            "instanceIdentifier" : "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
            "identifier" : "urn:no:difi:profile:arkivmelding:administrasjon:ver1.0",
            "scopeInformation" : [ {
              "expectedResponseDateTime" : "2019-05-10T00:31:52Z"
            } ]
          } ]
        }
      },
      "arkivmelding" : {
        "sikkerhetsnivaa" : 3,
        "primaerDokumentNavn" : "arkivmelding.xml"
      }
    }
    """
    And the sent message contains the following files:
      | filename         | content type |
      | manifest.xml     | text/xml     |
      | arkivmelding.xml | text/xml     |
      | test.txt         | text/plain   |
    And the content of the file named "manifest.xml" is:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
       <mottaker>
          <organisasjon authority="iso6523-actorid-upis">0192:910075918</organisasjon>
       </mottaker>
       <avsender>
          <organisasjon authority="iso6523-actorid-upis">0192:910077473</organisasjon>
       </avsender>
       <hoveddokument href="arkivmelding.xml" mime="text/xml">
          <tittel lang="no">Hoveddokument</tittel>
       </hoveddokument>
    </manifest>
    """
    And the content of the file named "arkivmelding.xml" is:
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
    And the content of the file named "test.txt" is:
    """
    Testing 1 2 3
    """
    And the message statuses for the conversation with id = "37efbd4c-413d-4e2c-bbc5-257ef4a65a56" are:
    """
    {
      "content" : [ {
        "statId" : 1,
        "convId" : 1,
        "conversationId" : "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
        "lastUpdate" : "2019-03-25T11:38:23Z",
        "status" : "OPPRETTET"
      }, {
        "statId" : 2,
        "convId" : 1,
        "conversationId" : "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
        "lastUpdate" : "2019-03-25T11:38:23Z",
        "status" : "SENDT"
      } ],
      "last" : true,
      "totalElements" : 2,
      "totalPages" : 1,
      "size" : 10,
      "number" : 0,
      "sort" : [ {
        "direction" : "ASC",
        "property" : "statId",
        "ignoreCase" : false,
        "nullHandling" : "NATIVE",
        "descending" : false,
        "ascending" : true
      } ],
      "first" : true,
      "numberOfElements" : 2
    }
    """

  Scenario: As a user I want to receive a DPO receipt message
    And Altinn prepares a message with the following SBD:
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
                        "identifier": "urn:no:difi:profile:arkivmelding:response:ver1.0",
                        "instanceIdentifier": "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
                        "type": "ConversationId"
                    }
                ]
            },
            "documentIdentification": {
                "creationDateAndTime": "2019-03-25T11:35:00Z",
                "instanceIdentifier": "ff88849c-e281-4809-8555-7cd54952b916",
                "standard": "urn:no:difi:eformidling:xsd::status",
                "type": "status",
                "typeVersion": "2.0"
            },
            "headerVersion": "1.0",
            "receiver": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "0192:910075918"
                    }
                }
            ],
            "sender": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "0192:910077473"
                    }
                }
            ]
        },
        "status": {
          "status": "LEVERT"
        }
    }
    """
    And Altinn sends the message
    And the application checks for new DPO messages
    And the message statuses for the conversation with id = "37efbd4c-413d-4e2c-bbc5-257ef4a65a56" are:
    """
    {
      "content" : [ {
        "statId" : 20,
        "convId" : 12,
        "conversationId" : "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
        "lastUpdate" : "2019-03-25T11:38:23Z",
        "status" : "OPPRETTET"
      }, {
        "statId" : 21,
        "convId" : 12,
        "conversationId" : "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
        "lastUpdate" : "2019-03-25T11:38:23Z",
        "status" : "SENDT"
      }, {
        "statId" : 24,
        "convId" : 12,
        "conversationId" : "37efbd4c-413d-4e2c-bbc5-257ef4a65a56",
        "lastUpdate" : "2019-03-25T11:38:23Z",
        "status" : "LEVERT"
      } ],
      "totalPages" : 1,
      "totalElements" : 3,
      "last" : true,
      "size" : 10,
      "number" : 0,
      "sort" : [ {
        "direction" : "ASC",
        "property" : "statId",
        "ignoreCase" : false,
        "nullHandling" : "NATIVE",
        "ascending" : true,
        "descending" : false
      } ],
      "first" : true,
      "numberOfElements" : 3
    }
    """
