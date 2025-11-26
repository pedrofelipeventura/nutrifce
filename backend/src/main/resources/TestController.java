package com.nutrifce.backend.controller;

import com.google.cloud.firestore.Firestore;
import com.nutrifce.backend.config.FirebaseConfig;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class TestController {

    @GetMapping("/api/test")
    public Map<String, String> testApi() {
        return Map.of("message", "Backend do Nutrifce funcionando!");
    }

    @GetMapping("/api/firebase")
    public Map<String, String> testFirebase() {
        try {
            Firestore db = FirebaseConfig.getFirestore();

            if (db != null) {
                return Map.of("firebase", "Conexão com Firebase funcionando!");
            } else {
                return Map.of("firebase", "Firestore está nulo! Verifique o arquivo JSON.");
            }

        } catch (Exception e) {
            return Map.of("firebase", "Erro ao conectar: " + e.getMessage());
        }
    }
}
