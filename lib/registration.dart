import 'package:flutter/material.dart';
import 'package:io_project/ProfilePage.dart';
import 'package:io_project/LoginPage.dart';
import 'package:io_project/constants.dart';
import 'LoginFailed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_project/ProfilePage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

// ignore: camel_case_types
class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String username;
  bool showProgress = false;

  /*Future<String> uploadString(User a) async {
    String id = a.uid;
    String dataUrl = 'assets/images/profilePic.jpg';
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('$id/profilePic')
          .putString(dataUrl, format: firebase_storage.PutStringFormat.dataUrl);

      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('$id/profilePic')
          .getDownloadURL();
      return downloadURL;
    } catch (e) {
      return "XD";
      // e.g, e.code == 'canceled'
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                mBackgroundColor,
                Color(0xFF817DC0),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(
                  hintText: "Enter your username",
                  prefixIcon: Icon(Icons.person_add_alt, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.mail, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.security, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //TWORZENIE KONTA W FIREBASE
              SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFFC7B8F5),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(12.0)),
                    onPressed: () async {
                      setState(() {
                        showProgress = true;
                      });
                      try {
                        UserCredential newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newuser != null) {
                          User? user = newuser.user;
                          String id = user!.uid;
                          user.updateDisplayName(username);
                          // String url = uploadString(user) as String;
                          user.updatePhotoURL(
                              'https://firebasestorage.googleapis.com/v0/b/io-project-a029c.appspot.com/o/starting.jpg?alt=media&token=70f2f2d3-df27-46d3-9864-e04bfd700f25');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                          setState(() {
                            showProgress = false;
                          });
                        }
                      } catch (e) {}
                    },
                    child: const Text(
                      "Create account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF8F8F8),
                        fontSize: 18.0,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
