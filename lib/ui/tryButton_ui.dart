import 'package:flutter/material.dart';

class ButtonSelectionDemo extends StatefulWidget {
  @override
  _ButtonSelectionDemoState createState() => _ButtonSelectionDemoState();
}

class _ButtonSelectionDemoState extends State<ButtonSelectionDemo> {
  bool firstButtonSelected = false;
  bool secondButtonSelected = false;
  bool mode = true;

  void selectFirstButton() {
    setState(() {
      firstButtonSelected = true;
      secondButtonSelected = false;
      mode = true;
    });
  }

  void selectSecondButton() {
    setState(() {
      firstButtonSelected = false;
      secondButtonSelected = true;
      mode = false;
    });
  }

  int number = 4;

  void incrementNumber() {
    setState(() {
      if (number < 7) {
        number++;
      }
    });
  }

  void decrementNumber() {
    setState(() {
      if (number > 4) {
        number--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Selection Demo'),
      ),
      body: Column(
        children:[ 
          SizedBox(height: 50),
          Text("Oyun Modunu Belirleyin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (!firstButtonSelected) {
                  selectFirstButton();
                }
              },
              style: ElevatedButton.styleFrom( backgroundColor: firstButtonSelected ? Colors.white12 : Colors.white,
                padding: EdgeInsets.symmetric(vertical: firstButtonSelected ? 20 : 30, horizontal: 40),
              ),
              child: Text('Harf Sabiti\n    Modu'),
            ),
            ElevatedButton(
              onPressed: () {
                if (!secondButtonSelected) {
                  selectSecondButton();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: secondButtonSelected ? Colors.white12 : Colors.white,
                padding: EdgeInsets.symmetric(vertical: secondButtonSelected ? 20 : 30, horizontal: 33),
              ),
              child: Text('Kelime Önerisi\n        Modu'),
            ),
          ],
        ),
          SizedBox(height: 50),
          Text("Kelime Harf Sayısını Belirleyin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: decrementNumber,
              icon: Icon(Icons.arrow_left,size: 50),
            ),
            Text(
              '$number',
              style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: incrementNumber,
              icon: Icon(Icons.arrow_right,size: 50),
            )
        ]
      ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {},
                         style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              ) ,
                         child: Text("Kanal Ara",style: TextStyle(fontSize: 18))),
                         ElevatedButton(onPressed: () {},
                         style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 23, horizontal: 40),
              ) ,
                         child: Text("Kanal Oluştur\n     ve Bekle", style: TextStyle(fontSize: 14)))
            ],
          )
    ]));
  }
}