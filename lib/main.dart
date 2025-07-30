import 'dart:async';
import 'dart:io';
import 'screen-dashboard.dart';
import 'package:flutter/material.dart';

class MyHttpoverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=>true;
  }

}

void main() {
  HttpOverrides.global=new MyHttpoverrides();
  runApp(MaterialApp(
    theme:
    ThemeData(primaryColor: Colors.red,),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration,route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ScreenDashboard()
    ));
  }

  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Stack (
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg_3.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded (
                  flex: 2,
                  child: Container (
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /*
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 65.0,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/icon-1.png'),
                            radius: 60.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          "E-Kamus",style: TextStyle(color: Colors.black,fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),*/

                      ],
                    ),
                  ),
                ),
                Expanded(flex: 1,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text("Aplikasi Kamus Usuluddin",style: TextStyle(color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                    ],
                  ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}