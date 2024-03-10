import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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

    on<DeleteUsers>((event, emit) async {
     if(event.users.isEmpty) {
       userBox.clear();
     }else{
       await userBox.deleteAll(event.users.map((e) => e.createdTime));
     }
    });

    on<UpdateUser>((event, emit) async {
      var data = event.data ;
      if(data != null) {
        UserModel user = UserModel.fromMap(data) ;
        await userBox.putAt(event.index, json.encode(user.toMap())) ;
      }
    });

    Future<Map<dynamic,String>> addUserFromList(List<UserModel> users) async {
      Map<dynamic,String> data = {} ;
      for(var user in users) {
        user = user.copyWith(createdTime: DateTime.now().toString());
        data[user.createdTime] = json.encode(user.toMap()) ;
        await Future.delayed(const Duration(milliseconds: 1));
      }
      return data ;
    }
    
    on<AddUsers>((event, emit) async => userBox.putAll(await compute(addUserFromList, UserModel.testUsers())));

    on<AddUser>((event, emit) async {
      var data = event.data;
      if(data != null) {
        UserModel user = UserModel.fromMap(data) ;
        await userBox.put(user.createdTime,json.encode(user.toMap())) ;
      }
    });

    on<LoadUsers>((event, emit) async {
      if(event.users == null) {
        List<String> data = [] ;
        for(var key in userBox.keys.toList()) {
          String? value = await userBox.get(key) ;
          if(value != null) {
            data.add(value) ;
          }
        }
        List<UserModel> users = data.map((e) => UserModel.fromMap(json.decode(e))).toList() ;
        emit(UserLoaded(users: users,isDeletedMode: false)) ;
      }else {
        bool isDeletedMode = event.users!.map((e) => e.selected).toList().where((element) => element).isNotEmpty;
        emit(UserLoaded(users: event.users!,isDeletedMode: isDeletedMode)) ;
      }
    });

  }
}
