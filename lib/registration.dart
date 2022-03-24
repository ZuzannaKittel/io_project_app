import 'package:flutter/material.dart';
import 'package:io_project/ProfilePage.dart';
import 'package:io_project/LoginPage.dart';
import 'package:io_project/constants.dart';
import 'LoginFailed.dart';

class RegitrationPage extends StatefulWidget {
  const RegitrationPage({Key? key}) : super(key: key);

  @override
  State<RegitrationPage> createState() => _RegitrationPageState();
}

//TODO: Podpiecie do bazy danych
// ignore: camel_case_types
class _RegitrationPageState extends State<RegitrationPage> {
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
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.mail, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.security, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  prefixIcon: Icon(Icons.account_box, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFFC7B8F5),
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(12.0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
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
