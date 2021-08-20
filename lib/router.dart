import 'package:flutter/material.dart';


import 'AddaVehicleMovement.dart';
import 'AddaVehicleMovementAdditional.dart';
import 'AddaVehicleMovementDriver.dart';
import 'home.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => Homepage());
      case '/addAVechileMovement':
        return MaterialPageRoute(builder: (_) => AddaVehicleMovement());
      // case '/notifications':
      //   return MaterialPageRoute(builder: (_) => Notifications());
      // case '/calling_groups':
      //   return MaterialPageRoute(builder: (_) => Calling());
      // case '/groupView':
      //   final String args = settings.arguments as String;
      //   return MaterialPageRoute(builder: (context) => groupView(
      //       group_name :args
      //   ));
      case '/addaVehicleMovementDriver':
        final String args = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => AddaVehicleMovementDriver(
            vehicle : args
        ));
      case '/addaVehicleMovementAdditional':
        final Map<String,dynamic> args = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context) => AddaVehicleMovementAdditional(
            values : args,
      ));
      // case '/interactionAdd':
      //   final String args = settings.arguments as String;
      //   return MaterialPageRoute(builder: (context) => InteractionAdd(
      //       scode : args
      //   ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}