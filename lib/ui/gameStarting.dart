import 'dart:async';
import 'package:app4/model/theGame.dart';
import 'package:app4/model/userData.dart';
import 'package:app4/word_list/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class gameStarting extends StatefulWidget {
  final int? count;
  final theGame game;
  final UserData userData;

  gameStarting(this.count,this.userData,this.game);

  @override
  _gameStartingState createState() => _gameStartingState(this.count,this.userData,this.game);
}

class _gameStartingState extends State<gameStarting> {
  final int? count;
  final theGame game;
  final UserData userData;

  _gameStartingState(this.count,this.userData,this.game);
  
  List<TextEditingController> controllers = [];

  words wordControl = words();
  String warningMessage = "";
  int timeCounter = 60;
  bool typeMessage = false;
  bool isReady = false;
  var successMessage = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
  var errorMessage = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

  String returnWord() {
    
    String combinedText = "";
    controllers.forEach((controller) {
      combinedText += controller.text;
    });
    
    return combinedText;
  }

  void controlWord(String word) {
    if(word.length < count!) {
      setState(() {
        warningMessage = "Girdiğiniz kelimenin harf sayısında eksiklik var";
      });
    } else {

      if(count == 4) {
        if(wordControl.any4(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
          typeMessage = true;
          isReady = true;
          });
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";    
          typeMessage = false;
          isReady = false;
          });
        }
      }
      else if(count == 5) {
        if(wordControl.any5(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
          typeMessage = true;
          isReady = true;
          });
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";    
          typeMessage = false;
          isReady = false;
          });
        }
      }
      else if(count == 6) {
        if(wordControl.any6(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
          typeMessage = true;
          isReady = true;
          });
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";    
          typeMessage = false;
          isReady = false;
          });
        }
      }
      else if(count == 7) {
        if(wordControl.any7(word)) {
          setState(() {
            warningMessage = "Kelime Uygun";
          typeMessage = true;
          isReady = true;
          });
        } else {
          setState(() {
            warningMessage = "Bu kelime Wordle sözlüğünde bulunmuyor";    
          typeMessage = false;
          isReady = false;
          });
        }
      }
    }
    print(warningMessage);
  }

  void theBoyisReady() {
    if(isReady) {
      setState(() {
        warningMessage = "Rakibinizin Hazır Olması Bekleniyor";
        typeMessage = true;
      });
    } else {
      setState(() {
        warningMessage = "Seçtiğiniz Kelime Uygun Değil\n      Oyuna Hazır Değilsiniz ! ";
        typeMessage = false;
      });
    }
  }

  void timeCount() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeCounter > 0) {
        setState(() {
        timeCounter--;
      });
      } else {
        if(!isReady) {
          setState(() {
            warningMessage = "SÜRE İÇERİSİNDE KELİME SEÇEMEDİNİZ OYUN BİTTİ";
            typeMessage  = false;
          });
        } else {
          setState(() {
            warningMessage = "Rakibinizin Hazır Olması Bekleniyor";
            typeMessage = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.count!; i++) {
      controllers.add(TextEditingController());
    }
    timeCount();
  }

  @override
  void dispose() {
    // Timer'ı dispose edin
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
      Row(mainAxisAlignment: MainAxisAlignment.center ,children: [
        Container(height: 75,width: 75, decoration: BoxDecoration(color: Colors.green ,borderRadius: BorderRadius.circular(20.0)), child: Center(child: Text(timeCounter.toString(),style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold))))
      ]),   
      SizedBox(height: 100.0),
      Text("Rakibinizin tahmin edeceği kelimeyi belirleyin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
      SizedBox(height: 20.0),  
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count!, (index) {
        return Padding(
          padding: count! > 5 ? EdgeInsets.all(5.0) : EdgeInsets.all(8.0),
          child: SizedBox(
            width: count! > 6 ? 45 : 50, // Kare boyutunu buradan ayarlayabilirsiniz
            height: count! > 6 ? 45 : 50, // Kare boyutunu buradan ayarlayabilirsiniz
            child: TextField(
              controller: controllers[index],
              style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold),
              maxLength: 1, // Sadece bir karakter alması için
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                counterText: "", // Karakter sayacını kapatır
                border: OutlineInputBorder(borderSide: BorderSide(width:10.0))
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < widget.count! - 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
        );
      }),
    ),
      SizedBox(height: 30.0),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      ElevatedButton(onPressed: () { print(returnWord()); controlWord(returnWord()); },
       child: Text("Onayla",style: TextStyle(color: Colors.green)),
       style: ElevatedButton.styleFrom(),)
    ]),
      SizedBox(height: 30.0),
      Text(warningMessage,style: typeMessage ? successMessage : errorMessage),
      SizedBox(height: 150.0),
      ElevatedButton(onPressed: () { theBoyisReady(); }, child: Text("Oyuna Başla", style: TextStyle(color: Colors.green)))
    ]
  )
  );
}

}
