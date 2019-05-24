Feature: Validation when attempting to send a Next Move DPO message

  Background:
    Given a "GET" request to "http://localhost:9099/identifier/910075918?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910075918.json"
    And a "GET" request to "http://localhost:9099/identifier/910077473?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910077473.json"
    And a "GET" request to "http://localhost:9099/identifier/09118532322?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/09118532322.json"
    And a "GET" request to "http://localhost:9099/identifier/09118532323?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/09118532323.json"

  Scenario Outline: As a user I want the message service to validate my input
    Given I POST the following message:
    """
    {
        "standardBusinessDocumentHeader": {
            "businessScope": {
                "scope": [
                    {
                        "scopeInformation": [
                            {
                                "expectedResponseDateTime": <expectedResponseDateTime>
                            }
                        ],
                        "identifier": <process>,
                        "instanceIdentifier": <conversationId>,
                        "type": "ConversationId"
                    }
                ]
            },
            "documentIdentification": {
                "creationDateAndTime": <creationDateAndTime>,
                "instanceIdentifier": <documentId>,
                "standard": <standard>,
                "type": <type>,
                "typeVersion": "2.0"
            },
            "headerVersion": "1.0",
            "receiver": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": <receiver>
                    }
                }
            ],
            "sender": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": <sender>
                    }
                }
            ]
        },
        <businessDocument>
    }
    """
    Then the response status is "<status>"

    Examples:
      | conversationId                         | documentId                             | creationDateAndTime             | receiver         | sender           | process                                                       | standard                                           | type           | expectedResponseDateTime | businessDocument                                                                                                                                                                                                                                                                                 | status      |
      | "37efbd4c-413d-4e2c-bbc5-000000000001" | "ff88849c-e281-4809-8555-7cd54952b001" | "2019-04-11T15:29:58.753+02:00" | "0192:910075918" | "0192:910077473" | "urn:no:difi:profile:arkivmelding:planByggOgGeodata:ver1.0"   | "urn:no:difi:arkivmelding:xsd::arkivmelding"       | "arkivmelding" | "2019-05-10T00:31:52Z"   | "arkivmelding": { "sikkerhetsnivaa": 3, "primaerDokumentNavn": "arkivmelding.xml" }                                                                                                                                                                                                              | OK          |
      | "37efbd4c-413d-4e2c-bbc5-000000000002" | "ff88849c-e281-4809-8555-7cd54952b002" | "2019-04-11T15:29:58.753+02:00" | "0192:910075918" | "0192:910077473" | "urn:no:difi:profile:arkivmelding:helseSosialOgOmsorg:ver1.0" | "urn:no:difi:arkivmelding:xsd::arkivmelding"       | "arkivmelding" | "2019-05-10T00:31:52Z"   | "arkivmelding": { "sikkerhetsnivaa": 3, "primaerDokumentNavn": "arkivmelding.xml" }                                                                                                                                                                                                              | OK          |
      | "37efbd4c-413d-4e2c-bbc5-000000000003" | null                                   | null                            | "0192:910075918" | "0192:910077473" | "urn:no:difi:profile:arkivmelding:oppvekstOgUtdanning:ver1.0" | "urn:no:difi:arkivmelding:xsd::arkivmelding"       | "arkivmelding" | "2019-05-10T00:31:52Z"   | "arkivmelding": { "sikkerhetsnivaa": 3, "primaerDokumentNavn": "arkivmelding.xml" }                                                                                                                                                                                                              | OK          |
      | "37efbd4c-413d-4e2c-bbc5-000000000004" | null                                   | null                            | "09118532322"    | "0192:910077473" | "urn:no:difi:profile:digitalpost:info:ver1.0"                 | "urn:no:difi:digitalpost:xsd:digital::digital"     | "digital"      | "2019-05-10T00:31:52Z"   | "digital": { "sikkerhetsnivaa": "3", "primaerDokumentNavn": "", "ikkeSensitivTittel": "", "spraak": "NO", "digitalPostInfo": { "virkningsdato": "2019-05-12", "virkningstidspunkt": "", "aapningskvittering": "false" }, "varsler": { "epostTekst": "Varseltekst", "smsTekst": "Varseltekst" } } | OK          |
      | "37efbd4c-413d-4e2c-bbc5-000000000005" | null                                   | null                            | "09118532323"    | "0192:910077473" | "urn:no:difi:profile:digitalpost:info:ver1.0"                 | "urn:no:difi:digitalpost:xsd:digital::digital_dpv" | "digital_dpv"  | "2019-05-10T00:31:52Z"   | "digital_dpv": { "title": "The title", "summary": "The summary", "body": "The body" }                                                                                                                                                                                                            | OK          |
      | "37efbd4c-413d-4e2c-bbc5-000000000001" | "ff88849c-e281-4809-8555-7cd54952b001" | "2019-04-11T15:29:58.753+02:00" | "0192:910075918" | "0192:910075918" | "urn:no:difi:profile:arkivmelding:planByggOgGeodata:ver1.0"   | "urn:no:difi:arkivmelding:xsd::arkivmelding"       | "arkivmelding" | "2019-05-10T00:31:52Z"   | "arkivmelding": { "sikkerhetsnivaa": 3, "primaerDokumentNavn": "arkivmelding.xml" }                                                                                                                                                                                                              | BAD_REQUEST |
