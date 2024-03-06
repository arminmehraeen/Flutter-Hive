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
  TextEditingController phoneController = TextEditingController() ;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.user != null) {
      nameController.text = widget.user!.firstName ;
      familyController.text = widget.user!.lastName ;
      phoneController.text = widget.user!.phoneNumber ;
    }
    super.initState();
  }

  onValidationForm() {

    if(_formKey.currentState!.validate()) {

      Map<String,dynamic> data = {
        'firstName': nameController.text,
        'lastName': familyController.text,
        'phoneNumber': phoneController.text ,
      };

      Navigator.pop(context, data);
    }

  }

  bool get isCreate => widget.user == null ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isCreate ? "New User" : "Update User"),
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
            Container(height: 10,),
            TextFormField(
              controller: phoneController,
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
                  labelText: "PhoneNumber",
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: () => onValidationForm(), child: Text(isCreate ? "Save" : "Update")),
                if(isCreate) ...[
                  const SizedBox(width: 5,),
                  ElevatedButton(onPressed: () => Navigator.pop(context, UserModel.testUser().toMap()), child: const Text("Test User")),
                ]
              ],
            )
          ],
        )),
      ),
    );
  }


}
