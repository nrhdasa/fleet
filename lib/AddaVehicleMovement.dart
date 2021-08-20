import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'operations.dart';

class AddaVehicleMovement extends StatefulWidget {
  @override
  _AddaVehicleMovementState createState() => _AddaVehicleMovementState();
}

class _AddaVehicleMovementState extends State<AddaVehicleMovement> {
  @override
  void initState() {
    super.initState();
    getVehicles();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cusColors[0],
      body: FutureBuilder(
          future:getVehicles(),
          builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else{
              int len = snapshot.data.length;
              var data = snapshot.data;
              List<Widget> blocks = [];
              List<Widget> row = [];
              for(int i=0;i<len;i++){
                if(i%2==0){
                  blocks.add(Row(children:row));
                  row = [];
                  blocks.add(SizedBox(height: 10,));
                }
                row.add(Expanded(
                    child: InkWell(
                      onTap: (){
                        print("taped "+data[i]['name']);
                        Navigator.pushReplacementNamed(context, '/addaVehicleMovementDriver',arguments:data[i]['name']);
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: cusColors[1],
                            boxShadow: customShadow
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data[i]['name'],
                              style: TextStyle(
                                  color: Colors.yellow.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ));
                row.add(SizedBox(width: 10,));
                if(i == len-1){
                  blocks.add(Row(children:row));
                  row = [];
                }
              }
              return Container(
                padding: EdgeInsets.fromLTRB(0,30,10,0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // FaIcon(FontAwesomeIcons.plus, size: 40.0,),
                        SizedBox(width: 10.0,),
                        Text("वाहन चुनें",
                          style: TextStyle(
                              fontSize: 40.0,color: cusColors[1],fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height-100,
                        child:ListView(
                            padding: EdgeInsets.all(10),
                            children:blocks
                        )),
                  ],
                ),
              );
            }
          })
    );
  }

}