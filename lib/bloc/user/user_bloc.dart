import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final LazyBox<String> userBox ;


  UserBloc({required this.userBox}) : super(UserLoading()) {

    userBox.watch().listen((event) => add(LoadUsers())) ;

    on<DisposeBox>((event, emit) async => await userBox.close());

    on<DeleteUser>((event, emit) => userBox.deleteAt(event.index));

    on<DeleteUsers>((event, emit) => userBox.clear());

    on<UpdateUser>((event, emit) async {
      var data = event.data ;
      if(data != null) {
        UserModel user = UserModel.fromMap(data) ;
        await userBox.putAt(event.index, json.encode(user.toMap())) ;
      }
    });

    on<AddUser>((event, emit) async {

      var data = event.data;
      if(data != null) {
        UserModel user = UserModel.fromMap(data) ;
        await userBox.put(DateTime.now().toString(),json.encode(user.toMap())) ;
      }
    });

    on<LoadUsers>((event, emit) async {
      List<String> data = [] ;
      for(var key in userBox.keys.toList()) {
        String? value = await userBox.get(key) ;
        if(value != null) {
          data.add(value) ;
        }
      }
      List<UserModel> users = data.map((e) => UserModel.fromMap(json.decode(e))).toList() ;
      emit(UserLoaded(users: users)) ;
    });

  }
}