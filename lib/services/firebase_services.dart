import 'package:firebase_core/firebase_core.dart';
import 'package:myflutterapp/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUser() async{
  List user = [];
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser.get();
  queryUser.docs.forEach((element) {
    final Map<String,dynamic> data = element.data() as Map<String,dynamic>;
    final person = {
      "name": data['name'],
      "uid": element.id
    };

    user.add(person);
  });
  return user;
}


Future<void> addUser(String name) async{
  await db.collection('users').add({'name':name});
}

Future<void> modifyUser(String uid, String newName) async{
  await db.collection('users').doc(uid).update({'name':newName});
}

Future<void> deleteUser(String uid) async{
  await db.collection('users').doc(uid).delete();
}

