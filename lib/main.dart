import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/course/course_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';
import 'package:flutter_hive/locator.dart';
import 'package:flutter_hive/views/home_screen.dart';
import 'package:flutter_hive/views/user/user_screen.dart';

import 'bloc/app_theme_cubit.dart';

void main() async {
  await setup() ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<UserBloc>()),
          BlocProvider(create: (_) => locator<CourseBloc>()),
          BlocProvider(create: (_) => locator<AppThemeCubit>()),
        ],
        child: BlocBuilder<AppThemeCubit,AppThemeState>(builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Hive',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: state.color,
                brightness: state.brightness
              ),
              home: const HomeScreen()) ;
        },));
  }
  
}
