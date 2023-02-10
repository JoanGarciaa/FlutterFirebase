import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myflutterapp/login/login_page.dart';
import 'package:myflutterapp/pages/add_user.dart';
import 'package:myflutterapp/pages/modify_user.dart';
import 'package:myflutterapp/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:myflutterapp/pages/home_page.dart';

import 'login/register_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: MaterialApp(
            title: 'Flutter Demo',
            initialRoute: '/login',
            routes: {
              '/': (context) => const Home(),
              '/add': (context) => const AddUserPage(),
              '/modify': (context) => const ModifyUserPage(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
            },
          ));
}

