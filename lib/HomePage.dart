import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:io_project/profile_page.dart';
import 'ProfileScreen.dart';
import 'package:io_project/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Firebase init
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for this email adress");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("KittelKrol",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )),
          const Text("Let's start the workout !!!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 44.0,
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "e-mail",
              prefixIcon: Icon(Icons.mail, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(Icons.security, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text("Forgot your password?",
              style: TextStyle(color: Color(0xFF817DC0))),
          const SizedBox(
            height: 18.0,
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
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  }
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
