import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connection.dart';
import 'firebase_notification_handler.dart';
import 'operations.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Connection con = Connection();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? api_key;
  String? api_secret;
  String? validateString(value){
    if(value.isEmpty){
      return "Required";
    }
    else
      return null;
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Connection.checkIfLoggedIn().then((value) => {
      setFullName(),
      if(value == true){
        Navigator.popAndPushNamed(context, '/home')
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always, key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value)=> api_key=value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "एपीआई कोड"
                  ),
                validator: validateString,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  onSaved: (value)=> api_secret=value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "एपीआई सीक्रेट"
                  ),
                  validator: validateString,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Setting Up")));
                      _formKey.currentState!.save();
                      con.login(api_key, api_secret).then((value) async {
                        if(value){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('auth', 'token $api_key:$api_secret');
                          setFullName();
                          // FirebaseMessaging messaging = FirebaseMessaging.instance;
                          // // NotificationSettings settings = await messaging.requestPermission(
                          // //   alert: true,
                          // //   announcement: false,
                          // //   badge: true,
                          // //   carPlay: false,
                          // //   criticalAlert: false,
                          // //   provisional: false,
                          // //   sound: true,
                          // // );
                          //
                          // messaging.getToken().then((value){
                          //   Connection.sendFCMTokenToFOLKDatabase(value);
                          // });
                          Navigator.pushNamed(context, '/home');
                        }
                      });
                    }
                  },
                  child: Text("सुनिश्चित करे"),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

}
