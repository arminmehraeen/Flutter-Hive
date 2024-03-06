part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final Map<String, dynamic>? data ;
  AddUser({required this.data} );
}

class AddUsers extends UserEvent {}

class UpdateUser extends UserEvent {
  final Map<String, dynamic>? data ;
  final int index;
  UpdateUser({required this.data,required this.index} );
}

class DeleteUser extends UserEvent {
  final int index;
  DeleteUser({required this.index}) ;
}

class DeleteUsers extends UserEvent {}

class DisposeBox extends UserEvent {}
