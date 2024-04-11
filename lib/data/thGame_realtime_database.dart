import 'dart:async';

import 'package:app4/model/theGame.dart';
import 'package:firebase_database/firebase_database.dart';

class theGame_RT {
  
  DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("theGame/");

  Future<List<theGame>> readItems() async {
    Completer<List<theGame>> completer = Completer<List<theGame>>();
    List<theGame> games = [];

    try {
      var subscription;
      subscription = _dbRef.onValue.listen((event) { 
        var json = event.snapshot.value;
        if(json != null && json is Map) {
          json.forEach((key, value) {
            theGame game = theGame(value["gameID"],value["user1UID"], value["user1Name"], value["user2UID"], value["user2Name"]);
            games.add(game);
           });

          subscription.cancel();
          completer.complete(games);
        }
      });

    } catch(error) {
      print(error);
    }
    return completer.future;
  }

  Future<theGame> updateGame(String gameID,String userID, String targetWord) async {
    Completer<theGame> completer = Completer<theGame>();
    theGame game = theGame.nul();

    try {
      var subscription;
      subscription = _dbRef.onValue.listen((event) { 
        var json = event.snapshot.value;
        if(json != null && json is Map) {
          json.forEach((key, value) {
            if(value["gameID"] == gameID) {
              if(value["user1UID"] == userID) {
                game = theGame.allField(gameID, value["user1UID"], value["user1Name"], " ", value["user1IsReady"], value["user2UID"], value["user2Name"], targetWord, value["user2IsReady"]);
                game.setU1Ready();
                _dbRef.child(key).update(game.toJson());
              } else {
                game = theGame.allField(gameID, value["user1UID"], value["user1Name"], targetWord, value["user1IsReady"], value["user2UID"], value["user2Name"], " ", value["user2IsReady"]);
                game.setU2Ready();
                _dbRef.child(key).update(game.toJson());
              }
            }
           });
          subscription.cancel();
          completer.complete(game);
        }
      });

    } catch(error) {
      print(error);
    }
    return completer.future;
  }

  Future<bool> controlUsersReady(String gameID) async {
    Completer<bool> completer = Completer<bool>();
    bool ready = false;

    try {
      var subscription;
      subscription = _dbRef.onValue.listen((event) { 
        var json = event.snapshot.value;
        if(json != null && json is Map) {
          json.forEach((key, value) {
            if(value["gameID"] == gameID) {
              if(value["user1IsReady"] && value["user2IsReady"]) {
                ready = true;
              } else {
                ready = false;
              }
            }
           });

          subscription.cancel();
          completer.complete(ready);
        }
      });

    } catch(error) {
      print(error);
    }
    return completer.future;
  } 

  void addItem(Map<String, dynamic> data) async {
    _dbRef.push().set(data);
  }

  Future<theGame> getGameWithUsername(String user1name) async {
    Completer<theGame> completer = Completer<theGame>();
    theGame game = theGame.nul();

    try {
      var subscription;
      subscription = _dbRef.onValue.listen((event) { 
        var json = event.snapshot.value;
        if(json != null && json is Map) {
          json.forEach((key, value) {
            if(value["user1Name"] == user1name) {
              game = theGame.allField(value["gameID"], value["user1UID"], value["user1Name"], value["user1Target"], value["user1IsReady"], value["user2UID"], value["user2Name"], value["user2Target"], value["user2IsReady"]);
            }
           });

          subscription.cancel();
          completer.complete(game);
        }
      });
    } catch(error) {
      print(error);
    }
    return completer.future;
  }

}