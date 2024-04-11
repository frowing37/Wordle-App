import 'dart:async';
import 'dart:ffi';

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
            value["name"].toString(),
            value["letterCount"],
            value["user1"].toString(),
            value["user2"].toString(),
            value["roomID"].toString()
          );
          gameModes.add(mode);
        });

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

  Future<gameMode?> updateGameMode(String user2, String roomId) async {
    Completer<gameMode> completer = Completer<gameMode>();

    try {
    var subscription;
    subscription = _dbRef.onValue.listen((event) {
      var json = event.snapshot.value;
      if (json != null && json is Map) {
        json.forEach((key, value) {
          if (value["roomID"].toString() == roomId.toString()) {
            gameMode temp = gameMode(value["name"], value["letterCount"], value["user1"], user2, value["roomID"]);
            _dbRef.child(key).update(temp.toJson()).then((_) {
              subscription.cancel();
              completer.complete(); // İşlem tamamlandı
            }).catchError((error) {
              completer.completeError(error); // Hata durumunda Completer ile hata döndürülür
            });
          }
        });
      }
    });
  } catch (error) {
    completer.completeError(error); // Hata durumunda Completer ile hata döndürülür
  }

   return completer.future;
  }

  Future<gameMode?> getGameMode(String roomID) async {
    Completer<gameMode> completer = Completer<gameMode>();
    gameMode mode = gameMode.nul();

  try {
    var subscription;
    subscription = _dbRef.onValue.listen((event) {
      var json = event.snapshot.value;
      if (json != null && json is Map) {
        json.forEach((key, value) {
          if(value["roomID"] == roomID) {
            mode = gameMode(value["name"], value["letterCount"], value["user1"], value["user2"], value["roomID"]);
            subscription.cancel();
        completer.complete(mode);
          }
        });
      }
    });
  } catch (error) {
    print(error);
  }
  return completer.future;
  }

  Future<bool> roomIsReady(String roomID) async {
    Completer<bool> completer = Completer<bool>();
    bool ready = false;

    try {
    var subscription;
    subscription = _dbRef.onValue.listen((event) {
      var json = event.snapshot.value;
      if (json != null && json is Map) {
        json.forEach((key, value) {
          if (value["roomID"]  == roomID) {
            if(value["user2"] != " ") {
              ready = true;
              completer.complete(ready);
            }
          }
        });
      }
    });
  } catch (error) {
    completer.completeError(error); // Hata durumunda Completer ile hata döndürülür
  }

   return completer.future;
  }

  Future<void> deleteItem(int roomId) async {
  Completer<void> completer = Completer<void>();

  try {
    var subscription;
    subscription = _dbRef.onValue.listen((event) {
      var json = event.snapshot.value;
      if (json != null && json is Map) {
        json.forEach((key, value) {
          if (value["roomID"].toString() == roomId.toString()) {
            _dbRef.child(key).remove().then((_) {
              subscription.cancel();
              completer.complete(); // İşlem tamamlandı
            }).catchError((error) {
              completer.completeError(error); // Hata durumunda Completer ile hata döndürülür
            });
          }
        });
      }
    });
  } catch (error) {
    completer.completeError(error); // Hata durumunda Completer ile hata döndürülür
  }

  return completer.future; // Completer'ın Future nesnesi döndürülür
}


}