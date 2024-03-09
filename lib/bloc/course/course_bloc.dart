import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hive/models/course_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {

  final LazyBox<String> courseBox ;

  CourseBloc({required this.courseBox}) : super(CourseLoading()) {

    courseBox.watch().listen((event) => add(LoadCourses())) ;

    on<DisposeBox>((event, emit) async => await courseBox.close());

    on<DeleteCourse>((event, emit) => courseBox.deleteAt(event.index));

    on<DeleteCourses>((event, emit) async {

      if(event.courses.isEmpty) {
        courseBox.clear();
      }else{
        await courseBox.deleteAll(event.courses.map((e) => e.createdTime));
      }
    });

    on<UpdateCourse>((event, emit) async {
      var data = event.data ;
      if(data != null) {
        CourseModel course = CourseModel.fromMap(data) ;
        await courseBox.putAt(event.index, json.encode(course.toMap())) ;
      }
    });

    Future<Map<dynamic,String>> addCourseToList(List<CourseModel> courses) async {
      Map<dynamic,String> data = {} ;
      for(var course in courses) {
        course = course.copyWith(createdTime: DateTime.now().toString());
        data[course.createdTime] = json.encode(course.toMap()) ;
        await Future.delayed(const Duration(milliseconds: 1));
      }

      return data ;
    }

    on<AddCourses>((event, emit) async {
      courseBox.putAll(await compute(addCourseToList, CourseModel.testCourses()));
    });

    on<AddCourse>((event, emit) async {
      var data = event.data;
      if(data != null) {
        CourseModel user = CourseModel.fromMap(data) ;
        await courseBox.put(user.createdTime,json.encode(user.toMap())) ;
      }
    });

    on<LoadCourses>((event, emit) async {

      if(event.courses == null) {

        List<String> data = [] ;
        for(var key in courseBox.keys.toList()) {
          String? value = await courseBox.get(key) ;
          if(value != null) {
            data.add(value) ;
          }
        }
        List<CourseModel> courses = data.map((e) => CourseModel.fromMap(json.decode(e))).toList() ;
        emit(CourseLoaded(courses: courses,isDeletedMode: false)) ;
      }else {
        bool isDeletedMode = event.courses!.map((e) => e.selected).toList().where((element) => element).isNotEmpty;
        emit(CourseLoaded(courses: event.courses!,isDeletedMode: isDeletedMode)) ;
      }
    });

  }
}
