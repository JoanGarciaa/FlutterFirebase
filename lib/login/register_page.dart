import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RegisterPage"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerEmail,
              decoration: const InputDecoration(
                  hintText: 'Correo'
              ),
            ),
            TextField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                  hintText: 'Password'
              ),
            ),
            ElevatedButton(onPressed: ()async{
              await Auth().createUserWithEmailAndPassword(_controllerEmail.text,_controllerPassword.text).then((_){
                Auth().sendEmailVerification();
                Navigator.pushNamed(context, '/login');
              });
            }, child: Text('Register')),
            ElevatedButton(onPressed: ()async{
              Navigator.pushNamed(context, '/login');
            }, child: Text('Login'))
          ],
        ),
      ),
    );
  }
}





