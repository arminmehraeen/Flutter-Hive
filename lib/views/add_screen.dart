import 'package:flutter/material.dart';
import 'package:flutter_hive/models/user_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, this.user});
  final UserModel? user ;
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController nameController = TextEditingController() ;
  TextEditingController familyController = TextEditingController() ;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.user != null) {
      nameController.text = widget.user!.firstName ;
      familyController.text = widget.user!.lastName ;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user != null ? "Update User" : "New User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: Column(
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                if(value == null) {
                  return "This field is required";
                }

                if(value.isEmpty) {
                  return "This field is required";
                }

                return null ;
              },
              decoration: const InputDecoration(
                labelText: "First name",
                border: OutlineInputBorder()
              ),
            ),
            Container(height: 10,),
            TextFormField(
              controller: familyController,
              validator: (value) {
                if(value == null) {
                  return "This field is required";
                }

                if(value.isEmpty) {
                  return "This field is required";
                }

                return null ;
              },
              decoration: const InputDecoration(
                  labelText: "Last name",
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              if(_formKey.currentState!.validate()) {
                String firstName = nameController.text ;
                String lastName = familyController.text ;
                Navigator.pop(context,[
                  firstName,lastName
                ]);
              }
            }, child: const Text("Save"))
          ],
        )),
      ),
    );
  }
}
