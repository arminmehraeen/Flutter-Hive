import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final LazyBox<String> userBox ;


  UserBloc({required this.userBox}) : super(UserLoading()) {

    userBox.watch().listen((event) => add(LoadUsers())) ;

    on<DisposeBox>((event, emit) async => await userBox.close());

    on<DeleteUser>((event, emit) async {
      int index = event.index ;
      userBox.deleteAt(index) ;
    });

    on<DeleteUsers>((event, emit) async {
      userBox.clear() ;
    });

    on<UpdateUser>((event, emit) async {
      var response = event.data ;

      if(response != null) {
        List<String> information = response ;
        UserModel user = UserModel(firstName: information.first, lastName: information.last ) ;
        await userBox.putAt(event.index, json.encode(user.toMap())) ;
      }
    });

    on<AddUser>((event, emit) async {

      var response = event.data;

      if(response != null) {
        List<String> information = response ;
        UserModel user = UserModel(firstName: information.first, lastName: information.last ) ;
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
      emit(UserLoaded(data: data)) ;
    });

  }
}
