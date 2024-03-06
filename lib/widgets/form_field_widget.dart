import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({super.key, required this.controller, required this.label});
  final TextEditingController controller ;
  final String label ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if(value == null) {
          return "This field is required";
        }
        if(value.isEmpty) {
          return "This field is required";
        }
        return null ;
      },
      decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder()
      ),
    );
  }
}
