part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final List<String>? data ;
  AddUser({required this.data} );
}

class UpdateUser extends UserEvent {
  final List<String>? data ;
  final int index;
  UpdateUser({required this.data,required this.index} );
}

class DeleteUser extends UserEvent {
  final int index;
  DeleteUser({required this.index}) ;
}

class DeleteUsers extends UserEvent {}

class DisposeBox extends UserEvent {}
