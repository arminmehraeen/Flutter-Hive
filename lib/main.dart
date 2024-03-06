import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';
import 'package:flutter_hive/locator.dart';
import 'package:flutter_hive/views/user_screen.dart';

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
        ],
        child: MaterialApp(
            title: 'Flutter Hive',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            home: const UserScreen()));
  }
  
}
