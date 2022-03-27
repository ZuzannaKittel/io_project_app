import 'package:flutter/material.dart';
import 'package:io_project/ProfilePage.dart';
import 'package:io_project/LoginPage.dart';
import 'package:io_project/constants.dart';
import 'LoginFailed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:io_project/ProfilePage.dart';

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
                          await FirebaseFirestore.instance
                              .collection('usernames')
                              .doc(user?.uid)
                              .set({'username': username});
                          user?.updateDisplayName(username);
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
