part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<String> data ;
  UserLoaded({required this.data}) ;
}

