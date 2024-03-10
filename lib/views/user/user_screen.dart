import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';
import 'package:flutter_hive/models/user_model.dart';
import 'package:flutter_hive/views/user/add_user_screen.dart';

import 'package:flutter_hive/widgets/brightness_widget.dart';
import 'package:flutter_hive/widgets/empty_widget.dart';
import 'package:flutter_hive/widgets/theme_widget.dart';
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

  void addAction(UserEvent userEvent) => context.read<UserBloc>().add(userEvent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0).copyWith(bottom: 0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          onPressed: () => addAction(DeleteUsers()),
                          icon: const Icon(Icons.delete_forever_outlined),
                          label: const Text("Clear All"))),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => addAction(AddUsers()),
                          label: const Text("Import Users"))),
                ],
              ),
            ),
            Expanded(
                child: BlocConsumer<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserLoaded) {
                  List<UserModel> users = state.users;

                  if (users.isEmpty) {
                    return const EmptyWidget();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return UserListItemWidget(
                                onSelected: (user) {
                                  users[index] = user;
                                  addAction(LoadUsers(users: users));
                                },
                                user: users[index],
                                onView: (user) async {
                                  var response = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddUserScreen(
                                                user: user,
                                              )));
                                  addAction(
                                      UpdateUser(data: response, index: index));
                                },
                                onDelete: () =>
                                    addAction(DeleteUser(index: index)));
                          }),
                    );
                  }
                }
                return Container();
              },
              listener: (context, state) {},
            )),
          ],
        ),
        floatingActionButton: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded && state.isDeletedMode) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  if(state.isDeletedMode) Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: FloatingActionButton(
                        onPressed: () => addAction(LoadUsers()) ,
                        child: const Icon(Icons.close)),
                  ),
                  FloatingActionButton(
                  onPressed: () async {
                addAction(DeleteUsers(
                    users: state.users
                        .where((element) => element.selected)
                        .toList()));
              },
            child: const Icon(Icons.delete)),
                ],
              ) ;
            }
            return FloatingActionButton(
                onPressed: () async {
                  var response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddUserScreen()));
                  addAction(AddUser(data: response));
                },
                child: const Icon(Icons.add));
          },
        ));
  }
}
