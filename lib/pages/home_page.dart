import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Material App Bar"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 10,0,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    //radius: 20,
                    //backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  //Text(user.displayName!)
                ],
              )
            ),
            FutureBuilder(
                future: getUser(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            onDismissed: (direction) async {
                              await deleteUser(snapshot.data?[index]['uid']);
                              snapshot.data?.removeAt(index);
                            },
                            confirmDismiss: (direction) async {
                              bool result = false;
                              result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Estas seguro de eliminar el user ${snapshot.data?[index]['name']}?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              return Navigator.pop(context, false);
                                            },
                                            child: Text(
                                              "NO",
                                              style: TextStyle(color: Colors.red),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              return Navigator.pop(context, true);
                                            },
                                            child: Text("SI")),
                                      ],
                                    );
                                  });
                              return result;
                            },
                            background: Container(
                              child: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            direction: DismissDirection.endToStart,
                            key: Key(snapshot.data?[index]['uid']),
                            child: ListTile(
                                title: Text(snapshot.data?[index]['name']),
                                onTap: (() async {
                                  await Navigator.pushNamed(context, '/modify',
                                      arguments: {
                                        "name": snapshot.data?[index]['name'],
                                        "uid": snapshot.data?[index]['uid'],
                                      });
                                  setState(() {});
                                })));
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
