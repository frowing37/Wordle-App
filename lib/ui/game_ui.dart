import 'dart:async';
import 'package:app4/data/thGame_realtime_database.dart';
import 'package:app4/data/turns_realtime.dart';
import 'package:app4/model/theGame.dart';
import 'package:app4/model/turns.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/word_list/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class indexC {
  int x = 0;
  int y = 0;
  Color state = Colors.white as Color;

  indexC(this.x, this.y);
  indexC.nul();
}

class GAME extends StatefulWidget {
  final int count;
  final theGame game;
  final UserData userData;

  GAME(this.count, this.game, this.userData);

  @override
  _GAME createState() => _GAME(this.count, this.game, this.userData);
}

class _GAME extends State<GAME> {
  final int count;
  theGame game;
  final UserData userData;

  _GAME(this.count, this.game, this.userData);

  List<List<TextEditingController>> controllers = [];
  int turnCount = 0;
  int rivalTurnCount = 0;
  String warningMessage = " ";
  bool correctFinish = false;
  bool isFinish = false;
  bool typeMessage = false;
  var successMessage =
      TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
  var errorMessage = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
  var indexCorrect = Colors.lightGreen;
  var indexClose = Colors.orangeAccent;
  var indexWrong = Colors.grey;
  List<indexC> indexesState = [];
  String targetWord = " ";

  words wordControl = words();
  turns_RT rt = turns_RT();
  theGame_RT game_rt = theGame_RT();

  @override
  void initState() {
    super.initState();
    first();
    if (game.u1ID == userData.uid) {
      setState(() {
        targetWord = game.u2Target.toString();
      });
    } else {
      setState(() {
        targetWord = game.u1Target.toString();
      });
    }
    for (int i = 0; i < widget.count; i++) {
      List<TextEditingController> list = [];
      for (int j = 0; j < widget.count; j++) {
        list.add(TextEditingController());
        indexesState.add(indexC(i, j));
      }
      controllers.add(list);
    }
    time();
  }

  void first() async {
    game = await game_rt.getGameWithID(game.gameID.toString());
  }

  void time() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      turns turnObject = await rt.getTurnWithID(game.gameID);
      if (turnObject.u1ID == userData.uid) {
        setState(() {
          rivalTurnCount = turnObject.u2Turns.length;
        });
      } else {
        setState(() {
          rivalTurnCount = turnObject.u1Turns.length;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String returnWord() {
    String combinedText = "";
    controllers.forEach((controller) {
      combinedText += controller[turnCount].text;
    });
    print(combinedText);
    return combinedText;
  }

  bool controlWord(String word) {
    bool control = false;

    if (word.length < count) {
      setState(() {
        warningMessage = "Girdiğiniz kelimenin harf sayısında eksiklik var";
      });

      control = false;
      return control;
    } else {
      if (count == 4) {
        if (wordControl.any4(word)) {
          setState(() {
            warningMessage = "Sonraki Hamleye geçildi";
            typeMessage = true;
          });

          control = true;
          return control;
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";
            typeMessage = false;
          });

          control = false;
          return control;
        }
      } else if (count == 5) {
        if (wordControl.any5(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
            typeMessage = true;
          });

          control = true;
          return control;
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";
            typeMessage = false;
          });

          control = false;
          return control;
        }
      } else if (count == 6) {
        if (wordControl.any6(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
            typeMessage = true;
          });

          control = true;
          return control;
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";
            typeMessage = false;
          });

          control = false;
          return control;
        }
      } else if (count == 7) {
        if (wordControl.any7(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
            typeMessage = true;
          });

          control = true;
          return control;
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";
            typeMessage = false;
          });

          control = false;
          return control;
        }
      }

      return control;
    }
  }

  Color getIndexColor(int x, int y) {
    for (var element in indexesState) {
      if (element.x == x && element.y == y) {
        return element.state;
      }
    }
    return Colors.white;
  }

  indexC getIndex(int x, int y) {
    for (var index in indexesState) {
      if (index.x == x && index.y == y) {
        return index;
      }
    }
    return indexC.nul();
  }

  void controlIndex(String input) {
    List<String> inputChars = input.split("");
    List<String> targetChars = [];
    if (userData.uid == game.u1ID) {
      targetChars = game.u2Target!.split("");
    } else {
      targetChars = game.u1Target!.split("");
    }
    int correctCount = 0;

    for (int i = 0; i < widget.count; i++) {
      if (inputChars[i] == targetChars[i]) {
        correctCount++;
        setState(() {
          getIndex(turnCount, i).state = indexCorrect;
        });
      } else {
        if (targetWord.contains(inputChars[i])) {
          correctCount = 0;
          setState(() {
            getIndex(turnCount, i).state = indexClose;
          });
        } else {
          correctCount = 0;
          setState(() {
            getIndex(turnCount, i).state = indexWrong;
          });
        }
      }
    }

    if (correctCount == inputChars.length) {
      setState(() {
        correctFinish = true;
      });
    }
  }

  int calculatePoint() {
    int point = 0;
    for(int i = 0; i < widget.count; i++) {
      if(indexesState.reversed.toList()[i].state == Colors.lightGreen) {
        point+10;
      } 
      else if(indexesState.reversed.toList()[i].state == Colors.orangeAccent) {
        point+5;
      }
    }

    return point;
  }

  void turnControl() {
    if (turnCount + 1 == count) {
      if (correctFinish) {
        warningMessage = "Tebrikler kelime tahmininiz doğru !";
        typeMessage = true;
      } else {
        warningMessage = "Hamle hakkınız kalmadı, kelimeyi bilemediniz :(";
        typeMessage = false;
      }
    } else if (correctFinish) {
      warningMessage = "Tebrikler kelime tahmininiz doğru !";
      typeMessage = true;
    }

    setState(() {
      turnCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
                "   Rakibin anlık hamle sayısı\n   ve puanı = " +
                    "${rivalTurnCount}" +
                    " / 0",
                style: TextStyle(fontSize: 15))
          ],
        ),
        SizedBox(height: 30),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              count,
              (indexy) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.count, (indexx) {
                    return Padding(
                      padding:
                          count > 5 ? EdgeInsets.all(5.0) : EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: count > 6 ? 45 : 50,
                        height: count > 6 ? 45 : 50,
                        child: TextField(
                          controller: controllers[indexy][indexx],
                          style: TextStyle(
                              fontSize: 21.0, fontWeight: FontWeight.bold),
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.top,
                          textCapitalization: TextCapitalization.characters,
                          enabled: indexx == turnCount ? true : false,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 10.0)),
                            fillColor: getIndexColor(indexx, indexy),
                            filled: true,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        ),
                      ),
                    );
                  })),
            )),
        SizedBox(height: 30),
        Text(warningMessage,
            style: typeMessage ? successMessage : errorMessage),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                if (controlWord(returnWord())) {
                  controlIndex(returnWord());
                  rt.addWordToTurns(game.gameID.toString(),
                      userData.uid.toString(), returnWord());
                  turnControl();
                }
              },
              child: isFinish
                  ? Text("Sonuçları Gör",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
                  : Text("Hamleyi Onayla",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: isFinish
                  ? ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      fixedSize: Size(200, 50))
                  : ElevatedButton.styleFrom(
                      foregroundColor: Colors.green, fixedSize: Size(170, 30)))
        ]),
      ],
    ));
  }
}
