import 'dart:async';

import 'package:app4/data/gamemode_realtime.dart';
import 'package:app4/data/thGame_realtime_database.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/ui/gameStarting.dart';
import 'package:app4/ui/gamerooms_ui.dart';
import 'package:flutter/material.dart';

class gameWaiting extends StatefulWidget {
  
  final int roomID;
  final UserData userData;
  gameWaiting({required this.roomID, required this.userData});
  
  @override
  _gameWaiting createState() => _gameWaiting(roomID: roomID, userData: userData);
}

class _gameWaiting extends State<gameWaiting> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int roomID;
  final UserData userData;

  _gameWaiting({required this.roomID, required this.userData});

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    time();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void time() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      // Her 2 saniyede bir UI'yı yenileyin
      controlRoom(roomID.toString());
    });
  }

  Gamemode_RT rt = Gamemode_RT();
  theGame_RT game_rt = theGame_RT();
  bool isReady = true;

  void controlRoom(String roomID) async {
    if(await rt.roomIsReady(roomID) && isReady) {
      
      var result = await game_rt.getGameWithUsername(userData.displayName.toString());
      var value = await rt.getGameMode(roomID);
      isReady = false;

      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gameStarting(value?.letterCount, userData, result)),
      );  
    }
  }

  void exitAndDelete(int roomID) {
    rt.deleteItem(roomID.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activeRooms(userData: userData)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value *
                    2 *
                    3.1415926535897932, // 2pi radians = 360 degrees
                child:
                    Icon(Icons.hourglass_empty, size: 70, color: Colors.white),
              );
            },
          )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Odaya oyuncu bekleniyor ...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
          ],
        ),
        SizedBox(height: 100),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () { exitAndDelete(roomID); },
              child: Text("            Odayı Sil,\n Beklemekten Vazgeç",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(31, 107, 51, 1),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)))
        ])
      ])
    ]));
  }
}
