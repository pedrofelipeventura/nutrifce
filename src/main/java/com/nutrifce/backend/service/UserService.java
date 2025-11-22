package com.nutrifce.backend.service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.nutrifce.backend.dto.UserDTO;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class UserService {

    private final Firestore firestore = FirestoreClient.getFirestore();

    public String createOrUpdateUser(String uid, UserDTO dto) throws ExecutionException, InterruptedException {

        ApiFuture<WriteResult> future =
                firestore.collection("users").document(uid)
                        .set(Map.of(
                                "name", dto.getName(),
                                "age", dto.getAge(),
                                "height", dto.getHeight(),
                                "weight", dto.getWeight(),
                                "gender", dto.getGender()
                        ));

        return future.get().getUpdateTime().toString();
    }

    public DocumentSnapshot getUser(String uid) throws ExecutionException, InterruptedException {
        ApiFuture<DocumentSnapshot> future =
                firestore.collection("users").document(uid).get();

        return future.get();
    }

    public void deleteUser(String uid) {
        firestore.collection("users").document(uid).delete();
    }
}
