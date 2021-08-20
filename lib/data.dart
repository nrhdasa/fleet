import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Color> cusColors =[
  Color(0xFFDDDDDD),
  Color(0xFF125D98),
  Color(0xFF3C8DAD),
  Color(0xFFF5A962)
];

List<TextStyle> textstyles = [
    TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold,),
    TextStyle(fontSize: 65.0, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.yellow.shade900),
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.yellow.shade900),
    TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    TextStyle(fontSize: 14.0, fontFamily: 'Hind')
];

List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.white.withOpacity(.7),
    blurRadius:30,
    offset: Offset(-5,-5),
    spreadRadius: -5
  ),
  BoxShadow(
      color: Colors.blue.withOpacity(.2),
      blurRadius:20,
      offset: Offset(7,7),
      spreadRadius: 2
  )
];