import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:latlng/latlng.dart';



class PositionModel{
  
  UserModel user;
  LatLng position;
  String en;
  String boy;
  

  PositionModel({@required this.user,@required this.position});

  Map <String,dynamic> toMap(){ 
  
   en= position.latitude.toString();
   boy= position.longitude.toString();
    return {
      'userID':user.userID,
      'email':user.email,
      'enlem':en,
      'boylam':boy, 
    };
  }
   PositionModel.fromMap(Map<String,dynamic> map): 
   
    user= map['userID'],
    en= map['enlem'],
    boy= map['boylam'];

  @override
  String toString() {
   return 'PositionModel{user:$user,enlem:$en,boylam:$boy}';
  }
}