import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/course/course_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';
import 'package:flutter_hive/locator.dart';
import 'package:flutter_hive/views/home_screen.dart';


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
          ThemeData theme = ThemeData(
              useMaterial3: false,
              primarySwatch: state.color,
              // colorScheme: ColorScheme.fromSeed(seedColor: state.color),
          );
          return MaterialApp(
              title: 'Flutter Hive',
              debugShowCheckedModeBanner: false,
              theme: theme ,
              darkTheme: theme ,
              themeMode: state.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light ,
              home: const HomeScreen()) ;
        },));
  }
}
