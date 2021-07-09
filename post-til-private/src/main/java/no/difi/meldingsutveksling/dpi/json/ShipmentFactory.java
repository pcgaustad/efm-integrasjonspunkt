package no.difi.meldingsutveksling.dpi.json;

import no.difi.meldingsutveksling.domain.Organisasjonsnummer;
import no.difi.meldingsutveksling.domain.sbdh.StandardBusinessDocument;
import no.difi.meldingsutveksling.dpi.Document;
import no.difi.meldingsutveksling.dpi.MeldingsformidlerRequest;
import no.difi.meldingsutveksling.nextmove.PostAddress;
import no.difi.meldingsutveksling.nextmove.PostalCategory;
import no.difi.meldingsutveksling.nextmove.PrintColor;
import no.difi.meldingsutveksling.nextmove.ReturnHandling;
import no.digdir.dpi.client.domain.BusinessCertificate;
import no.digdir.dpi.client.domain.MetadataDocument;
import no.digdir.dpi.client.domain.Parcel;
import no.digdir.dpi.client.domain.Shipment;
import no.digdir.dpi.client.domain.messagetypes.BusinessMessage;
import no.digdir.dpi.client.domain.messagetypes.Digital;
import no.digdir.dpi.client.domain.messagetypes.Utskrift;
import no.digdir.dpi.client.domain.sbd.*;

import java.util.Arrays;
import java.util.Optional;
import java.util.stream.Collectors;

public class ShipmentFactory {

    public Shipment getShipment(MeldingsformidlerRequest request) {
        return new Shipment()
                .setStandardBusinessDocument(getStandardBusinessDocument(request))
                .setParcel(getParcel(request))
                .setReceiverBusinessCertificate(BusinessCertificate.fraByteArray(request.getCertificate()))
                .setLanguage(request.getLanguage());
    }

    private Parcel getParcel(MeldingsformidlerRequest request) {
        return new Parcel()
                .setMainDocument(toDpiClientDocument(request.getDocument()))
                .setAttachments(request.getAttachments()
                        .stream()
                        .map(this::toDpiClientDocument)
                        .collect(Collectors.toList()));
    }

    private no.digdir.dpi.client.domain.Document toDpiClientDocument(Document in) {
        return new no.digdir.dpi.client.domain.Document()
                .setTitle(in.getTitle())
                .setFilename(in.getFilename())
                .setMimeType(in.getMimeType())
                .setResource(in.getResource())
                .setMetadataDocument(toDpiClientMetadataDocument(in.getMetadataDocument()));
    }

    private MetadataDocument toDpiClientMetadataDocument(no.difi.meldingsutveksling.dpi.MetadataDocument in) {
        return new no.digdir.dpi.client.domain.MetadataDocument()
                .setFilename(in.getFilename())
                .setMimeType(in.getMimeType())
                .setResource(in.getResource());
    }

    private StandardBusinessDocument getStandardBusinessDocument(MeldingsformidlerRequest request) {
        return new StandardBusinessDocument()
                .setStandardBusinessDocumentHeader(request.getStandardBusinessDocumentHeader())
                .setAny(getBusinessMessage(request));
    }

    private BusinessMessage getBusinessMessage(MeldingsformidlerRequest request) {
        return request.isPrintProvider() ? getUtskrift(request) : getDigital(request);
    }

    private Utskrift getUtskrift(MeldingsformidlerRequest request) {
        return new Utskrift()
                .setAvsender(getAvsender(request))
                .setMottaker(getAddressInformation(request.getPostAddress()))
                .setUtskriftstype(getUtskriftstype(request.getPrintColor()))
                .setRetur(getRetur(request))
                .setPosttype(getPosttype(request.getPostalCategory()));
    }

    private Utskrift.Posttype getPosttype(PostalCategory postalCategory) {
        return (postalCategory == PostalCategory.A_PRIORITERT)
                ? Utskrift.Posttype.A
                : Utskrift.Posttype.B;
    }

    private Retur getRetur(MeldingsformidlerRequest request) {
        return new Retur()
                .setMottaker(getAddressInformation(request.getReturnAddress()))
                .setReturposthaandtering(getReturposthaandtering(request.getReturnHandling()));
    }

    private Retur.Returposthaandtering getReturposthaandtering(ReturnHandling returnHandling) {
        return (returnHandling == ReturnHandling.MAKULERING_MED_MELDING)
                ? Retur.Returposthaandtering.MAKULERING_MED_MELDING
                : Retur.Returposthaandtering.DIREKTE_RETUR;
    }

    private Utskrift.Utskriftstype getUtskriftstype(PrintColor printColor) {
        return (printColor == PrintColor.FARGE)
                ? Utskrift.Utskriftstype.FARGE
                : Utskrift.Utskriftstype.SORT_HVIT;
    }

    private AdresseInformasjon getAddressInformation(PostAddress postAddress) {
        return new AdresseInformasjon()
                .setNavn(postAddress.getNavn())
                .setAdresselinje1(postAddress.getAdresselinje1())
                .setAdresselinje2(postAddress.getAdresselinje2())
                .setAdresselinje3(postAddress.getAdresselinje3())
                .setAdresselinje4(postAddress.getAdresselinje4())
                .setPostnummer(postAddress.getPostnummer())
                .setPoststed(postAddress.getPoststed())
                .setLand(postAddress.getLand());
    }

    private Digital getDigital(MeldingsformidlerRequest request) {
        return new Digital()
                .setAvsender(getAvsender(request))
                .setMottaker(new Personmottaker()
                        .setPostkasseadresse(request.getPostkasseAdresse()))
                .setSikkerhetsnivaa(request.getSecurityLevel())
                .setVirkningstidspunkt(request.getVirkningsdato())
                .setAapningskvittering(request.isAapningskvittering())
                .setIkkesensitivtittel(new Ikkesensitivtittel()
                        .setTittel(request.getSubject())
                        .setSpraak(request.getLanguage()))
                .setVarsler(new Varsler()
                        .setSmsvarsel(new Smsvarsel()
                                .setMobiltelefonnummer(request.getMobileNumber())
                                .setVarslingstekst(request.getSmsVarslingstekst())
                                .setRepetisjoner(Arrays.asList(0, 7))
                                .setSpraak(request.getLanguage()))
                        .setEpostvarsel(new Epostvarsel()
                                .setEpostadresse(request.getEmailAddress())
                                .setVarslingstekst(request.getEmailVarslingstekst())
                                .setRepetisjoner(Arrays.asList(0, 7))
                                .setSpraak(request.getLanguage())));
    }

    private Avsender getAvsender(MeldingsformidlerRequest request) {
        return new Avsender()
                .setAvsenderidentifikator(request.getAvsenderIdentifikator())
                .setFakturaReferanse(request.getFakturaReferanse())
                .setVirksomhetsidentifikator(getVirksomhetsindikator(request));
    }

    private Identifikator getVirksomhetsindikator(MeldingsformidlerRequest request) {
        return request.getStandardBusinessDocumentHeader()
                .getFirstSender()
                .flatMap(p -> Optional.ofNullable(p.getIdentifier()))
                .map(p -> new Identifikator(p.getAuthority(), p.getValue()))
                .orElseGet(() -> {
                    Organisasjonsnummer orgnr = Organisasjonsnummer.from(request.getSenderOrgnumber());
                    return new Identifikator(orgnr.authority(), orgnr.asIso6523());
                });
    }

}
