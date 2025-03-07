import 'package:flutter/material.dart';

class AuthProviderFlutter extends ChangeNotifier {
  Map<String, dynamic> _userData = {
    'username':'',
    'email':'',
    'phone':'',
    'register':'',
    'address':'',
    'name':'',
    'lastname':'',
    'token':''
  };


  // Getters
  Map<String,dynamic> get userData => _userData;


  // Método para iniciar sesión
  void setLogin(Map<String,dynamic> queryResponse) {
    _userData['id'] = queryResponse['id'];
    _userData['username'] = queryResponse['username'];
    _userData['email'] = queryResponse['email'];
    _userData['phone'] = queryResponse['phone'];
    _userData['register'] = queryResponse['register'];
    _userData['address'] = queryResponse['address'];
    _userData['name'] = queryResponse['name'];
    _userData['lastname'] = queryResponse['lastname'];
    _userData['token'] = queryResponse['token'];
    print(_userData);
  }

  // Método para cerrar sesión
  /*
  void logout() {
    _token = '';
    _username = '';
    notifyListeners();
  }
*/

}
