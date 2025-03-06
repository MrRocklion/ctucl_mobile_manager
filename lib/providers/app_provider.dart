import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{

  Map <String, String>_mqttParams = {'name':'','topic':''};

  Map<String, dynamic> get mqttParams => _mqttParams;

  void setMqttParams(String name , String Topic){
    _mqttParams['name'] = name;
    _mqttParams['topic'] = Topic;
  }
}