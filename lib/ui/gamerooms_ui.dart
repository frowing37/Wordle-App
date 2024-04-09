import 'dart:async';

import 'package:app4/data/gamemode_realtime.dart';
import 'package:app4/model/gameMode.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/ui/gamerbase_ui.dart';
import 'package:flutter/material.dart';

class activeRooms extends StatefulWidget {
  
  final UserData userData;
  activeRooms({required this.userData});

  @override
  activeGameRooms createState() => activeGameRooms(userData: userData);
  
}

class activeGameRooms extends State<activeRooms> {

  final UserData userData;
  
  activeGameRooms({required this.userData});

  Gamemode_RT rt = new Gamemode_RT();
  List<gameMode> gameModes = [];

  @override
  void initState() {
    super.initState();
    _startPeriodicRefresh();
  }

  void _loadGameModes() {
    rt.readItems().then((List<gameMode> modes) {
      setState(() {
        gameModes = modes;
      });
    }).catchError((error) {
      print("Error loading game modes: $error");
    });
  }

  @override
  void dispose() {
    // Timer'ı dispose edin
    _stopPeriodicRefresh();
    super.dispose();
  }

  void _startPeriodicRefresh() {
    // Timer'ı başlatın
    Timer.periodic(Duration(seconds: 1), (timer) {
      // Her 2 saniyede bir UI'yı yenileyin
      _loadGameModes();
    });
  }

  void _stopPeriodicRefresh() {
    // Timer'ı durdurun
    // Bu aslında gerekli değil, çünkü StatefulWidget dispose olduğunda zaten otomatik olarak durdurulur
  }

  void createRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gameModeSelection(userData: userData)),
      );
  }

  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Aktif Odalar', style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 7,bottom: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white),
            gradient: LinearGradient(colors:[Color.fromRGBO(137, 235, 234, 0.8),Color.fromRGBO(50, 168, 82, 0.8)])
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text("Kullanıcı ID: ", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("${userData.uid}", style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold, color: Colors.white))
                ]
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text("Kullanıcı Adı: ${userData.displayName}", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white))
                ]
              ),
            ]
          )
        ),
        SizedBox(height: 30),
        gameModes.isEmpty 
          ? Center(child: Text("Aktif oda yok"))
          : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // ListView içindeki kaydırmayı devre dışı bırakır
                      itemCount: gameModes.length,
                      itemBuilder: (context, index) {
                        return Container(
  margin: EdgeInsets.symmetric(vertical: 5.0),
  padding: EdgeInsets.all(10.0),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(10.0),
    gradient: LinearGradient(colors: [Color.fromRGBO(95, 163, 163, 0.7),Color.fromRGBO(32, 110, 53, 0.8)])
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${gameModes[index].name}', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white)),
            SizedBox(height: 2.0),
            Text('Harf Sayısı: ${gameModes[index].letterCount}', style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold, color: Colors.white)),
            Text('Oda Kurucusu: ${gameModes[index].user1}', style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
      ElevatedButton(
        onPressed: () {}, 
        child: Icon(Icons.play_arrow,color: Colors.green, size: 35),
        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
      ),
    ],
  ),
);
                      }
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.only(bottom: 40),
            child:ElevatedButton(
                      onPressed: (){ createRoom(); },
                      child: Text("Oda Oluştur",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ,color: Color.fromRGBO(50, 168, 82, 1)))
                    ))
      ],
    ),
  );
}

}