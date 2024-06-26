import 'dart:math';
import 'package:app4/firebase_options.dart';
import 'package:app4/ui/gameStarting.dart';
import 'package:app4/ui/game_ui.dart';
import 'package:app4/ui/login_ui.dart';
import 'package:app4/ui/sandtry_ui.dart';
import 'package:app4/ui/tryButton_ui.dart';
import 'package:app4/ui/try_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options : DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => loginScreen()
      }
    );
  }
}


