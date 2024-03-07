import 'package:flutter_hive/bloc/app_theme_cubit.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';


GetIt locator = GetIt.instance;

setup() async {

  // hive
  LazyBox<String> userBox = await Hive.openLazyBox<String>("hive_user");
  locator.registerSingleton<LazyBox<String>>(userBox) ;

  // bloc
  locator.registerSingleton<UserBloc>(UserBloc(userBox: locator<LazyBox<String>>()));

  // cubit
  locator.registerSingleton<AppThemeCubit>(AppThemeCubit());
}