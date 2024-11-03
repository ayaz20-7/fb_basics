import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/database_handler.dart';
import '../../model/user_model.dart';


part 'firebase_crud_event.dart';
part 'firebase_crud_state.dart';





class FirebaseCrudBloc extends Bloc<FirebaseCrudEvent, FirebaseCrudState> {

  StreamSubscription<List<User>>? _usersStreamSubscription;

  @override
  Future<void> close() async {
    await _usersStreamSubscription!.cancel();
    return super.close();
  }

  FirebaseCrudBloc() : super(FirebaseCrudInitial()) {
    on<ReadDataEvent>((event, emit) {
      try {
        emit(FirebaseCrudLoading());
        final streamResponse = DatabaseHandler.readData();
        _usersStreamSubscription?.cancel();
        _usersStreamSubscription = streamResponse.listen((users) {
          add(LoadDataEvent(users));
        });
      } catch(e) {
        emit(FirebaseCrudFailure());
      }
    });

    on<LoadDataEvent>((event, emit) {
      try{
        emit(FirebaseCrudLoaded(event.users));
      }catch(_){
        emit(FirebaseCrudFailure());
      }
    });
    on<CreateDataEvent>((event, emit) async {
      emit(FirebaseCrudLoading());
      try {
        await DatabaseHandler.createData(event.user);
        final users = await DatabaseHandler.readData(); // Re-fetch data
        emit(FirebaseCrudLoaded(users as List<User>));
      } catch (_) {
        emit(FirebaseCrudFailure());
      }
    });

    // on<CreateDataEvent>((event, emit) {
    //   try{
    //     if(state is FirebaseCrudLoaded) {
    //       DatabaseHandler.createData(event.user);
    //     }
    //   }catch(_){
    //     emit(FirebaseCrudFailure());
    //   }
    // });

    on<UpdateDataEvent>((event, emit) {
      try{
        if(state is FirebaseCrudLoaded) {
          DatabaseHandler.updateData(event.user);
        }
      }catch(_){
        emit(FirebaseCrudFailure());
      }
    });

    on<DeleteDataEvent>((event, emit) {
      try{
        if(state is FirebaseCrudLoaded) {
          DatabaseHandler.deleteData(event.id);
        }
      }catch(_){
        emit(FirebaseCrudFailure());
      }
    });
  }
}