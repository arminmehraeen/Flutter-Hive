import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState(color: Colors.green,brightness: Brightness.dark));
  void changeColor({MaterialColor? color, Brightness? brightness}) {
    emit(AppThemeState(color: color ?? state.color ,brightness: brightness ?? state.brightness)) ;
  }
}
