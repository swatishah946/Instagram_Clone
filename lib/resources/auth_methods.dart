import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    // required Uint8List file,
  }) async {
    String res = "Some error occurred - please try again";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = cred.user!.uid;
        await _store.collection('users').doc(uid).set({
          'Username': username,
          'Email': email,
          'bio': bio,
          'Uid': uid,
          'Followers': [],
          'Following': [],
        });
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
