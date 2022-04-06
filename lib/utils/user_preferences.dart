import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:io_project/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;
String? a = user!.displayName;
String? b = user!.email;
String? c = user!.uid;
String? downloadURL = user!.photoURL;
String? about = "";
DocumentSnapshot? snapshot;
Future<String> getAbout() async {
  String abt = '';
  await FirebaseFirestore.instance
      .collection("about")
      .doc(user?.uid)
      .get()
      .then((value) => {abt = value['about']});
  return abt; //get the data
}

String sd = getAbout() as String;

class UserPreferences {
  static final myUser = Users(
    name: a!,
    imagePath: downloadURL!,
    email: b!,
    about: about!,
    isDarkMode: false,
  );
}
