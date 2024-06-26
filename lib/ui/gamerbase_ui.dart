import 'dart:math';

import 'package:app4/data/gamemode_realtime.dart';
import 'package:app4/model/gameMode.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/ui/gamewaiting_ui.dart';
import 'package:flutter/material.dart';

class gameModeSelection extends StatefulWidget {
  final UserData userData;

  gameModeSelection({required this.userData});

  @override
  gamerBaseScreen createState() => gamerBaseScreen(userData: userData);
}

class gamerBaseScreen extends State<gameModeSelection> {
  final UserData userData;

  gamerBaseScreen({required this.userData});

  bool firstButtonSelected = false;
  bool secondButtonSelected = false;
  bool mode = true;
  

  void selectFirstButton() {
    setState(() {
      firstButtonSelected = true;
      secondButtonSelected = false;
      mode = true;
    });
  }

  void selectSecondButton() {
    setState(() {
      firstButtonSelected = false;
      secondButtonSelected = true;
      mode = false;
    });
  }

  int number = 4;

  void incrementNumber() {
    setState(() {
      if (number < 7) {
        number++;
      }
    });
  }

  void decrementNumber() {
    setState(() {
      if (number > 4) {
        number--;
      }
    });
  }

  Random random = Random();
  int randomNumber = 0;

  void gotoWait(int roomID) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => gameWaiting(roomID: roomID, userData: userData)),
    );
  }

  Gamemode_RT rt = new Gamemode_RT();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Yeni Oda Oluştur',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(50, 168, 82, 0.8),
                  Color.fromRGBO(115, 250, 248, 0.8)
                ]))),
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.white),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(115, 250, 248, 0.5),
                            Color.fromRGBO(50, 168, 82, 0.5)
                          ]))),
                  Column(children: [
                    SizedBox(height: 5),
                    Row(children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text("Kullanıcı ID: ",
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("${userData.uid}",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ]),
                    SizedBox(height: 2),
                    Row(children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text("Kullanıcı Adı: ${userData.displayName}",
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ]),
                  ])
                ],
              ),
              SizedBox(height: 30),
              Text("Oyun Modunu Belirleyin",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Container(
                  width: 280,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!firstButtonSelected) {
                        selectFirstButton();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          firstButtonSelected ? Colors.white12 : Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: firstButtonSelected ? 20 : 30,
                          horizontal: 40),
                    ),
                    child: Text('Harf Sabiti\n    Modu',
                        style: TextStyle(
                            color: firstButtonSelected
                                ? Colors.white
                                : Color.fromRGBO(50, 168, 82, 1))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!secondButtonSelected) {
                        selectSecondButton();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          secondButtonSelected ? Colors.white12 : Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: secondButtonSelected ? 20 : 30,
                          horizontal: 33),
                    ),
                    child: Text('Serbest\n   Mod',
                        style: TextStyle(
                            color: secondButtonSelected
                                ? Colors.white
                                : Color.fromRGBO(50, 168, 82, 1))),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text("Kelime Harf Sayısını Belirleyin",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Container(
                  width: 350,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white)),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  onPressed: decrementNumber,
                  icon: Icon(Icons.arrow_left, size: 50, color: Colors.white),
                ),
                Text(
                  '$number',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
                  onPressed: incrementNumber,
                  icon: Icon(Icons.arrow_right, size: 50, color: Colors.white),
                )
              ]),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (mode) {
                      randomNumber = random.nextInt(90000) + 10000;
                      rt.addItem(gameMode("Harf Sabiti Modu", number,
                              userData.displayName, " ", randomNumber.toString())
                          .toJson());
                      gotoWait(randomNumber);
                    } else {
                      randomNumber = random.nextInt(90000) + 10000;
                      rt.addItem(gameMode("Serbest Mod", number,
                              userData.displayName, " ", randomNumber.toString())
                          .toJson());
                      gotoWait(randomNumber);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 19, horizontal: 40),
                  ),
                  child: Text("Odayı Oluştur ve Bekle",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(50, 168, 82, 1)))),
            ],
          )
        ]));
  }
}
