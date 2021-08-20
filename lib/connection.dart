import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

class Connection{
  static String website = "http://hkmjerp.in";
  final jsonEncoder = JsonEncoder();
  Future<bool> login(api_key,api_secret) async {
    final response = await http.post(
        Uri.parse(website+"/api/method/frappe.auth.get_logged_user"),
        headers: {
          'Authorization':'token $api_key:$api_secret'
        },
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user',jsonDecode(response.body)["message"]);
      return true;
    }
    return false;
  }
  static Future<bool> checkIfLoggedIn() async {
    bool loggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? auth = await prefs.getString('auth');
    if(auth!=null) {
      final response = await http.post(
        Uri.parse(website + "/api/method/frappe.auth.get_logged_user"),
        headers: {
          'Authorization': auth
        },
      );
      if (response.statusCode == 200) {
        loggedIn = true;
      }
    }
    return loggedIn;
  }
  static Future<bool> sendFCMTokenToFOLKDatabase(value) async {
    bool done = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? auth = await prefs.getString('auth');
    String? user = await prefs.getString('user');
    if(auth!=null) {
      final response = await http.post(
        Uri.parse(website + "/api/resource/FOLK App FCM Token"),
        headers: {
          'Authorization': auth
        },
        body: jsonEncode({"user":user,"token":value})
      );
      if (response.statusCode == 200) {
        done = true;
      }
    }
    return done;
  }
  static reset_api(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth');
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }

  static getDashboardData() async {
    print("called");
    List<dynamic> data = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? auth = await prefs.getString('auth');
    if(auth!=null) {
      final response = await http.post(
        Uri.parse(website + "/api/method/folk.folk.api.get_dashboard_data"),
        headers: {
          'Authorization': auth
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body)["message"];
      }
    }
    return data;
  }

}