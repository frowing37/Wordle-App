import 'dart:async';

import 'package:app4/model/turns.dart';
import 'package:firebase_database/firebase_database.dart';

class turns_RT {

  DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("turns/");

  void createTurnObject(String gameID, String u1ID, String u2ID) async {
    turns object = turns(gameID,u1ID,u2ID);
    _dbRef.push().set(object.toJson());
  }

  Future<turns> getTurnWithID(String? gameID) async {
    Completer<turns> completer = Completer<turns>();
    turns turnsObject = turns.nul();

    try {
      var subscription;
      subscription = _dbRef.onValue.listen((event) {
        var json = event.snapshot.value;
        if(json != null && json is Map) {
          json.forEach((key, value) {
            if(value["gameID"] == gameID) {
            turnsObject = turns.allField(value["gameID"].toString(),value["u1ID"].toString(),value["u1Turns"],value["u2ID"].toString(),value["u2Turns"]);
            }
           });

          subscription.cancel();
          completer.complete(turnsObject);
        }
       });
    } catch(error) {
      print(error);
    }

    return completer.future;
  }

  void addWordToTurns(String gameID,String userID ,String word) async {
    var subscription;
    subscription = _dbRef.onValue.listen((event) {
      var json = event.snapshot.value;
      if(json != null && json is Map) {
        json.forEach((key, value) {
          if(value["gameID"].toString() == gameID) {
            turns turnObject = turns.allField(value["gameID"].toString(),value["u1ID"].toString(),value["u1Turns"],value["u2ID"].toString(),value["u2Turns"]);
            if(value["u1ID"] == userID) {
              turnObject.addTurn("u1", word);
            } else {
              turnObject.addTurn("u2", word);
            }
            _dbRef.child(key).update(turnObject.toJson());
          }
        });
      }
     });
  }

  
}