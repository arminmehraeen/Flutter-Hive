import 'package:flutter_hive/bloc/app_theme_cubit.dart';
import 'package:flutter_hive/bloc/course/course_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';


GetIt locator = GetIt.instance;

setup() async {

  // hive
  LazyBox<String> userBox = await Hive.openLazyBox<String>("hive_user");
  LazyBox<String> courseBox = await Hive.openLazyBox<String>("hive_course");

  // bloc
  locator.registerSingleton<UserBloc>(UserBloc(userBox: userBox));
  locator.registerSingleton<CourseBloc>(CourseBloc(courseBox: courseBox));

  // cubit
  locator.registerSingleton<AppThemeCubit>(AppThemeCubit());
}