import 'package:flutter/cupertino.dart';

class AppBarModel {

  final String label ;
  final IconData iconData ;
  final Widget body ;

  const AppBarModel({
    required this.label,
    required this.iconData,
    required this.body,
  });
}