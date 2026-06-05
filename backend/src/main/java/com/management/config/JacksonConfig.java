package com.management.config;

import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.format.DateTimeFormatter;

@Configuration
public class JacksonConfig {

    private static final DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jsonCustomizer() {
        return builder -> {
            builder.simpleDateFormat("yyyy-MM-dd HH:mm:ss");
            builder.serializers(new LocalDateTimeSerializer(DATETIME_FORMATTER));
            builder.deserializers(new LocalDateTimeDeserializer(DATETIME_FORMATTER));
            builder.serializerByType(Long.class, ToStringSerializer.instance);
            builder.serializerByType(long.class, ToStringSerializer.instance);
        };
    }
}
