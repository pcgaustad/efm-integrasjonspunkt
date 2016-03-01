package no.difi.meldingsutveksling.config;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonUnwrapped;
import net.logstash.logback.encoder.org.apache.commons.lang.StringUtils;
import net.logstash.logback.marker.LogstashMarker;
import net.logstash.logback.marker.Markers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Class that contains denormalised metadata about the current configuration. Used for logging and
 * console display.
 *
 * @author Glenn bech
 */
public class ConfigMeta {

    private static final Logger logger = LoggerFactory.getLogger(ConfigMeta.class.getName());

    private List<ConfigGroup> configGroups;

    private ConfigMeta(List<ConfigGroup> configGroups) {
        this.configGroups = configGroups;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (ConfigGroup g : configGroups) {
            sb.append(g.name).append("\n");
            for (ConfigElement e : g.elements) {
                sb.append(StringUtils.rightPad(e.key, 30, " ")).append(e.value).append("\n");
            }
        }
        return sb.toString();
    }

    public void logInfo() {
        logger.info(createLogMarkers(), "Startup configuration");
    }

    private LogstashMarker createLogMarkers() {
        Map<String, String> fields = new HashMap<>();

        for(ConfigGroup g: configGroups) {
            for(ConfigElement e: g.getElements()) {
                fields.put(e.key.replace(".", "_"), e.value);
            }
        }
        return Markers.appendEntries(fields);
    }

    public static class Builder {
        private List<ConfigGroup> allGroups;
        private ConfigGroup currentGroup;

        public Builder() {
            allGroups = new ArrayList<>();
            newGroup("root");
        }

        public Builder newGroup(String name) {
            currentGroup = new ConfigGroup(name);
            allGroups.add(currentGroup);
            return this;
        }

        public Builder newElement(String key, String value) {
            ConfigElement element = new ConfigElement(key, value);
            currentGroup.add(element);
            return this;
        }

        public ConfigMeta build() {
            return new ConfigMeta(allGroups);
        }

        public Builder newElement(String key) {
            ConfigElement eleemnt = new ConfigElement(key);
            currentGroup.add(eleemnt);
            return this;
        }
    }

    public static class ConfigGroup {

        private String name;
        private List<ConfigElement> elements;

        public ConfigGroup(String name) {
            this.name = name;
            elements = new ArrayList<>();
        }

        public void add(ConfigElement configElement) {
            elements.add(configElement);
        }

        public List<ConfigElement> getElements() {
            return elements;
        }
    }

    public static class ConfigElement {

        private String key;
        private String value;

        public ConfigElement(String key, String value) {
            this.key = key;
            this.value = value;
        }

        public ConfigElement(String key) {
            this.key = key;
            this.value = "********";
        }
    }
}