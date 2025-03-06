import 'dart:convert';
import 'package:ctucl_mobile_manager/providers/auth_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ApiService {
  //static const String apiUrl = "http://localhost:4000";
  //static const String apiUrl = "http://192.168.20.245:4000";
  static const String apiUrl = "https://ctucloja.com";
  Future<dynamic> mqttQuery(Map<String, dynamic> params, context) async {

    try {
      final authParams = Provider.of<AuthProviderFlutter>(context, listen: false);
      String? token = authParams.userData['token'];
      if (token == null) {
        throw Exception("No token found in storage");
      }
      final url = Uri.parse(apiUrl);
      final response = await http.post(
        Uri.parse("$url/api/bus-station"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Error en la solicitud: ${response.statusCode}");
      }
    } catch (error) {
      print("Error en mqttQuery: $error");
      throw error;
    }
  }

  Future<dynamic> loginQuery(String email,String password,String token,context)async{
    try{
      Map<String,String> params = {"email":email,"password":password,"username":"","firebase_token":token};

      final response = await http.post(
        Uri.parse("$apiUrl/api/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(params),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Error en la solicitud: ${response.statusCode}");
      }
    }catch (error) {
      print("Error en LoginQuery: $error");
      throw error;
    }

  }
}
