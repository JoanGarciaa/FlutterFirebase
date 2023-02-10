import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();


  Widget _title() {
    return const Text('Firebase Auth');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
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
              await Auth().signInWithEmailAndPassword(_controllerEmail.text,_controllerPassword.text).then((_){
                if(Auth().currentUser?.emailVerified == true){
                  Navigator.pushNamed(context, '/');
                }else{
                  print("nonono, verifica ");
                }
              });
            }, child: Text('Login')),
            ElevatedButton(onPressed: ()async{
              Navigator.pushNamed(context, '/register');
            }, child: Text('Register'))
          ],
        ),
      ),
    );
  }
}
