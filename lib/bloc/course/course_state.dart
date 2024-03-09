part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseModel> courses ;
  final bool isDeletedMode ;
  CourseLoaded({required this.courses,required this.isDeletedMode}) ;
}
