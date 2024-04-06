import 'dart:async';

import 'package:app4/model/gameMode.dart';
import 'package:firebase_database/firebase_database.dart';

class Gamemode_RT {

  DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("gameMode");

  Future<List<gameMode>> readItems() async {
  List<gameMode> gameModes = [];

  var subscription = await _dbRef.onValue.listen((event) {
    var json = event.snapshot.value;
    if (json != null && json is Map<String,dynamic>) {
      // Veritabanından gelen veriyi gameMode nesnelerine dönüştürme
      json.forEach((key, value) {
        gameMode mode = gameMode(
          value["name"],
          value["letterCount"],
          value["user1"],
          value["user2"],
        );
        gameModes.add(mode);
      });
    }
  });
  // Veritabanı dinleyicisini temizleme
  subscription.cancel();

  return gameModes;
}

  void addItem(Map<String, dynamic> data) async {
    _dbRef.push().set(data);
  }
}