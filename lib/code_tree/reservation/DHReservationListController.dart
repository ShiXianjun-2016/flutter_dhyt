import 'package:flutter/material.dart';

class DHReservationListController extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("预约记录"),
      ),
      body: SafeArea(
          child:Center(
            child: Text("预约记录"),
          ),
      ),
    );
  }
}