part of 'app_theme_cubit.dart';

class AppThemeState {

  final MaterialColor color ;

  const AppThemeState({
    required this.color,
  });

  AppThemeState copyWith({
    MaterialColor? color,
  }) {
    return AppThemeState(
      color: color ?? this.color,
    );
  }

}
