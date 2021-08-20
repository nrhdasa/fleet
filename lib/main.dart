
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'connection.dart';
import 'data.dart';
import 'firebase_notification_handler.dart';
import 'login.dart';
import 'router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseNotifications().setUpFirebase(navigatorKey);
    return MaterialApp(
      onGenerateRoute: PageRouter.generateRoute,
      navigatorKey: navigatorKey,
      title: 'वाहन प्रबंधन विभाग',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: cusColors[0],
        appBarTheme: AppBarTheme(
          color: cusColors[1],
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,),
          headline2: TextStyle(fontSize: 65.0, fontWeight: FontWeight.bold),
          headline4: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.yellow.shade900),
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.yellow.shade900),
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: LoginPage(title: 'वाहन प्रबंधन विभाग'),
    );
  }
}
