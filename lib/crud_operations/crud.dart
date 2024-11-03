// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class CrudOperations extends StatelessWidget {
//   const CrudOperations({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//               child: ElevatedButton(
//                   onPressed: () {
//                     _createData(User(
//                         username: "Ali", email: 'ali@gmail.com', id: ''));
//                   },
//                   child: const Text('Create Data'))),
//           StreamBuilder<List<User>>(
//             stream: _readData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (snapshot.data!.isEmpty) {
//                 return const Center(
//                   child: Text('No Data'),
//                 );
//               }
//               final users = snapshot.data;
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: users!.map((user) {
//                     return ListTile(
//                       leading: GestureDetector(
//                         onTap: () {
//                           _deleteData(user.id!);
//                         },
//                         child: Icon(Icons.delete),
//                       ),
//                       trailing: GestureDetector(
//                         onTap: () {
//                           _updateData(User(
//                               username: "aizaz",
//                               email: "@gmail.com",
//                               id: user.id));
//                         },
//                         child: Icon(Icons.update),
//                       ),
//                       title: Text(user.username),
//                       subtitle: Text(user.email),
//                     );
//                   }).toList(),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
//   Stream<List<User>> _readData() {
//     final userCollection = FirebaseFirestore.instance.collection("users");
//
//     return userCollection.snapshots().map((querySnapshot) =>
//         querySnapshot.docs.map((e) => User.fromSnapShot(e)).toList());
//   }
//
//   _createData(User user) {
//     final userCollection = FirebaseFirestore.instance.collection('users');
//     String id = userCollection.doc().id;
//     final newUser =
//     User(username: user.username, email: user.email, id: id).toJson();
//
//     userCollection.doc(id).set(newUser);
//   }
//
//   _updateData(User user) {
//     final userCollection = FirebaseFirestore.instance.collection("users");
//     final newData =
//     User(username: user.username, email: user.email, id: user.id).toJson();
//     userCollection.doc(user.id).update(newData);
//   }
//
//   _deleteData(String id) {
//     final userCollection = FirebaseFirestore.instance.collection("users");
//
//     userCollection.doc(id).delete();
//   }
// }
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
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // import 'firebase_options.dart';
// // //
// // // Future<void> main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Material App',
// // //       debugShowCheckedModeBanner: false,
// // //       home: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Material App Bar'),
// // //         ),
// // //         body: SingleChildScrollView(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               Center(
// // //                 child: ElevatedButton(
// // //                   onPressed: () {
// // //                     _createData(User(
// // //                         username: "nomN", email: 'aMAN@gmail.com', id: ''));
// // //                   },
// // //                   child: const Text('Create Data'),
// // //                 ),
// // //               ),
// // //               FutureBuilder<List<User>>(
// // //                 future: _readData(),
// // //                 builder: (context, snapshot) {
// // //                   if (snapshot.connectionState == ConnectionState.waiting) {
// // //                     return const Center(
// // //                       child: CircularProgressIndicator(),
// // //                     );
// // //                   }
// // //
// // //                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //                     return const Center(
// // //                       child: Text('No Data'),
// // //                     );
// // //                   }
// // //
// // //                   final users = snapshot.data!;
// // //                   return ListView.builder(
// // //                     shrinkWrap: true,
// // //                     physics: const NeverScrollableScrollPhysics(),
// // //                     itemCount: users.length,
// // //                     itemBuilder: (context, index) {
// // //                       final user = users[index];
// // //                       return ListTile(
// // //                         title: Text(user.username),
// // //                         subtitle: Text(user.email),
// // //                       );
// // //                     },
// // //                   );
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Future<List<User>> _readData() {
// // //     final userCollection = FirebaseFirestore.instance.collection("users");
// // //
// // //     return userCollection.get().then((querySnapshot) =>
// // //         querySnapshot.docs.map((e) => User.fromSnapShot(e)).toList());
// // //   }
// // //
// // //   void _createData(User user) {
// // //     final userCollection = FirebaseFirestore.instance.collection('users');
// // //     String id = userCollection.doc().id;
// // //     final newUser =
// // //     User(username: user.username, email: user.email, id: id).toJson();
// // //
// // //     userCollection.doc(id).set(newUser);
// // //   }
// // // }
// // //
// // // class User {
// // //   final String username;
// // //   final String email;
// // //   final String id;
// // //
// // //   User({required this.username, required this.email, required this.id});
// // //
// // //   Map<String, dynamic> toJson() {
// // //     return {"username": username, "email": email, "id": id};
// // //   }
// // //
// // //   static User fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
// // //     return User(
// // //       username: snapshot['username'],
// // //       email: snapshot['email'],
// // //       id: snapshot['id'],
// // //     );
// // //   }
// // // }
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //
// // //