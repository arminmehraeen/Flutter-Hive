import 'package:flutter/material.dart';
import 'package:flutter_hive/models/course_model.dart';
import 'package:flutter_hive/models/user_model.dart';
import 'package:flutter_hive/widgets/form_field_widget.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key, this.course});
  final CourseModel? course ;
  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController() ;
  TextEditingController sizeController = TextEditingController() ;

  @override
  void initState() {
    super.initState();

    if(widget.course != null) {
      CourseModel course = widget.course! ;
      nameController.text = course.name ;
      sizeController.text = course.size.toString() ;
    }

  }

  onValidationForm() {
    if(_formKey.currentState!.validate()) {
      CourseModel courseModel = CourseModel(name: nameController.text, size: int.parse(sizeController.text), createdTime: DateTime.now().toString()) ;
      Navigator.pop(context, courseModel.toMap());
    }
  }

  bool get isCreate => widget.course == null ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isCreate ? "New Course" : "Update Course"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                FormFieldWidget(controller: nameController, label: "Name"),
                Container(height: 10,),
                FormFieldWidget(controller: sizeController, label: "Size"),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                        ),
                        icon: const Icon(Icons.save),
                        onPressed: () => onValidationForm(), label: Text(isCreate ? "Save" : "Update")),
                    if(isCreate) ...[
                      const SizedBox(width: 5,),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                          icon: const Icon(Icons.person),
                          onPressed: () => Navigator.pop(context, UserModel.testUser.toMap()), label: const Text("Test Course")),
                    ]
                  ],
                )
              ],
            )),
      ),
    );
  }
}
