package no.difi.meldingsutveksling.dokumentpakking.service;

import lombok.RequiredArgsConstructor;
import no.difi.meldingsutveksling.DocumentType;
import no.difi.meldingsutveksling.Process;
import no.difi.meldingsutveksling.UUIDGenerator;
import no.difi.meldingsutveksling.config.IntegrasjonspunktProperties;
import no.difi.meldingsutveksling.domain.MeldingsUtvekslingRuntimeException;
import no.difi.meldingsutveksling.domain.Organisasjonsnummer;
import no.difi.meldingsutveksling.domain.sbdh.*;
import no.difi.meldingsutveksling.serviceregistry.SRParameter;
import no.difi.meldingsutveksling.serviceregistry.ServiceRegistryLookup;
import no.difi.meldingsutveksling.serviceregistry.ServiceRegistryLookupException;
import org.springframework.stereotype.Component;

import java.time.Clock;
import java.time.OffsetDateTime;

import static no.difi.meldingsutveksling.dokumentpakking.service.ScopeFactory.fromConversationId;
import static no.difi.meldingsutveksling.dokumentpakking.service.ScopeFactory.fromJournalPostId;

@Component
@RequiredArgsConstructor
public class SBDFactory {
    private static final String STANDARD = "urn:no:difi:meldingsutveksling:1.0";
    private static final String HEADER_VERSION = "1.0";
    private static final String TYPE_VERSION_2 = "2.0";

    private final ServiceRegistryLookup serviceRegistryLookup;
    private final UUIDGenerator uuidGenerator;
    private final Clock clock;
    private final IntegrasjonspunktProperties props;

    public StandardBusinessDocument createSBD(Organisasjonsnummer avsender,
                                              Organisasjonsnummer mottaker,
                                              Object payload,
                                              String conversationId,
                                              DocumentType documentType,
                                              String journalPostId) {
        return new StandardBusinessDocument()
                .setStandardBusinessDocumentHeader(createHeader(avsender, mottaker, conversationId, conversationId, documentType, journalPostId))
                .setAny(payload);
    }

    public StandardBusinessDocument createNextMoveSBD(Organisasjonsnummer avsender,
                                                      Organisasjonsnummer mottaker,
                                                      String conversationId,
                                                      String documentId,
                                                      String process,
                                                      DocumentType documentType,
                                                      Object any) {
        return new StandardBusinessDocument()
                .setStandardBusinessDocumentHeader(new StandardBusinessDocumentHeader()
                        .setHeaderVersion(HEADER_VERSION)
                        .addSender(createSender(avsender))
                        .addReceiver(createReceiver(mottaker))
                        .setDocumentIdentification(createDocumentIdentification(documentType, getDocumentIdentifier(SRParameter.builder(mottaker.toString())
                                .conversationId(conversationId).build(), process, documentType), documentId))
                        .setBusinessScope(createBusinessScope(fromConversationId(conversationId, process, OffsetDateTime.now(clock).plusHours(props.getNextmove().getDefaultTtlHours()))))
                ).setAny(any);
    }

    private String getDocumentIdentifier(SRParameter parameter, String process, DocumentType documentType) {
        try {
            return serviceRegistryLookup.getDocumentIdentifier(parameter, process, documentType);
        } catch (ServiceRegistryLookupException e) {
            throw new MeldingsUtvekslingRuntimeException(String.format("Error looking up service record for %s", parameter.getIdentifier()), e);
        }
    }

    private StandardBusinessDocumentHeader createHeader(Organisasjonsnummer avsender,
                                                        Organisasjonsnummer mottaker,
                                                        String conversationId,
                                                        String documentId,
                                                        DocumentType documentType,
                                                        String journalPostId) {
        return new StandardBusinessDocumentHeader()
                .setHeaderVersion(HEADER_VERSION)
                .addSender(createSender(avsender))
                .addReceiver(createReceiver(mottaker))
                .setDocumentIdentification(createDocumentIdentification(documentType, STANDARD, documentId))
                .setBusinessScope(createBusinessScope(
                        fromConversationId(conversationId, Process.LEGACY.getValue(), OffsetDateTime.now(clock).plusHours(props.getNextmove().getDefaultTtlHours())),
                        fromJournalPostId(journalPostId, Process.LEGACY.getValue())));
    }

    private Receiver createReceiver(Organisasjonsnummer orgNummer) {
        Receiver sender = new Receiver();
        fillPartner(sender, orgNummer);
        return sender;
    }

    private Sender createSender(Organisasjonsnummer orgNummer) {
        Sender sender = new Sender();
        fillPartner(sender, orgNummer);
        return sender;
    }

    private void fillPartner(Partner partner, Organisasjonsnummer orgNummer) {
        partner.setIdentifier(new PartnerIdentification()
                .setValue(orgNummer.asIso6523())
                .setAuthority(orgNummer.authority()));
    }

    private DocumentIdentification createDocumentIdentification(DocumentType documentType,
                                                                String standard,
                                                                String documentId) {
        return new DocumentIdentification()
                .setCreationDateAndTime(OffsetDateTime.now(clock))
                .setStandard(standard)
                .setType(documentType.getType())
                .setTypeVersion(TYPE_VERSION_2)
                .setInstanceIdentifier(documentId);
    }

    private BusinessScope createBusinessScope(Scope... scopes) {
        return new BusinessScope().addScopes(scopes);
    }
}