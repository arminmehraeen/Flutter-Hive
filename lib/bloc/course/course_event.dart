part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class LoadCourses extends CourseEvent {
  final List<CourseModel>? courses ;
  LoadCourses({this.courses});
}

class AddCourse extends CourseEvent {
  final Map<String, dynamic>? data ;
  AddCourse({required this.data} );
}

class AddCourses extends CourseEvent {}

class UpdateCourse extends CourseEvent {
  final Map<String, dynamic>? data ;
  final int index;
  UpdateCourse({required this.data,required this.index} );
}

class DeleteCourse extends CourseEvent {
  final int index;
  DeleteCourse({required this.index}) ;
}

class DeleteCourses extends CourseEvent {
  final List<CourseModel> courses ;
  DeleteCourses({this.courses = const []}) ;
}

class DisposeBox extends CourseEvent {}
