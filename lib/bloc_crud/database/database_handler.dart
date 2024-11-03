// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../model/user_model.dart';
//
// class DatabaseHandler {
//
//
//   static createData(User user) {
//     final userCollection = FirebaseFirestore.instance.collection('users');
//     String id = userCollection.doc().id;
//     final newUser =
//     User(username: user.username, email: user.email, id: id).toJson();
//
//     userCollection.doc(id).set(newUser);
//   }
//
//   static Stream<List<User>> readData() {
//     final userCollection = FirebaseFirestore.instance.collection("users");
//
//     return userCollection.snapshots().map((querySnapshot) =>
//         querySnapshot.docs.map((e) => User.fromSnapShot(e)).toList());
//   }
//
//   static updateData(User user) {
//     final userCollection = FirebaseFirestore.instance.collection("users");
//     final newData =
//     User(username: user.username, email: user.email, id: user.id).toJson();
//     userCollection.doc(user.id).update(newData);
//   }
//
//   static deleteData(String id) {
//     final userCollection = FirebaseFirestore.instance.collection("users");
//
//     userCollection.doc(id).delete();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';


class DatabaseHandler {

  static Stream<List<User>> readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => User.fromSnapshot(e)).toList());
  }

  static updateData(User user) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final newData = User(
        username: user.username,
        id: user.id,
        email: user.email
    ).toJson();

    userCollection.doc(user.id).update(newData);
  }

  static deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(id).delete();
  }

  static createData(User user) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String id = userCollection.doc().id;
    final newUser =
    User(username: user.username, id: id, email: user.email).toJson();

    userCollection.doc(id).set(newUser);
  }
}