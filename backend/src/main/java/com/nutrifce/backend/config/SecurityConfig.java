package com.nutrifce.backend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .csrf(csrf -> csrf.disable()) // Desabilita CSRF
                .cors(cors -> cors.disable()) // Desabilite se não estiver usando CORS ainda
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().permitAll() // Libera todos os endpoints temporariamente
                )
                .formLogin(login -> login.disable()) // DESABILITA O FORM DE LOGIN!
                .httpBasic(basic -> basic.disable()); // DESABILITA AUTENTICAÇÃO BASIC

        return http.build();
    }
}
