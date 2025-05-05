import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //late UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              width: double.infinity,
              height: 300,
              child: Image.asset(
                "images/Logo.png",
                fit: BoxFit.fill,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 170,
            child: ListView.separated(
              separatorBuilder: (context, i) {
                return const Divider(
                  height: 20,
                  color: Colors.transparent,
                );
              },
              itemBuilder: (context, i) {
                return i == 0
                    ? TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Username",
                              style: TextStyle(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      )
                    : TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            label: Text(
                              "Password",
                              style: TextStyle(color: Colors.white),
                            )));
              },
              itemCount: 2,
            ),
          ),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white),
                  )),
              GestureDetector(
                onTapDown: (tab) {},
                onTapUp: (tab) {
                  Navigator.of(context).pushReplacementNamed("SignUp");
                },
                onTapCancel: () {},
                child: const Text(
                  " Create an account",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTapDown: (tab) {},
            onTapUp: (tab) async {
              ///LOGIN ANONYMOUS ACCOUNT//
              try {
                final userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                print("Signed in with temporary account.");
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case "operation-not-allowed":
                    print(
                        "Anonymous auth hasn't been enabled for this project.");
                    break;
                  default:
                    print("Unknown error.");
                }
              }
              Navigator.of(context).pushReplacementNamed("HomePage");
            },
            onTapCancel: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 25),
              child: const Text(
                " Sign in Anonymously?",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
            height: 30,
          ),
          GestureDetector(
            onTapDown: (tab) {},
            onTapUp: (tab) async {
              Navigator.of(context).pushReplacementNamed("HomePage");
            },
            onTapCancel: () {},
            child: Center(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 125,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times New Roman',
                          fontSize: 24),
                    ))),
          )
        ],
      ),
    ));
  }
}
