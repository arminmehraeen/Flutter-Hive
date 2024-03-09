part of 'app_theme_cubit.dart';

class AppThemeState {

  final MaterialColor color ;
  final Brightness brightness ;

  const AppThemeState({
    required this.color,
    required this.brightness,
  });

  AppThemeState copyWith({
    MaterialColor? color,
    Brightness? brightness,
  }) {
    return AppThemeState(
      color: color ?? this.color,
      brightness: brightness ?? this.brightness,
    );
  }

}
