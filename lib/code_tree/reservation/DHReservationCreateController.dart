import 'package:flutter/material.dart';
import 'package:flutter_dhyt/code_tree/reservation/DHReservationListController.dart';

class DHReservationCreateController extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("发起预约"),
        actions: <Widget>[
          FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DHReservationListController()));
              },
              child: Text("预约记录", style: TextStyle(color: Colors.white),)),
        ],
      ),
      body: SafeArea(child: Center(
        child: Text("发起预约"),
    ),),
    );
  }
}