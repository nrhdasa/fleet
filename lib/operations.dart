import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';

import 'connection.dart';

setFullName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? auth = prefs.getString('auth');
  if(auth!=null){
    final nameResponse = await http.get(
      Uri.parse(Connection.website + "/api/method/folk.folk.api.get_full_name"),
      headers: {
        'Authorization': auth
      },
    );
    prefs.setString('full_name', json.decode(nameResponse.body)["message"]);
  }
}
Future<dynamic> getVehicles() async {
  List<dynamic> vehicles =[];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? auth = prefs.getString('auth');
  if (auth!=null){
    String url = Connection.website+"/api/resource/Fleet Vehicle?fields=[\"*\"]";
    final vehicleResponse = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':auth
        }
    );
    if (vehicleResponse.statusCode == 200) {
      vehicles = json.decode(vehicleResponse.body)["data"];
    }
  }
  //print(vehicles);
  return vehicles;
}
Future<dynamic> getDrivers() async {
  List<dynamic> drivers =[];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? auth = prefs.getString('auth');
  if (auth!=null){
    String url = Connection.website+"/api/resource/Fleet Driver?fields=[\"*\"]";
    final driverResponse = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':auth
        }
    );
    if (driverResponse.statusCode == 200) {
      drivers = json.decode(driverResponse.body)["data"];
    }
  }
  //print(drivers);
  return drivers;
}


Future<dynamic> submitVehicleMovement(value) async {
  bool success = false;
  String message ="";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? auth = prefs.getString('auth');
  if (auth!=null){
    String url = Connection.website+"/api/resource/Fleet Vehicle Movement";
    final submitVehicleMovementResponse = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':auth
        },
        body: json.encode(value)
    );

    if (submitVehicleMovementResponse.statusCode == 200) {
      success =true;
    }else{
      success = false;
      final messages = json.decode(json.decode(submitVehicleMovementResponse.body)["_server_messages"]);
      messages.forEach((value){
        message += json.decode(value)["message"];
      });
    }
  }
  return {'response':success,'message':message};
}
