// // // import 'package:fb_basics/bloc_crud/bloc/firebase_crud/firebase_crud_bloc.dart';
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // //
// // // import 'bloc_crud/model/user_model.dart';
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
// // //     return MultiBlocProvider(
// // //       providers: [
// // //         BlocProvider(
// // //           create: (context) => FirebaseCrudBloc()..add(ReadDataEvent()),
// // //         )
// // //       ],
// // //       child: MaterialApp(
// // //         title: 'Material App',
// // //         debugShowCheckedModeBanner: false,
// // //         home: Scaffold(
// // //           appBar: AppBar(
// // //             title: const Text('Bloc Crud'),
// // //           ),
// // //           body: Column(
// // //             children: [
// // //               Center(
// // //                   child: ElevatedButton(
// // //                       onPressed: () {
// // //                         BlocProvider.of<FirebaseCrudBloc>(context).add(
// // //                             CreateDataEvent(User(
// // //                                 username: "John",
// // //                                 email: "john@gmail.com",
// // //                                 id: '')));
// // //                       },
// // //                       child: const Text('Create Data'))),
// // //               BlocBuilder<FirebaseCrudBloc, FirebaseCrudState>(
// // //                   builder: (context, state) {
// // //                 if (state is FirebaseCrudLoading) {
// // //                   return const Center(
// // //                     child: CircularProgressIndicator(),
// // //                   );
// // //                 }
// // //                 if (state is FirebaseCrudFailure) {
// // //                   return const Center(
// // //                     child: Text("Something Went Wrong"),
// // //                   );
// // //                 }
// // //                 if (state is FirebaseCrudLoaded) {
// // //                   final user = state.users;
// // //                   return user.isEmpty? const Center(child: Text('No data'),):Padding(
// // //                     padding: const EdgeInsets.all(8.0),
// // //                     child: Column(
// // //                       children: user.map((user) {
// // //                         return ListTile(
// // //                           leading: GestureDetector(
// // //                             onTap: () {
// // //                               BlocProvider.of<FirebaseCrudBloc>(context)
// // //                                   .add(DeleteDataEvent(user.id));
// // //                             },
// // //                             child: const Icon(Icons.delete),
// // //                           ),
// // //                           trailing: GestureDetector(
// // //                             onTap: () {
// // //                               BlocProvider.of<FirebaseCrudBloc>(context).add(
// // //                                   UpdateDataEvent(User(
// // //                                       username: "John",
// // //                                       email: "john@gmail.com",
// // //                                       id: user.id)));
// // //                             },
// // //                             child: const Icon(Icons.update),
// // //                           ),
// // //                           title: Text(user.username),
// // //                           subtitle: Text(user.email),
// // //                         );
// // //                       }).toList(),
// // //                     ),
// // //                   );
// // //                 }
// // //                 return const Center(
// // //                   child: CircularProgressIndicator(),
// // //                 );
// // //               })
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_crud/bloc/firebase_crud/firebase_crud_bloc.dart';
import 'bloc_crud/cubit/firebase_cruds_cubit.dart';
import 'bloc_crud/model/user_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FirebaseCrudBloc>(
          create: (context) => FirebaseCrudBloc()..add(ReadDataEvent()),
        ),
        BlocProvider<FirebaseCrudsCubit>(
          create: (context) => FirebaseCrudsCubit()..readData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Crud',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cloud Firestore CRUD"),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // context.read<FirebaseCrudBloc>().add(
                  //       CreateDataEvent(User(
                  //         email: "john@gmail.com",
                  //         username: "John Doe",
                  //         id: '',
                  //       )),
                  //     );
                  context.read<FirebaseCrudsCubit>().createData(
                      User(username: 'John', email: 'John@gmail.com', id: ''));
                },
                child: Text("Create Data"),
              ),
            ),
            BlocBuilder<FirebaseCrudsCubit, FirebaseCrudsState>(
              builder: (context, state) {
                if (state is FirebaseCrudsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is FirebaseCrudsFailure) {
                  return Center(child: Text("Something went wrong"));
                }
                if (state is FirebaseCrudsLoaded) {
                  final users = state.users;
                  return users.isEmpty
                      ? Center(child: Text("No Data"))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: users.map((user) {
                              return ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<FirebaseCrudsCubit>()
                                        .deleteData(
                                          user.id,
                                        );
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<FirebaseCrudsCubit>()
                                        .updateData(
                                          User(
                                            id: user.id,
                                            email: "aaa@gmail.com",
                                            username: "aaaa",
                                          ),
                                        );
                                  },
                                  child: Icon(Icons.update),
                                ),
                                title: Text(user.username!),
                                subtitle: Text(user.email!),
                              );
                            }).toList(),
                          ),
                        );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
