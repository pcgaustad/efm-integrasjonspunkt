package no.difi.meldingsutveksling.noarkexchange.altinn;

import lombok.extern.slf4j.Slf4j;
import no.difi.meldingsutveksling.IntegrasjonspunktNokkel;
import no.difi.meldingsutveksling.config.IntegrasjonspunktProperties;
import no.difi.meldingsutveksling.dokumentpakking.service.SBDFactory;
import no.difi.meldingsutveksling.ks.svarinn.SvarInnService;
import no.difi.meldingsutveksling.nextmove.AsicHandler;
import no.difi.meldingsutveksling.nextmove.NextMoveQueue;
import no.difi.meldingsutveksling.nextmove.message.MessagePersister;
import no.difi.meldingsutveksling.noarkexchange.MessageContextFactory;
import no.difi.meldingsutveksling.noarkexchange.NoarkClient;
import no.difi.meldingsutveksling.noarkexchange.PutMessageRequestFactory;
import no.difi.meldingsutveksling.receipt.ConversationService;
import no.difi.meldingsutveksling.receipt.MessageStatusFactory;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Conditional;
import org.springframework.context.annotation.Configuration;

import java.time.Clock;

@Slf4j
@Configuration
@ConditionalOnProperty(name = "difi.move.feature.enableDPF", havingValue = "true")
public class DpfPollingConfig {

    @Bean
    public DpfPolling dpfPolling(IntegrasjonspunktProperties properties,
                                 SvarInnService svarInnService,
                                 ObjectProvider<SvarInnPutMessageForwarder> svarInnPutMessageForwarderProvider,
                                 SvarInnNextMoveForwarder svarInnNextMoveForwarder) {
        return new DpfPolling(properties, svarInnService, svarInnPutMessageForwarderProvider, svarInnNextMoveForwarder);
    }

    @Bean
    @Conditional(LocalNorarkExistsCondition.class)
    public SvarInnPutMessageForwarder svarInnPutMessageForwarder(IntegrasjonspunktProperties properties, ConversationService conversationService, SvarInnService svarInnService, NoarkClient localNoark, NoarkClient fiksMailClient, MessageStatusFactory messageStatusFactory, PutMessageRequestFactory putMessageRequestFactory, Clock clock) {
        log.info("SvarInnPutMessageForwarder created");
        return new SvarInnPutMessageForwarder(properties, conversationService, svarInnService, localNoark, fiksMailClient, messageStatusFactory, putMessageRequestFactory, clock);
    }

    @Bean
    public SvarInnNextMoveForwarder svarInnNextMoveForwarder(SvarInnNextMoveConverter svarInnNextMoveConverter, SvarInnService svarInnService, NextMoveQueue nextMoveQueue) {
        return new SvarInnNextMoveForwarder(svarInnNextMoveConverter, svarInnService, nextMoveQueue);
    }

    @Bean
    public SvarInnNextMoveConverter svarInnNextMoveConverter(IntegrasjonspunktNokkel keyInfo, MessagePersister messagePersister, SvarInnService svarInnService, MessageContextFactory messageContextFactory, AsicHandler asicHandler, SBDFactory createSBD, IntegrasjonspunktProperties properties) {
        return new SvarInnNextMoveConverter(keyInfo, messagePersister, svarInnService, messageContextFactory, asicHandler, createSBD, properties);
    }
}
