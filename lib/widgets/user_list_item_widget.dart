import 'package:flutter/material.dart';
import 'package:flutter_hive/models/user_model.dart';

class UserListItemWidget extends StatefulWidget {

  const UserListItemWidget({super.key, required this.user, required this.onDelete, required this.onView, required this.onSelected});

  final UserModel user ;
  final Function() onDelete ;
  final Function(UserModel user) onView ;
  final Function(UserModel user) onSelected ;

  @override
  State<UserListItemWidget> createState() => _UserListItemWidgetState();
}

class _UserListItemWidgetState extends State<UserListItemWidget> {

  late UserModel user ;

  @override
  void initState() {
    user = widget.user ;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserListItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    user = widget.user ;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () => widget.onView(widget.user) ,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () => widget.onDelete() , icon: const Icon(Icons.close,size: 14,)),
          ],
        ),
        leading: GestureDetector(
            onTap: () {
              setState(() {
                user = user.copyWith(selected: !user.selected) ;
                widget.onSelected(user);
              });
            },
            child: user.selected ? Icon(Icons.done,color: Theme.of(context).primaryColor) : const Icon(Icons.person)),
        title: Text("${user.firstName} ${user.lastName}",style: TextStyle(color: user.selected ? Theme.of(context).primaryColor : null),),
        subtitle: Text(user.phoneNumber),
      ) ,
    );
  }
}
