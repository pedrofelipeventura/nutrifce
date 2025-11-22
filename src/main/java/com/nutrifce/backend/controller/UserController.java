package com.nutrifce.backend.controller;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.cloud.firestore.DocumentSnapshot;
import com.nutrifce.backend.dto.UserDTO;
import com.nutrifce.backend.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final FirebaseAuth firebaseAuth = FirebaseAuth.getInstance();

    public UserController(UserService userService) {
        this.userService = userService;
    }

    private FirebaseToken validateToken(String idToken) throws FirebaseAuthException {
        return firebaseAuth.verifyIdToken(idToken);
    }

    // 🔵 Criar ou atualizar perfil do usuário
    @PostMapping("/register")
    public Map<String, Object> register(
            @RequestParam String idToken,
            @RequestBody UserDTO dto) {

        try {
            FirebaseToken decoded = validateToken(idToken);
            String uid = decoded.getUid();

            String time = userService.createOrUpdateUser(uid, dto);

            return Map.of(
                    "status", "success",
                    "uid", uid,
                    "updatedAt", time
            );

        } catch (Exception e) {
            return Map.of("status", "error", "message", e.getMessage());
        }
    }

    // 🔵 Pegar perfil
    @GetMapping("/me")
    public Map<String, Object> getProfile(@RequestParam String idToken) {
        try {
            FirebaseToken decoded = validateToken(idToken);
            String uid = decoded.getUid();

            DocumentSnapshot doc = userService.getUser(uid);

            if (!doc.exists()) {
                return Map.of("status", "not_found");
            }

            return Map.of(
                    "status", "success",
                    "profile", doc.getData()
            );

        } catch (Exception e) {
            return Map.of("status", "error", "message", e.getMessage());
        }
    }

    // 🔵 Deletar perfil
    @DeleteMapping("/delete")
    public Map<String, Object> delete(@RequestParam String idToken) {
        try {
            FirebaseToken decoded = validateToken(idToken);
            String uid = decoded.getUid();

            userService.deleteUser(uid);

            return Map.of("status", "deleted");

        } catch (Exception e) {
            return Map.of("status", "error", "message", e.getMessage());
        }
    }
}
