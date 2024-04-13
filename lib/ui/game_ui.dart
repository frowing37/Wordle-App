import 'package:app4/word_list/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class indexC {
  int x = 0;
  int y = 0;
  Colors state = Colors.white as Colors;

  indexC(this.x,this.y);

}

class GAME extends StatefulWidget {
  final int count;

  GAME(this.count);

  @override
  _GAME createState() => _GAME(this.count);
}

class _GAME extends State<GAME> {
  final int count;

  _GAME(this.count);

  List<List<TextEditingController>> controllers = [];
  int turnCount = 0;
  String warningMessage = " ";
  bool typeMessage = false;
  var successMessage = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
  var errorMessage = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
  var indexCorrect = Colors.lightGreen;
  var indexClose = Colors.orangeAccent;
  var indexWrong = Colors.grey;
  List<indexC> indexesState = [];
  String targetWord = "DAHİL";

  words wordControl = words();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.count; i++) {
      List<TextEditingController> list = [];
      for (int j = 0; j < widget.count; j++) {
          list.add(TextEditingController());
          indexesState.add(indexC(i,j));
      }
      controllers.add(list);
    }
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

    if(word.length < count) {
      setState(() {
        warningMessage = "Girdiğiniz kelimenin harf sayısında eksiklik var";
      });
      
      control = false;
      return control;

    } else {

      if(count == 4) {
        if(wordControl.any4(word)) {
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
      }
      else if(count == 5) {
        if(wordControl.any5(word)) {
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
      else if(count == 6) {
        if(wordControl.any6(word)) {
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
      else if(count == 7) {
        if(wordControl.any7(word)) {
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

  Colors getindexColor(int x, int y) {
  for (var element in indexesState) {
    if (element.x == x && element.y == y) { 
      return element.state;
    }
  }
  return Colors.white; // Eğer eşleşen bir öğe bulunamazsa varsayılan değeri döndür
}

  
  void controlIndex(String input) {

  }

  void turnControl() {
    setState(() {
      turnCount++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(children: [Text("   Rakibin anlık hamle sayısı\n   ve puanı = 0 / 0",style: TextStyle(fontSize: 15))],),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: List.generate(count, (indexy) =>
        Column(mainAxisAlignment: MainAxisAlignment.center,children: List.generate(widget.count, (indexx) {
        return Padding(
          padding: count > 5 ? EdgeInsets.all(5.0) : EdgeInsets.all(8.0),
          child: SizedBox(
            width: count > 6 ? 45 : 50, 
            height: count > 6 ? 45 : 50, 
            child: TextField(
              controller: controllers[indexy][indexx],
              style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.bold),
              maxLength: 1, 
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              textCapitalization: TextCapitalization.characters, 
              enabled: indexx == turnCount ? true :false,
              decoration: InputDecoration(
                counterText: "", 
                border: OutlineInputBorder(borderSide: BorderSide(width:10.0)),
                fillColor: ,
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
        Text(warningMessage, style: typeMessage ? successMessage : errorMessage),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [ElevatedButton(onPressed: () { if(controlWord(returnWord())) { turnControl(); } }, child: Text("Hamleyi Onayla"))]),
      ],)
    );
  }



}