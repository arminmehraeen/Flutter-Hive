import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState(color: Colors.green,brightness: Brightness.light));

  void changeColor({MaterialColor? color, Brightness? brightness}) {
    if(color != null) {
      emit(AppThemeState(color: color,brightness: state.brightness));
    }
    if(brightness != null) {
      emit(AppThemeState(color: state.color,brightness: brightness));
    }
  }
}
