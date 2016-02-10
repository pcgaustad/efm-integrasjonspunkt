package no.difi.meldingsutveksling;

import com.sun.xml.ws.transport.http.servlet.WSSpringServlet;
import org.apache.activemq.broker.Broker;
import org.apache.activemq.broker.BrokerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.solr.SolrAutoConfiguration;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.jms.listener.DefaultMessageListenerContainer;

import javax.jms.*;

@SpringBootApplication(exclude = {SolrAutoConfiguration.class})
public class IntegrasjonspunktApplication extends SpringBootServletInitializer {
    private static final Logger log = LoggerFactory.getLogger(IntegrasjonspunktApplication.class);

    @Bean
    public ServletRegistrationBean servletNoArk() {
        WSSpringServlet servlet = new WSSpringServlet();
        ServletRegistrationBean reg = new ServletRegistrationBean(servlet, "/noarkExchange", "/receive");
        reg.setLoadOnStartup(1);
        return reg;
    }

    public static void main(String[] args) {
        try {
            ConfigurableApplicationContext context = SpringApplication.run(IntegrasjonspunktApplication.class, args);

            MessageCreator messageCreator = new MessageCreator() {
                @Override
                public Message createMessage(Session session) throws JMSException {
                    return session.createTextMessage("Hello world from JMS!");
                }
            };

            System.out.println("Sending a new Message.... -> ");
            JmsTemplate jmsTemplate = (JmsTemplate) context.getBean("jmsTemplate");
            jmsTemplate.setDeliveryPersistent(true);
            //jmsTemplate.setTimeToLive();
            jmsTemplate.setSessionTransacted(true);
            //jmsTemplate.setDeliveryMode(DeliveryMode.PERSISTENT);
            //jmsTemplate.setExplicitQosEnabled(true);


//            jmsTemplate.send("mailbox-destination", messageCreator);

//            MessageCreator messageCreator = new MessageCreator() {
//                @Override
//                public Message createMessage(Session session) throws JMSException {
//                    return session.createTextMessage("Hello world from JMS!");
//                }
//            };
//
//            JmsTemplate jmsTemplate = context.getBean(JmsTemplate.class);
//            System.out.println("Sending a new Message.... -> ");
//            jmsTemplate.send("mailbox-destination", messageCreator);

        }
        catch (SecurityException se) {
            String message =
                    "Failed startup. Possibly unlimited security policy files that is not updated." +
                            "/r/nTo fix this, download and replace policy files for the apropriate java version (found in ${java.home}/jre/lib/security/)" +
                            "/r/n- Java7: http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html" +
                            "/r/n- Java8: http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html";

            System.out.println(message);
            log.error(message);
            log.error(se.getMessage());
        }
    }
}
