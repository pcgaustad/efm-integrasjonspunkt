//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2014.11.25 at 12:23:12 PM CET 
//


package no.difi.meldingsutveksling.domain.sbdh;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import no.difi.meldingsutveksling.validation.OneOf;
import no.difi.meldingsutveksling.validation.UUID;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.HashSet;
import java.util.Set;


/**
 * <p>Java class for Scope complex type.
 *
 * <p>The following schema fragment specifies the expected content contained within this class.
 *
 * <pre>
 * &lt;complexType name="Scope">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;group ref="{http://www.unece.org/cefact/namespaces/StandardBusinessDocumentHeader}ScopeAttributes"/>
 *         &lt;element ref="{http://www.unece.org/cefact/namespaces/StandardBusinessDocumentHeader}ScopeInformation" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Scope", propOrder = {
        "type",
        "instanceIdentifier",
        "identifier",
        "scopeInformation"
})
@Getter
@Setter
@ToString
public class Scope {

    @XmlElement(name = "Type", required = true)
    @NotNull
    @OneOf({"ConversationId", "SenderRef", "ReceiverRef"})
    protected String type;

    @XmlElement(name = "InstanceIdentifier", required = true)
    @UUID
    protected String instanceIdentifier;

    @XmlElement(name = "Identifier")
    protected String identifier;

    @XmlElement(name = "ScopeInformation")
    @Valid
    protected Set<@Valid CorrelationInformation> scopeInformation;

    /**
     * Gets the value of the scopeInformation property.
     *
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the scopeInformation property.
     *
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getScopeInformation().add(newItem);
     * </pre>
     *
     *
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link JAXBElement }{@code <}{@link BusinessService }{@code >}
     * {@link JAXBElement }{@code <}{@link CorrelationInformation }{@code >}
     * {@link JAXBElement }{@code <}{@link Object }{@code >}
     */
    public Set<CorrelationInformation> getScopeInformation() {
        if (scopeInformation == null) {
            scopeInformation = new HashSet<>();
        }
        return this.scopeInformation;
    }

    public Scope addScopeInformation(CorrelationInformation correlationInformation) {
        getScopeInformation().add(correlationInformation);
        return this;
    }
}
