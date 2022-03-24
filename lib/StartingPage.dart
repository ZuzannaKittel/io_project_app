import 'package:flutter/material.dart';

import 'package:io_project/HomePage.dart';

class startingPage extends StatefulWidget {
  const startingPage({Key? key}) : super(key: key);

  @override
  State<startingPage> createState() => _startingPageState();
}

class _startingPageState extends State<startingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "FitApp",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black54, offset: Offset(1, 2), blurRadius: 4)
              ]),
        )),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
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
                Colors.lightBlue,
                Colors.blue,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff42a5f5),
                        offset: Offset(
                          2,
                          4,
                        ),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(
                        0xFF0389F6,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
