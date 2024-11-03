import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_basics/bloc_crud/database/database_handler.dart';

import '../model/user_model.dart';

part 'firebase_cruds_state.dart';

class FirebaseCrudsCubit extends Cubit<FirebaseCrudsState> {
  FirebaseCrudsCubit() : super(FirebaseCrudsInitial());

  void readData(){
   try{ emit(FirebaseCrudsLoading());
   final streamResponse = DatabaseHandler.readData();
   streamResponse.listen((users){
emit(FirebaseCrudsLoaded(users));
   });}catch(e){
     emit(FirebaseCrudsFailure());
   }
  }
void createData(User user){
    if (state is FirebaseCrudsLoaded) {
      DatabaseHandler.createData(user);
    }
}
  void updateData(User user){
    if (state is FirebaseCrudsLoaded) {
      DatabaseHandler.updateData(user);
    }
  }
  void deleteData(String id){
    if (state is FirebaseCrudsLoaded) {
      DatabaseHandler.deleteData(id);
    }
  }
}
