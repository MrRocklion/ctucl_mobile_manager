import 'dart:convert';
import 'package:ctucl_mobile_manager/providers/auth_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ApiService {
  static const String apiUrl = "http://localhost:4000";




  Future<dynamic> mqttQuery(Map<String, dynamic> params, context) async {

    try {
      final authParams = Provider.of<AuthProvider>(context, listen: false);
      String? token = authParams.token;
      if (token == null) {
        throw Exception("No token found in storage");
      }

      final response = await http.post(
        Uri.parse("$apiUrl/api/bus-station"),
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
}
