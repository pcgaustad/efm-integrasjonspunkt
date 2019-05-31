Feature: Receiving an expired Next Move DPE message

  Background:
    Given a "GET" request to "http://localhost:9099/identifier/910075935?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910075935.json"
    And a "GET" request to "http://localhost:9099/identifier/974720760?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/974720760.json"
    And a "GET" request to "http://localhost:9099/identifier/910077473?notification=obligated" will respond with status "200" and the following "application/json" in "/restmocks/identifier/910077473.json"

    And ServiceBus prepares a message with the following SBD:
    """
    {
        "standardBusinessDocumentHeader": {
            "businessScope": {
                "scope": [
                    {
                        "scopeInformation": [
                            {
                                "expectedResponseDateTime": "2019-03-25T11:00:00+01:00"
                            }
                        ],
                        "identifier": "urn:no:difi:meldingsutveksling:2.0",
                        "instanceIdentifier": "f58a286c-8325-41ee-9398-da8471c3e234",
                        "type": "ConversationId"
                    }
                ]
            },
            "documentIdentification": {
                "creationDateAndTime": "2019-03-25T11:35:00+01:00",
                "instanceIdentifier": "ff88849c-e281-4809-8555-7cd54952b916",
                "standard": "urn:no:difi:meldingsutveksling:2.0",
                "type": "innsynskrav",
                "typeVersion": "2.0"
            },
            "headerVersion": "1.0",
            "receiver": [
                {
                    "identifier": {
                        "authority": "iso6523-actorid-upis",
                        "value": "0192:910075935"
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
        "innsynskrav": {
          "securityLevel": 3
        }
    }
    """
    And appends a file named "primary.html" with mimetype="text/html":
    """
    <h1>Primary document</h1>
    <p>This is the content of the primary document.</p>
    """
    And appends a file named "before_the_law.txt" with mimetype="text/plain":
    """
    Before the law sits a gatekeeper.
    """
    And the ServiceBus has the message available

  Scenario: As a user I want an expired DPE message to be stopped

    Given the application checks for new DPE messages
    Then the message statuses for the conversation with id = "f58a286c-8325-41ee-9398-da8471c3e234" are:
    """
    {
      "content" : [ {
        "statId" : 1,
        "convId" : 1,
        "conversationId" : "f58a286c-8325-41ee-9398-da8471c3e234",
        "lastUpdate" : "2019-03-25T12:38:23+01:00",
        "status" : "OPPRETTET"
      }, {
        "statId" : 2,
        "convId" : 1,
        "conversationId" : "f58a286c-8325-41ee-9398-da8471c3e234",
        "lastUpdate" : "2019-03-25T12:38:23+01:00",
        "status" : "LEVETID_UTLOPT",
        "description" : "Levetiden for meldingen er utgått. Må sendes på nytt"
      } ],
      "totalElements" : 2,
      "totalPages" : 1,
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
      "numberOfElements" : 2
    }
    """
