import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String imagePath;
  final String name;
  final String email;
  late String about;
  final bool isDarkMode;
  late String abt = '';
  Future<void> getAbout() async {
    await FirebaseFirestore.instance
        .collection("about")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {abt = value['about']});
  }

  String getImage() {
    String? downloadURL = FirebaseAuth.instance.currentUser!.photoURL;
    String a = downloadURL!;
    return a;
  }

  String getAbt() {
    getAbout();
    return abt;
  }

  Users({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });
}
