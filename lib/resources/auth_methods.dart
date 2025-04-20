import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

Future<model.User>getUserData()async{
  User currentuser=_auth.currentUser!;

   DocumentSnapshot snap =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return model.User.fromSnap(snap);
}


  Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred - please try again";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file.isNotEmpty) {
        // Create user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Upload image to Cloudinary
        String photoUrl = await StorageMethods().uploadImageToCloudinary(
          "profilepics",
          file,
          false,
        );

        model.User user = model.User(
          email: email,
          username: username,
          bio: bio,
          uid: cred.user!.uid,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        // Store user data in Firestore
        await _store.collection('users').doc(cred.user!.uid).set(user.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (e.code == 'weak-password') {
        res = 'The password is too weak.';
      } else {
        res = e.message ?? res;
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred - please try again";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
