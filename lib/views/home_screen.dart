import 'package:flutter/material.dart';
import 'package:flutter_hive/models/appbar_model.dart';
import 'package:flutter_hive/views/course/course_screen.dart';
import 'package:flutter_hive/views/user/user_screen.dart';
import 'package:flutter_hive/widgets/brightness_widget.dart';
import 'package:flutter_hive/widgets/theme_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<AppBarModel> data = [
    const AppBarModel(label: "Users", iconData: Icons.person_outline, body: UserScreen()) ,
    const AppBarModel(label: "Courses", iconData: Icons.book_outlined, body: CourseScreen()) ,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: data.length ,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: data.map((e) => Tab(
                  child: Row(
                    children: [
                      Icon(e.iconData),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(e.label)
                    ],
                  )),).toList()
            ),
            actions: const [ThemeWidget(), BrightnessWidget()],
            title: const Text("Flutter Hive"),
          ),
          body: TabBarView(children: data.map((e) => e.body).toList()),
        ));
  }
}
