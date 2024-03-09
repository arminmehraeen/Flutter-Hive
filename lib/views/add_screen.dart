import 'package:flutter/material.dart';
import 'package:flutter_hive/models/user_model.dart';
import 'package:flutter_hive/widgets/form_field_widget.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, this.user});
  final UserModel? user ;
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController() ;
  TextEditingController familyController = TextEditingController() ;
  TextEditingController phoneController = TextEditingController() ;

  @override
  void initState() {
    super.initState();

    if(widget.user != null) {
      UserModel user = widget.user! ;
      nameController.text = user.firstName ;
      familyController.text = user.lastName ;
      phoneController.text = user.phoneNumber ;
    }

  }

  onValidationForm() {
    if(_formKey.currentState!.validate()) {
      UserModel userModel = UserModel(firstName: nameController.text, lastName: familyController.text, phoneNumber: phoneController.text, createdTime: DateTime.now().toString()) ;
      Navigator.pop(context, userModel.toMap());
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
            FormFieldWidget(controller: nameController, label: "First Name"),
            Container(height: 10,),
            FormFieldWidget(controller: familyController, label: "Last Name"),
            Container(height: 10,),
            FormFieldWidget(controller: phoneController, label: "Phone Number"),
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
                      onPressed: () => Navigator.pop(context, UserModel.testUser.toMap()), label: const Text("Test User")),
                ]
              ],
            )
          ],
        )),
      ),
    );
  }


}
