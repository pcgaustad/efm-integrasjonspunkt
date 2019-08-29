package no.difi.meldingsutveksling.nextmove;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.querydsl.core.annotations.QueryInit;
import lombok.*;
import no.difi.meldingsutveksling.MessageInformable;
import no.difi.meldingsutveksling.ServiceIdentifier;
import no.difi.meldingsutveksling.domain.sbdh.StandardBusinessDocument;
import org.hibernate.annotations.DiscriminatorOptions;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.OffsetDateTime;
import java.util.LinkedHashSet;
import java.util.Set;

@DiscriminatorColumn(name = "direction", discriminatorType = DiscriminatorType.STRING)
@DiscriminatorOptions(force = true)
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@Getter
@Setter
@ToString
@Entity
@RequiredArgsConstructor
@NoArgsConstructor
public abstract class NextMoveMessage extends AbstractEntity<Long> implements MessageInformable {

    @Column(unique = true)
    @NonNull
    private String conversationId;
    @NonNull
    private String messageId;
    @NonNull
    private String processIdentifier;
    @NonNull
    private String receiverIdentifier;
    @NonNull
    private String senderIdentifier;
    @NonNull
    private ServiceIdentifier serviceIdentifier;

    @UpdateTimestamp
    @Setter(AccessLevel.PRIVATE)
    private OffsetDateTime lastUpdated;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "message_id", nullable = false)
    private Set<BusinessMessageFile> files;

    @NonNull
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "sbd_id", referencedColumnName = "id")
    @QueryInit("standardBusinessDocumentHeader.businessScope")
    private StandardBusinessDocument sbd;

    @JsonIgnore
    public NextMoveMessage addFile(BusinessMessageFile file) {
        Set<BusinessMessageFile> fileSet = getOrCreateFiles();
        fileSet.add(file.setDokumentnummer(fileSet.size() + 1));
        return this;
    }

    @JsonIgnore
    public Set<BusinessMessageFile> getOrCreateFiles() {
        if (files == null) {
            files = new LinkedHashSet<>();
        }
        return files;
    }

    @JsonIgnore
    public BusinessMessage getBusinessMessage() {
        if (getSbd().getAny() == null) {
            throw new NextMoveRuntimeException("SBD missing BusinessMessage");
        }
        if (!(getSbd().getAny() instanceof BusinessMessage)) {
            throw new NextMoveRuntimeException("SBD.any not instance of BusinessMessage");
        }
        return (BusinessMessage) getSbd().getAny();
    }

    @Override
    public OffsetDateTime getExpiry() {
        return getSbd().getExpectedResponseDateTime().orElse(null);
    }
}