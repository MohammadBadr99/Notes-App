import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              width: double.infinity,
              height: 300,
              child: Image.asset(
                "images/Logo.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      "User Name",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    label: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Colors.white),
                    label: Text(
                      "Phone Number",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key, color: Colors.white),
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text(
                      "Have an account?",
                      style: TextStyle(color: Colors.white),
                    )),
                GestureDetector(
                  onTapDown: (tab) {},
                  onTapUp: (tab) {
                    Navigator.of(context).pushReplacementNamed("Login");
                  },
                  onTapCancel: () {},
                  child: const Text(
                    " Login here",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.transparent,
              height: 30,
            ),
            GestureDetector(
              onTapDown: (tab) {},
              onTapUp: (tab) async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: "midok291@gmail.com",
                    password: "Ihf11111999",
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).pop();
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
                        "SignUp",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman',
                            fontSize: 24),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
