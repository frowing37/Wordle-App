import 'dart:async';
import 'dart:ui';
import 'package:app4/data/users.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/ui/gamerbase_ui.dart';
import 'package:app4/ui/gamerooms_ui.dart';
import 'package:app4/ui/register_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {

  @override
  _loginScreen createState() => _loginScreen();
}

class _loginScreen extends State<loginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  UserDB _userManager = new UserDB();
  String message = "";
  TextStyle correct = TextStyle(color: Colors.green,fontWeight: FontWeight.bold);
  TextStyle wrong = TextStyle(color: Colors.red,fontWeight: FontWeight.bold);
  bool messageState = false;
  bool log = true;

  void _login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String? uid = userCredential.user?.uid;
      String? displayName;

      if (userCredential != null) {
        var result =
            await _userManager.searchUserByEmail(_emailController.text);

        if (result.docs.isNotEmpty) {
          var document = result.docs.first;
          displayName = document["username"];
        }
      }

      UserData userData = new UserData(displayName: displayName, uid: uid);

      setState(() {
        message = "Giriş Bilgileriniz Doğru";
        messageState = true;
      });

      timeCount(userData);

      print("Giriş işlemi başarılı");
    } catch (e) {

      setState(() {
        message = "Giriş Bilgileri Hatalı";
        messageState = false;
      });

      print("Giriş hatası: $e");
    }
  }

  void timeCount(UserData userData) {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if(log) {
        setState(() {
        log = false;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => activeRooms(userData: userData)),
      );
      }
    });
  }

  @override
  void dispose() {
    // Timer'ı dispose edin
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(50, 168, 82, 0.8),
          Color.fromRGBO(115, 250, 248, 0.8)
        ])),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 90.0),
              child: Center(
                child: Text(
                  "Wordl'a \nHoşgeldin!",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 250.0),
          child: SingleChildScrollView(
              // Değişiklik burada
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: TextField(
                              controller: _emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person,
                                      color:
                                          Color.fromRGBO(115, 250, 248, 0.8)),
                                  labelText: 'Mail',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromRGBO(50, 168, 82, 0.8)))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.password,
                                      color:
                                          Color.fromRGBO(115, 250, 248, 0.8)),
                                  labelText: 'Şifre',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromRGBO(50, 168, 82, 0.8)))),
                        ),
                        SizedBox(height: 15),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [messageState ? Text(message,style: correct) : Text(message,style: wrong)]),
                        SizedBox(height: 15),
                        Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(50, 168, 82, 0.8),
                                        Color.fromRGBO(115, 250, 248, 0.8)
                                      ]),
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                            ),
                            TextButton(
                                onPressed: () {
                                  _login(context);
                                },
                                child: Text("     Giriş Yap     ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 25)))
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 50),
                              Text("Hesabınız yok mu ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 17)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(50, 168, 82, 0.8),
                                          Color.fromRGBO(115, 250, 248, 0.8)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                registerScreen()));
                                  },
                                  child: Text("   Kayıt Ol   ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)))
                            ],
                          ),
                        )
                      ])))))
    ]));
  }
}
