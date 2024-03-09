import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/course/course_bloc.dart';
import 'package:flutter_hive/models/course_model.dart';
import 'package:flutter_hive/views/course/add_course_screen.dart';

import 'package:flutter_hive/widgets/brightness_widget.dart';
import 'package:flutter_hive/widgets/course_list_item_widget.dart';
import 'package:flutter_hive/widgets/empty_widget.dart';
import 'package:flutter_hive/widgets/theme_widget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(LoadCourses());
  }

  void addAction(CourseEvent courseEvent) => context.read<CourseBloc>().add(courseEvent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<CourseBloc, CourseState>(
            builder: (context, state) {
              if (state is CourseLoaded && state.isDeletedMode) {
                return IconButton(
                    onPressed: () => addAction(LoadCourses()),
                    icon: const Icon(Icons.arrow_back));
              }
              return Container();
            },
          ),
          actions: const [
            ThemeWidget() ,
            BrightnessWidget()
          ],
          centerTitle: true,
          title: const Text("Courses"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0).copyWith(bottom: 0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          onPressed: () => addAction(DeleteCourses()),
                          icon: const Icon(Icons.delete_forever_outlined),
                          label: const Text("Clear All"))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => addAction(AddCourses()),
                          label: const Text("Import Courses"))),
                ],
              ),
            ),
            Expanded(
                child: BlocConsumer<CourseBloc, CourseState>(
                  builder: (context, state) {
                    if (state is CourseLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CourseLoaded) {
                      List<CourseModel> courses = state.courses;

                      if (courses.isEmpty) {
                        return const EmptyWidget();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: courses.length,
                              itemBuilder: (context, index) {
                                return CourseListItemWidget(
                                    onSelected: (course) {
                                      courses[index] = course;
                                      addAction(LoadCourses(courses: courses));
                                    },
                                    course: courses[index],
                                    onView: (course) async {
                                      var response = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddCourseScreen(
                                                course: course,
                                              )));
                                      addAction(UpdateCourse(data: response, index: index));
                                    },
                                    onDelete: () =>
                                        addAction(DeleteCourse(index: index)));
                              }),
                        );
                      }
                    }
                    return Container();
                  },
                  listener: (context, state) {},
                )),
          ],
        ),
        floatingActionButton: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoaded && state.isDeletedMode) {
              return FloatingActionButton(
                  onPressed: () async {
                    addAction(DeleteCourses(
                        courses : state.courses
                            .where((element) => element.selected)
                            .toList()));
                  },
                  child: const Icon(Icons.delete));
            }
            return FloatingActionButton(
                onPressed: () async {
                  var response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCourseScreen()));
                  addAction(AddCourse(data: response));
                },
                child: const Icon(Icons.add));
          },
        ));
  }
}
