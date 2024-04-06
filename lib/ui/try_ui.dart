import 'dart:async';
import 'dart:html';
import 'dart:js_interop';
import 'dart:ui';
import 'package:app4/data/users.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/ui/gamerbase_ui.dart';
import 'package:app4/ui/register_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class tryload extends StatefulWidget {
  @override
  tryScreen createState() => tryScreen();
}

class tryScreen extends State<tryload> {

  tryScreen();
  UserDB user = new UserDB();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors:[Colors.indigoAccent,Colors.orange]),
                borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
        TextButton(
        onPressed: () {user.addUser("username", "email", "password");},
        child: Text("BAS LAN", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 30.0)),
        
      )]
      )
    )
  );
}

}