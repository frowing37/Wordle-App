import 'dart:async';

import 'package:app4/model/gameMode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';

class Gamemode_RT {

  DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("gameMode/");

  Future<List<gameMode>> readItems() async {
  Completer<List<gameMode>> completer = Completer<List<gameMode>>();
  List<gameMode> gameModes = [];
  try {
    var subscription;
    subscription = _dbRef.onValue.listen((event) {
      var json = event.snapshot.value;
      if (json != null && json is Map) {
        json.forEach((key, value) {
          gameMode mode = gameMode(
            value["name"],
            value["letterCount"],
            value["user1"],
            value["user2"],
            value["roomID"]
          );
          gameModes.add(mode);
        });
        // İşlem tamamlandıktan sonra aboneliği iptal et
        subscription.cancel();
        completer.complete(gameModes);
      }
    });
  } catch (error) {
    print(error);
    return gameModes;
  }
  return completer.future;
}

  void addItem(Map<String, dynamic> data) async {
    _dbRef.push().set(data);
  }

  void deleteItem(int roomId) async {

  }

}