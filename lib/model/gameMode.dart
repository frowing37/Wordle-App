import 'package:app4/data/gamemode_realtime.dart';

class gameMode {

  String? name;
  int? letterCount;
  String? user1;
  String? user2;
  int? roomID;

  gameMode(this.name, this.letterCount, this.user1, this.user2, this.roomID);

  /*gameMode(String name,int letterCount, String user1, String user2, int roomID){
    this.name = name;
    this.letterCount = letterCount;
    this.user1 = user1;
    this.user2 = user2;
    this.roomID = roomID;
  }*/

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "letterCount": letterCount,
      "user1" : user1,
      "user2" : user2,
      "roomID" : roomID
    };
  }

  factory gameMode.fromJson(Map<String, dynamic> json) {
    return gameMode(
      json['name'].toString(),
      json['letterCount'],
      json['user1'].toString(),
      json['user2'].toString(),
      json['roomID']
    );
  }
}