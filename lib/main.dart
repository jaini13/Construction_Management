import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_today/login.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp(),
    debugShowCheckedModeBanner: false,)
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Timer(
        Duration(seconds: 3),
            () => Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Login();
        },))
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff315ccf),
      body: Center(child: Image.asset('assets/logo.png'),),
    );
  }
}
