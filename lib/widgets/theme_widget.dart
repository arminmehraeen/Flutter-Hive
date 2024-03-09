import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/constants.dart';

import '../bloc/app_theme_cubit.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MaterialColor>(
        itemBuilder: (context) {
          return Constants.colors
              .map((e) => PopupMenuItem<MaterialColor>(
            value: e,
            child: Center(
                child: Icon(
                  Icons.circle,
                  color: e,
                )),
          ))
              .toList();
        },
        onSelected: (value) => context.read<AppThemeCubit>().changeColor(color: value) ,
        constraints: const BoxConstraints(
          maxWidth: 60,
        ),
        position: PopupMenuPosition.under,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:  Icon(Icons.color_lens_outlined),
        ));
  }
}
