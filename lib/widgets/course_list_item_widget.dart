import 'package:flutter/material.dart';
import 'package:flutter_hive/models/course_model.dart';

class CourseListItemWidget extends StatefulWidget {

  const CourseListItemWidget({super.key, required this.course, required this.onDelete, required this.onView, required this.onSelected});

  final CourseModel course ;
  final Function() onDelete ;
  final Function(CourseModel course) onView ;
  final Function(CourseModel course) onSelected ;

  @override
  State<CourseListItemWidget> createState() => _CourseListItemWidgetState();
}

class _CourseListItemWidgetState extends State<CourseListItemWidget> {

  late CourseModel course ;

  @override
  void initState() {
    super.initState();
    course = widget.course ;
  }

  @override
  void didUpdateWidget(covariant CourseListItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    course = widget.course ;
  }

  @override
  Widget build(BuildContext context) {

    bool selected = course.selected ;
    Color color = Theme.of(context).primaryColor ;

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () => widget.onView(widget.course),
        trailing: IconButton(onPressed: () => widget.onDelete() , icon: const Icon(Icons.close,size: 14)),
        leading: GestureDetector(
            onTap: () {
              setState(() {
                course = course.copyWith(selected: !selected ) ;
                widget.onSelected(course);
              });
            },
            child: Icon(selected ? Icons.done : Icons.person ,color: selected ? color : null)),
        title: Text(course.name,style: TextStyle(color: selected ? color : null)),
        subtitle: Text("Size: ${course.size}"),
      ),
    );
  }
}
