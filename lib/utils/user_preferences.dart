import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:io_project/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

User? user = FirebaseAuth.instance.currentUser;
String? a = user!.displayName;
String? b = user!.email;
String? c = user!.uid;
String? downloadURL = user!.photoURL;

class UserPreferences {
  static final myUser = Users(
    name: a!,
    imagePath: downloadURL!,
    email: b!,
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}
