//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2014.11.25 at 12:23:12 PM CET 
//


package no.difi.meldingsutveksling.domain.sbdh;

import lombok.Data;
import no.difi.meldingsutveksling.xml.ZonedDateTimeAdapter;

import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.time.ZonedDateTime;


/**
 * <p>Java class for DocumentIdentification complex type.
 *
 * <p>The following schema fragment specifies the expected content contained within this class.
 *
 * <pre>
 * &lt;complexType name="DocumentIdentification">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Standard" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="TypeVersion" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="InstanceIdentifier" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="Type" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="MultipleType" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/>
 *         &lt;element name="CreationDateAndTime" type="{http://www.w3.org/2001/XMLSchema}dateTime"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DocumentIdentification", propOrder = {
        "standard",
        "typeVersion",
        "instanceIdentifier",
        "type",
        "multipleType",
        "creationDateAndTime"
})
@Data
@Embeddable
public class DocumentIdentification {

    @XmlElement(name = "Standard", required = true)
    @NotNull
    protected String standard;

    @XmlElement(name = "TypeVersion", required = true)
    @NotNull
    protected String typeVersion;

    @XmlElement(name = "InstanceIdentifier", required = true)
    @NotNull
    protected String instanceIdentifier;

    @XmlElement(name = "Type", required = true)
    @NotNull
    protected String type;

    @XmlElement(name = "MultipleType")
    protected Boolean multipleType;

    @XmlElement(name = "CreationDateAndTime", required = true)
    @XmlSchemaType(name = "dateTime")
    @XmlJavaTypeAdapter(ZonedDateTimeAdapter.class)
    @NotNull
    protected ZonedDateTime creationDateAndTime;
}
