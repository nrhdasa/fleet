import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connection.dart';
import 'data.dart';

class Homepage extends StatefulWidget {
  //Homepage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? full_name;
  @override
  void initState() {
    super.initState();
    //new FirebaseNotifications().setUpFirebase(context);
    get_full_name();
    // _call();

  }
  get_full_name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      full_name = prefs.getString('full_name')??"NA";
    });
  }
// _call() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.clear();
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cusColors[0],
      //drawer: common_drawer(context),
      //appBar: common_appbar(),
      body: FutureBuilder(
        future: Connection.getDashboardData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else{

            List<dynamic> data = snapshot.data;
            return  Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Hare Krishna",style: TextStyle(
                                fontSize: 18.0,color: cusColors[1],fontWeight: FontWeight.bold
                            ),),
                            Text(full_name??"NA",
                              style: TextStyle(
                                  fontSize: 30.0,color: cusColors[3],
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cusColors[2],
                                boxShadow: customShadow
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: FaIcon(FontAwesomeIcons.redo),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Text("Dashboard",
                      style: TextStyle(
                          fontSize: 18.0,color: cusColors[1],fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: cusColors[2],
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, '/addAVechileMovement');
                        }, child:
                    Container(
                      height: 70.0,

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("वाहन आवागमन जोड़े",
                                style:TextStyle(
                                    fontSize: 25.0,color: cusColors[0],fontWeight: FontWeight.bold
                                ),
                              ),
                              FaIcon(FontAwesomeIcons.plusSquare,color: cusColors[3],),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Add a Vehicle Movement",
                                style:TextStyle(
                                    fontSize: 15.0,color: cusColors[1],fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 10.0,)
                  ],
                ),
              ),
            );
          }
          }
      ),
    );
  }
  
}