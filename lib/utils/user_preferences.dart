import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:io_project/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

User? user = FirebaseAuth.instance.currentUser;
String? a = user!.displayName;
String? b = user!.email;
String? c = user!.uid;
String? downloadURL = user!.photoURL;
String? about = "";
Future<void> getAbout() async {
  await FirebaseFirestore.instance
      .collection('about')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => {about = value as String});
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
