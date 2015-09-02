package no.difi.meldingsutveksling.adresseregister;

/**
 * A Wrapper class for a response to a certificate request.
 *
 * @author Glenn Bech
 */
public class CertificateResponse {

    private String base64EncondedCertificate;

    public String getBase64EncondedCertificate() {
        return base64EncondedCertificate;
    }

    public void setBase64EncondedCertificate(String base64EncondedCertificate) {
        this.base64EncondedCertificate = base64EncondedCertificate;
    }
}