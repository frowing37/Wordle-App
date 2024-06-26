import 'package:flutter/material.dart';

class LoadingSpinner extends StatefulWidget {
  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors:[Color.fromRGBO(50, 168, 82, 0.8),Color.fromRGBO(115, 250, 248, 0.8)])
                              )
                            ),
                          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.1415926535897932, // 2pi radians = 360 degrees
            child: Icon(Icons.hourglass_empty, size: 70, color: Colors.white),
          );
        },
      )]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Padding(padding: EdgeInsets.only(top: 30),child: Text("Odaya oyuncu bekleniyor ...", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),))],),
      SizedBox(height: 100),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ElevatedButton(onPressed: () {}, 
        child: Text("            Odayı Sil,\n Beklemekten Vazgeç", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
        style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(31, 107, 51, 1), padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)))
      ])
    ]
  )      
        ])
    );
  }
}
