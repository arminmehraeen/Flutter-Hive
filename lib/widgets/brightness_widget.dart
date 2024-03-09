import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_theme_cubit.dart';

class BrightnessWidget extends StatelessWidget {
  const BrightnessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit,AppThemeState>(builder: (context, state) {

      bool isDark = state.brightness == Brightness.dark ;
      Brightness brightness = isDark ? Brightness.light : Brightness.dark ;
      IconData icon = isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined;

      return IconButton(onPressed: () =>
          context.read<AppThemeCubit>().changeColor(brightness: brightness) , icon: Icon(icon));
    },);
  }
}
