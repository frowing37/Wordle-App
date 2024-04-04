import 'package:app4/model/userData.dart';
import 'package:flutter/material.dart';

class ButtonSelectionDemo extends StatefulWidget {
  final UserData userData;

  const gamerBaseScreen({required this.userData});

  @override
  gamerBaseScreen createState() => gamerBaseScreen();
}

class gamerBaseScreen extends State<ButtonSelectionDemo> {
 UserData userData;

  gamerBaseScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktif Odalar', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors:[Color.fromRGBO(50, 168, 82, 0.8),Color.fromRGBO(115, 250, 248, 0.8)])
                              )
                            ),
                          ),
          Column(
        children: [
          Row(children: [Padding(padding: EdgeInsets.only(left: 10,top: 50)),Text("Kullanıcı ID: ",style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white)),Text("${userData.uid}",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold, color: Colors.white))]),
          Row(children: [Padding(padding: EdgeInsets.only(left: 10)),Text("Kullanıcı Adı: ${userData.displayName}",style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white))])
        ],
      )
        ]
      )
    );
  }
}
