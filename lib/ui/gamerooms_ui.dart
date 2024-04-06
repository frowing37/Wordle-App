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
    _loadGameModes();
  }

  _loadGameModes() async {
    List<gameMode> modes = await rt.readItems();
    setState(() {
      gameModes = modes;
    });
  }


  void createRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gameModeSelection(userData: userData)),
      );
  }

  @override
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
      : ListView.builder(
          shrinkWrap: true,
          itemCount: gameModes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Oyun Modu: ${gameModes[index].name}'),
              subtitle: Text('Harf Sayısı: ${gameModes[index].letterCount}\nOda Kurucusu: ${gameModes[index].user1}'),
            );
          }
        ),
        SizedBox(height: 30),
    ElevatedButton(
      onPressed: (){ createRoom(); },
      child: Text("Oda Oluştur",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold ,color: Color.fromRGBO(50, 168, 82, 1)))
    )
  ]
)
);
  }

}