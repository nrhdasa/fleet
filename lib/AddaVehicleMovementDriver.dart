import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'operations.dart';

class AddaVehicleMovementDriver extends StatefulWidget {
  AddaVehicleMovementDriver({Key? key, required this.vehicle}) : super(key: key);

  final String vehicle;

  @override
  _AddaVehicleMovementDriverState createState() => _AddaVehicleMovementDriverState();
}

class _AddaVehicleMovementDriverState extends State<AddaVehicleMovementDriver> {
  @override
  void initState() {
    super.initState();
    getDrivers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cusColors[0],
      body: FutureBuilder(
          future:getDrivers(),
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
                        Navigator.pushReplacementNamed(context, '/addaVehicleMovementAdditional',
                            arguments:{
                            'vehicle':widget.vehicle,
                              'driver':data[i]['name'],
                              'driver_name':data[i]['full_name'],
                            });
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
                            Text(data[i]['full_name'],
                              style: TextStyle(
                                  color: Colors.yellow.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(data[i]['mobile'],
                              style: TextStyle(
                                  color: Colors.yellow.shade300,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
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
                        Text("ड्राइवर चुनें",
                          style: TextStyle(
                              fontSize: 40.0,color: cusColors[1],fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // FaIcon(FontAwesomeIcons.plus, size: 40.0,),
                        SizedBox(width: 10.0,),
                        Text("(गाड़ी नंबर : "+widget.vehicle+")",
                          style: TextStyle(
                              fontSize: 20.0,color: cusColors[2],fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height-130,
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