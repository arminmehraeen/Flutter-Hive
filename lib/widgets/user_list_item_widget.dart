import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive/models/user_model.dart';

class UserListItemWidget extends StatelessWidget {
  const UserListItemWidget({super.key, required this.data, required this.onDelete, required this.onView});
  final String data ;
  final Function() onDelete ;
  final Function(UserModel user) onView ;
  @override
  Widget build(BuildContext context) {

    UserModel user = UserModel.fromMap(json.decode(data)) ;

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () => onView(user) ,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () => onDelete() , icon: const Icon(Icons.close)),
          ],
        ),
        leading: const Icon(Icons.person),
        title: Text(user.firstName),
        subtitle: Text(user.lastName),
      ) ,
    );
  }
}
