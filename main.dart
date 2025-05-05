import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/Home%20Page.dart';
import 'package:note/auth/Login.dart';
import 'package:note/auth/SignUp.dart';
import 'package:note/crud/AddNote.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Notes());
  FlutterNativeSplash.remove();
}

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Cairo",
          dividerColor: Colors.white,
          backgroundColor: Colors.white),
      home: const Login(),
      routes: {
        "Login": (context) => const Login(),
        "HomePage": (context) => const HomePage(),
        "SignUp": (context) => const SignUp(),
        "AddNote": (context) => const AddNote()
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
