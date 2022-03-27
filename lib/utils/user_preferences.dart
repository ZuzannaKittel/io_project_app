import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:io_project/model/user.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
String? a = user!.displayName;
String b = a!;
String? c = user!.email;
String d = c!;

class UserPreferences {
  CollectionReference users =
      FirebaseFirestore.instance.collection('usernames');
  Stream docStream = FirebaseFirestore.instance
      .collection('usernames')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  static final myUser = Users(
    name: b,
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    email: d,
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}
