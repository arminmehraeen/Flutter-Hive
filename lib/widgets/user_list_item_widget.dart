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
    super.initState();
    user = widget.user ;
  }

  @override
  void didUpdateWidget(covariant UserListItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    user = widget.user ;
  }

  @override
  Widget build(BuildContext context) {

    bool selected = user.selected ;
    Color color = Theme.of(context).primaryColor ;

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () => widget.onView(widget.user),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () => widget.onDelete() , icon: const Icon(Icons.close,size: 14)),
          ],
        ),
        leading: GestureDetector(
            onTap: () {
              setState(() {
                user = user.copyWith(selected: !selected ) ;
                widget.onSelected(user);
              });
            },
            child: Icon(selected ? Icons.done : Icons.person ,color: selected ? color : null)),
        title: Text("${user.firstName} ${user.lastName}",style: TextStyle(color: user.selected ? color : null)),
        subtitle: Text(user.phoneNumber),
      ),
    );
  }
}
