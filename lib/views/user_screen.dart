import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';

import 'package:flutter_hive/models/user_model.dart';
import 'package:flutter_hive/views/add_screen.dart';
import 'package:flutter_hive/widgets/user_list_item_widget.dart';



class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsers());
  }

  @override
  void dispose() {
    super.dispose();
    context.read<UserBloc>().add(DisposeBox());
  }

  void addAction(UserEvent userEvent) => context.read<UserBloc>().add(userEvent)  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddScreen()));
                addAction(AddUser(data: response)) ;
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () => addAction(DeleteUsers()),
              icon: const Icon(Icons.delete)),
        ],
        title: const Text("Users"),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoaded) {
            List<UserModel> users = state.users;

            if (users.isEmpty) {
              return const Center(
                child: Text("No data found in database"),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return UserListItemWidget(
                      user: users[index],
                      onView: (user) async {
                        var response = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddScreen(
                                      user: user,
                                    )));
                        addAction(UpdateUser(data: response,index: index)) ;
                      },
                      onDelete: () => addAction(DeleteUser(index: index))
                    );
                  }),
            );
          }
          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
