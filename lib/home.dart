import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

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
        title: const Text("Flutter Hive"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () async {
                  await userBox.put("user_${DateTime.now()}","User ${DateTime.now()}") ;
                }, child: const Text("Insert data")),
                const SizedBox(width: 5,),
                ElevatedButton(onPressed: () async {
                  userBox.clear();
                }, child: const Text("Clear")),
              ],
            ),
          ),
          Expanded(child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String name = data[index] ;
                List<String> nameSplit = name.split(" ");
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(onPressed: () async {
                        await userBox.deleteAt(index);
                      }, icon: const Icon(Icons.close)),
                      IconButton(onPressed: () async {
                        await userBox.putAt(index,"${nameSplit.first} ${DateTime.now()}");
                      }, icon: const Icon(Icons.edit))
                    ],
                  ),
                  leading: const Icon(Icons.person),
                  title: Text(nameSplit.first),
                  subtitle: Text(nameSplit.last),
                ) ;
              }))

        ],
      ),
    );
  }
}
