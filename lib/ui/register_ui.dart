import 'dart:ui';
import 'package:app4/data/users.dart';
import 'package:app4/ui/login_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registerScreen extends StatelessWidget {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  UserDB _userManager = new UserDB();

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );

      UserCredential tempUser = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text);

      _userManager.addUser(tempUser.user!.uid,
                           _usernameController.text,
                           _emailController.text,
                           _passwordController.text);

      // Kullanıcı başarıyla kaydedildi, burada giriş ekranına yönlendirme yapılabilir.
    print("Kayıt işlemi başarılı");

    } catch (e) {
      // Kayıt işlemi başarısız oldu, hata gösterilebilir.
      print("Kayıt hatası: $e");
    }
  }

  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(50, 168, 82, 0.8),
                Color.fromRGBO(115, 250, 248, 0.8)
              ]
            )
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top:90.0),
                child: Center(
                  child: Text(
                    "Wordl'a \nHoşgeldin!",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),                                                             
        ),
        Padding(
          padding: const EdgeInsets.only(top:250.0),
          child: SingleChildScrollView( // Değişiklik burada
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                ),
                color: Colors.white
              ),
              height: MediaQuery.of(context).size.height, // Değişiklik burada
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0,left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.person,color:Color.fromRGBO(115, 250, 248, 0.8),),
                          labelText: 'Kullanıcı Adı',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(50, 168, 82, 0.8))
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.mail,color:Color.fromRGBO(115, 250, 248, 0.8)),
                          labelText: 'Mail',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(50, 168, 82, 0.8))
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.password,color:Color.fromRGBO(115, 250, 248, 0.8)),
                          labelText: 'Şifre',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(50, 168, 82, 0.8))
                        )
                      ),
                    ),
                    SizedBox(height: 40),
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors:[Color.fromRGBO(50, 168, 82, 0.8),Color.fromRGBO(115, 250, 248, 0.8)]),
                              borderRadius: BorderRadius.circular(20.0)
                            )
                          ),
                        ),
                        TextButton(
                          onPressed: _register,
                          child: Text(
                            "     Kayıt Ol     ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 28)
                          )
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 25),
                          Text(
                            "Zaten hesabınız varsa,",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17)
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors:[Color.fromRGBO(50, 168, 82, 0.8),Color.fromRGBO(115, 250, 248, 0.8)]),
                                borderRadius: BorderRadius.circular(20.0)
                              )
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => loginScreen())
                              );
                            },
                            child: Text(
                              "   Giriş Yapın   ",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20)
                            )
                          )
                        ],
                      ),
                    )
                  ]
                )
              )
            )
          )
        )
      ]
    )
  );
}

}