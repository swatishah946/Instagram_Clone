import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot["username"]??'missing username',
      uid: snapshot["uid"]??'missing uid',
      email: snapshot["email"]??'missing email',
      photoUrl: snapshot["photoUrl"]??'missing url',
      bio: snapshot["bio"]??'missing bio',
      followers: snapshot["followers"]??[],
      following: snapshot["following"]??[],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}