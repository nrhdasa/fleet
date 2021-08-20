import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'data.dart';
import 'operations.dart';

class AddaVehicleMovementAdditional extends StatefulWidget {

  late final Map<String,dynamic> values;
  AddaVehicleMovementAdditional({required this.values});

  @override
  _AddaVehicleMovementAdditionalState createState() => _AddaVehicleMovementAdditionalState();
}

class _AddaVehicleMovementAdditionalState extends State<AddaVehicleMovementAdditional> {
  final _dataFormKey = GlobalKey<FormBuilderState>();
  Map<String,dynamic> dataToBeSent = {};
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.red,
    exportBackgroundColor: Colors.white70,
  );


  @override
  void initState() {
    super.initState();
    _controller.clear();
    //getDrivers();
    //_getAllVehicles();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cusColors[0],
      body:FormBuilder(
        key: _dataFormKey,
        child:Container(
          width:double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: cusColors[3].withOpacity(.7),
          boxShadow: customShadow
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  // FaIcon(FontAwesomeIcons.plus, size: 40.0,),

                  Text("वाहन : "+widget.values['vehicle'],
                    style: TextStyle(
                        fontSize: 15.0,color: cusColors[1],fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text("ड्राइवर : "+widget.values['driver'],
                    style: TextStyle(
                        fontSize: 15.0,color: cusColors[2],fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Divider(
                  color: Colors.black
              ),
              FormBuilderChoiceChip(
                name: 'movement',
                decoration: InputDecoration(
                    labelText: 'अवागमन Type',
                    labelStyle: TextStyle(
                        color:cusColors[1],
                        fontSize: 25
                    )
                ),
                options: [
                  FormBuilderFieldOption(
                      value: 'OUT', child: Text('बाहर',style: TextStyle(fontSize: 30),)),
                  FormBuilderFieldOption(
                      value: 'IN', child: Text('अंदर',style: TextStyle(fontSize: 30),)),
                ],
              ),
              FormBuilderTextField(
                name: "odometer",
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                    labelText: 'ओडोमीटर',
                    labelStyle: TextStyle(
                        color:cusColors[1],
                        fontSize: 25
                    )
                ),
                keyboardType: TextInputType.number,
              ),
              FormBuilderTextField(
                name: "purpose",
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                    labelText: 'उद्देश्य / जगह',
                    labelStyle: TextStyle(
                        color:cusColors[1],
                        fontSize: 25
                    )
                ),
              ),
              FormBuilderTextField(
                name: "devotee",
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                    labelText: 'भक्त',
                    labelStyle: TextStyle(
                        color:cusColors[1],
                        fontSize: 25
                    )
                ),
              ),
              SizedBox(height: 10,),
              Stack(
                children: [

                  Positioned(
                    child: Signature(
                    controller: _controller,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-500,
                    backgroundColor: cusColors[2],
                  ),),
                  Positioned(
                    left: 5.0,
                      child: ElevatedButton(child: Text("Clear"),onPressed: (){
                        _controller.clear();
                      },)),
                  ],
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.black,fontSize: 40),
                ),
                onPressed: () async {
                  print("here");
                  _dataFormKey.currentState!.save();
                  if (_dataFormKey.currentState!.validate() && _controller.isNotEmpty){
                    print(_dataFormKey.currentState!.value);
                    setState(() {
                      dataToBeSent = Map.from(_dataFormKey.currentState!.value);
                      _controller.toPngBytes().then((value){
                        final imageEncoded = base64.encode(value!);
                        dataToBeSent['signature'] =  'data:image/png;base64,'+imageEncoded; //odometer
                        if(dataToBeSent['odometer'] != null){
                          dataToBeSent['odometer'] =int.parse(dataToBeSent['odometer']);
                        }
                        dataToBeSent['vehicle'] =  widget.values['vehicle'];
                        dataToBeSent['driver'] =  widget.values['driver'];
                        dataToBeSent['docstatus'] =  1;
                        submitVehicleMovement(dataToBeSent).then((value){
                          if(value['response']==false){
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Error"),
                                content: Text(value['message']),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("Ok"),
                                  ),
                                ],
                              ),
                            );
                          }else{
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Success"),
                                content: Text("Successfully Added"),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(ctx, '/home');
                                    },
                                    child: Text("Ok"),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      });
                    });

                  }else{
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Error"),
                        content: Text("Data incomplete"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
      )
    );
  }
}