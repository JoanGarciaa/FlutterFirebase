import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {

  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home"),
        ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Nombre'
            ),
          ),
          ElevatedButton(onPressed: () async {
            await addUser(nameController.text).then((_){
              Navigator.pop(context);
            });
          },   child: Text("Guardar"))
        ],
      ),
    ),
    );

  }
}
