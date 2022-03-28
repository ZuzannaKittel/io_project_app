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
  Future<void> uploadString(User a) async {
    String id = a.uid;
    String dataUrl =
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80';
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('$id/profilePic')
          .putString(dataUrl, format: firebase_storage.PutStringFormat.dataUrl);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

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
                          uploadString(user);
                          user.updatePhotoURL(
                              'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
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
