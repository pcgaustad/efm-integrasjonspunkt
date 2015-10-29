package no.difi.virksert.client;

import org.testng.Assert;
import org.testng.annotations.Test;

public class VirksertClientTest {

    @Test(enabled = false)
    public void simple() throws VirksertClientException {
        VirksertClient client = VirksertClientBuilder.forTest().setUri("http://localhost:8080/").build();
        Assert.assertNotNull(client.fetch("991825827"));
    }

}
