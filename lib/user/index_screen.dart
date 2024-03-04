

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive/user/add_screen.dart';
import 'package:flutter_hive/user/user_model.dart';
import 'package:hive/hive.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {

  late LazyBox<String> userBox ;
  List<String> data = [] ;

  @override
  void initState() {
    openBox() ;
    super.initState();
  }

  loadData () async {
    data = [] ;
    List keys = userBox.keys.toList();
    for(var key in keys) {
      String? value = await userBox.get(key) ;
      if(value != null) {
        data.add(value) ;
      }
    }
    setState(() {});
  }

  openBox () async {
    userBox = await Hive.openLazyBox<String>("hive_user");

    userBox.watch().listen((event) => loadData());

    loadData();
  }

  @override
  void dispose() {
    closeBox() ;
    super.dispose();
  }

  closeBox () async {
    if(userBox.isOpen) {
      await userBox.close() ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddScreen()));
            if(response != null) {
              List<String> information = response ;
              UserModel user = UserModel(firstName: information.first, lastName: information.last ) ;
              
              await userBox.put(DateTime.now().toString(),json.encode(user.toMap())) ;
            }
          }, icon: const Icon(Icons.add)),
          IconButton(onPressed: () => userBox.clear(), icon: const Icon(Icons.delete)),
        ],
        title: const Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              UserModel user = UserModel.fromMap(json.decode(data[index])) ;
              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () async {
                    var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen(
                      user: user,
                    )));
                    if(response != null) {
                      await userBox.putAt(index, json.encode(user.toMap())) ;
                    }
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () async {
                        await userBox.deleteAt(index);
                      }, icon: const Icon(Icons.close)),
                    ],
                  ),
                  leading: const Icon(Icons.person),
                  title: Text(user.firstName),
                  subtitle: Text(user.lastName),
                ) ,
              );
            }),
      ) ,
    );
  }
}
