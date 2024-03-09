import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState(color: Colors.green));

  void changeColor(MaterialColor color) {
    emit(AppThemeState(color: color));
  }
}
