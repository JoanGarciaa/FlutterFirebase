import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

class ModifyUserPage extends StatefulWidget {
  const ModifyUserPage({Key? key}) : super(key: key);

  @override
  State<ModifyUserPage> createState() => _ModifyUserPageState();
}

class _ModifyUserPageState extends State<ModifyUserPage> {

  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(title: Text("Edit Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Modifica'
              ),
            ),
            ElevatedButton(onPressed: () async {
              await modifyUser(arguments['uid'],nameController.text).then((_){
                Navigator.pop(context);
              });
            },   child: Text("Actualizar"))
          ],
        ),
      ),
    );

  }
}
