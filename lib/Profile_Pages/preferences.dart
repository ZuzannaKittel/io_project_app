import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:io_project/Profile_Pages/upload_profile_pic.dart';
import 'package:io_project/widget/bottom_nav_bar.dart';
import 'package:io_project/model/user.dart';
import 'package:io_project/utils/user_preferences.dart';
import 'package:io_project/widget/appbar_widget.dart';
import 'package:io_project/widget/profile_widget.dart';
import 'package:io_project/widget/textfield_widget.dart';
import 'package:path/path.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  Users user = UserPreferences.myUser;
  late File file;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context, "Preferences"),
        bottomNavigationBar: const BottomNavBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () {
                /*final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  file = File(pickedFile!.path);
                });*/
                uploadingData('jabłko', '18ziko za PiSu', false);
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: user.email,
              onChanged: (email) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'About',
              text: user.about,
              maxLines: 5,
              onChanged: (about) {},
            ),
          ],
        ),
      );
  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    if (file != null) {
      String url = await uploadImage();
      map['profileImage'] = url;
    }
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
    Navigator.pop(context);
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(
            FirebaseAuth.instance.currentUser!.uid + "_" + basename(file.path))
        .putFile(file);
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<void> uploadingData(
      String _productName, String _productPrice, bool _isFavourite) async {
    await FirebaseFirestore.instance.collection("products").add({
      'productName': _productName,
      'productPrice': _productPrice,
      'isFavourite': _isFavourite,
    });
  }
}
