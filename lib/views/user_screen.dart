import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive/bloc/user/user_bloc.dart';

import 'package:flutter_hive/models/user_model.dart';
import 'package:flutter_hive/views/add_screen.dart';
import 'package:flutter_hive/widgets/user_list_item_widget.dart';

import '../bloc/app_theme_cubit.dart';



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
        leading: BlocBuilder<UserBloc,UserState>(builder: (context, state) {

          if(state is UserLoaded && state.isDeletedMode) {
            return IconButton(onPressed: () => addAction(LoadUsers()), icon: const Icon(Icons.arrow_back));
          }

          return Container() ;
        },),
        actions: [
          BlocBuilder<AppThemeCubit,AppThemeState>(builder: (context, state) {
            return InkWell(
              onTap: () {
                context.read<AppThemeCubit>().changeColor(state.color) ;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 1),
                    shape: BoxShape.circle,
                    color:state.color
                ),
              ),
            );
          },)
        ],
        centerTitle: true,
        title: const Text("Users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0).copyWith(bottom: 0),
            child: Row(
              children: [
                Expanded(child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () => addAction(DeleteUsers()),
                    icon: const Icon(Icons.delete_forever_outlined),
                    label: const Text("Clear All"))),
                const SizedBox(width: 10,),
                Expanded(child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => addAction(AddUsers()), label: const Text("Import Users"))),
              ],
            ),
          ) ,
          Expanded(child: BlocConsumer<UserBloc, UserState>(
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
                }else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return UserListItemWidget(
                              onSelected: (user) {
                                users[index] = user ;
                                addAction(LoadUsers(users: users)) ;
                              },
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
              }
              return Container();
            },
            listener: (context, state) {},
          )) ,
        ],
      ),
      floatingActionButton: BlocBuilder<UserBloc,UserState>(builder: (context, state) {

        if(state is UserLoaded && state.isDeletedMode) {

          return FloatingActionButton(
              onPressed: () async {
                addAction(DeleteUsers(users: state.users.where((element) => element.selected).toList())) ;
              }
              ,child: const Icon(Icons.delete)) ;
        }
        return FloatingActionButton(
            onPressed: () async {
              var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddScreen()));
              addAction(AddUser(data: response)) ;
            }
            ,child: const Icon(Icons.add)) ;
      },)
    );
  }
}
