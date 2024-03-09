import 'package:flutter/material.dart';
import 'package:flutter_hive/views/course/course_screen.dart';
import 'package:flutter_hive/views/user/user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hive"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(5),child: Row(
              children: [
                Expanded(child: ElevatedButton.icon(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserScreen(),)) ;
                },icon: const Icon(Icons.person_outline) ,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    label: const Text("Users"))),
                const SizedBox(width: 5,) ,
                Expanded(child: ElevatedButton.icon(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseScreen(),)) ;
                }, style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    icon: const Icon(Icons.book_outlined) ,label: const Text("Courses")))
              ],
            ),)
          ],
        ),
      ),

    );
  }
}
