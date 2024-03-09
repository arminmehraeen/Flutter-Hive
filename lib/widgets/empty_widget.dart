import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/app_theme_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});
  final double size = 300 ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit,AppThemeState>(
      builder: (context, state) {
        String asset = state.brightness == Brightness.dark ? "assets/svg/empty_light.svg" : "assets/svg/empty_dark.svg";
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset , height: size, width: size,
            ),
            const SizedBox(height: 10,),
            const Text("No data found in database"),
          ],
        ) ;
      },
    );
  }
}
