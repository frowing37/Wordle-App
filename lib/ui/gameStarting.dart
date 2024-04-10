import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class gameStarting extends StatefulWidget {
  final int count;

  gameStarting(this.count);

  @override
  _gameStartingState createState() => _gameStartingState(this.count);
}

class _gameStartingState extends State<gameStarting> {
  final int count;

  _gameStartingState(this.count);
  
  List<TextEditingController> controllers = [];

  String warningMessage = "";
  String returnWord() {
    
    String combinedText = "";
    controllers.forEach((controller) {
      combinedText += controller.text;
    });
    
    return combinedText;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.count; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[ Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count, (index) {
        return Padding(
          padding: count > 5 ? EdgeInsets.all(5.0) : EdgeInsets.all(8.0),
          child: SizedBox(
            width: count > 6 ? 45 : 50, // Kare boyutunu buradan ayarlayabilirsiniz
            height: count > 6 ? 45 : 50, // Kare boyutunu buradan ayarlayabilirsiniz
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
                if (value.isNotEmpty && index < widget.count - 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
        );
      }),
    ),
    SizedBox(height: 30.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      ElevatedButton(onPressed: () { print(returnWord()); }, child: Text("Ok"))
    ]),
    SizedBox(height: 30.0),
    Text(warningMessage,style: TextStyle(color: Colors.red))
    ]
  )
  );
}

  @override
  void dispose() {
    // Controllerları temizle
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
