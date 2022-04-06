import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int _weight = 0;
  int _height = 0;

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
                setData(170, 50);
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
              onChanged: (about) async {
                await FirebaseFirestore.instance
                    .collection("about")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'about': about,
                });
              },
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(labelText: "Enter your height"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (height) async {
                /*await FirebaseFirestore.instance
                    .collection("test")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'height': h,
                });*/
                _height = int.parse(height);
              },
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(labelText: "Enter your weight"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (weight) async {
                _weight = int.parse(weight);
                await FirebaseFirestore.instance
                    .collection("test")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'height': _height,
                  'weight': _weight,
                });
              },
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
      String _productName, String _productPrice, bool _isFavorite) async {
    await FirebaseFirestore.instance.collection("products").add({
      'productName': _productName,
      'productPrice': _productPrice,
      'isFavourite': _isFavorite,
    });
  }

  ///WAZNEEEEE !!
  Future<void> setData(int _height, int _weight) async {
    await FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'height': _height,
      'weight': _weight,
    });
  }

  Future<void> setHeight(int _height) async {
    await FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'height': _height,
    });
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }
  /*
  Future uploadData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    // final destination = 'gs://io-project-a029c.appspot.com/$fileName';
    try {
      await FirebaseFirestore.instance.ref('$id/profilePic').putFile(_photo!);
      //await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }
  */
  /*  StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('test')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading data ... Plesase wait ...');
                  }
                  return Column(
                    children: <Widget>[
                      Text(snapshot[0]),
                      Text(snapshot),
                    ],
                  );
                }))
                */
}
