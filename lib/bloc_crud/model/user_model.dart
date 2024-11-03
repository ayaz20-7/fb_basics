// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class User {
//   final String username;
//   final String email;
//   final String id;
//
//   User({required this.username, required this.email, required this.id});
//
//   Map<String, dynamic> toJson() {
//     return {"username": username, "email": email, "id": id};
//   }
//
//   static User fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     return User(
//         username: snapshot['username'],
//         email: snapshot['email'],
//         id: snapshot['id']);
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String id;

  User({required this.username, required this.email, required this.id});

  static User fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return User(
        username: snapshot['username'],
        email: snapshot['email'],
        id: snapshot['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "id": id,
    };
  }
}