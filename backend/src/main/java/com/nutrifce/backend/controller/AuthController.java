package com.nutrifce.backend.controller;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final FirebaseAuth firebaseAuth = FirebaseAuth.getInstance();

    @PostMapping("/verify")
    public Map<String, Object> verifyToken(@RequestParam String idToken) {
        try {
            FirebaseToken decoded = firebaseAuth.verifyIdToken(idToken);

            return Map.of(
                    "status", "válido",
                    "uid", decoded.getUid(),
                    "email", decoded.getEmail()
            );

        } catch (FirebaseAuthException e) {
            return Map.of(
                    "status", "inválido",
                    "erro", e.getMessage()
            );
        }
    }
}
