import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listedcompany/Pages/profile.dart';
import 'package:listedcompany/Pages/co_profile.dart';
import 'package:listedcompany/Pages/webview.dart';

void main() { 
  
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light
 ));
  
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      initialRoute: '/first',
      routes: {
        '/first':(BuildContext context) =>CompanyProfile(),
        '/second':(BuildContext context) => ShowProfile(),
        '/web':(BuildContext context) => Web()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
    );
  }
}
