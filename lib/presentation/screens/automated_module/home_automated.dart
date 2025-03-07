import 'package:ctucl_mobile_manager/presentation/widgets/button_automated.dart';
import 'package:ctucl_mobile_manager/providers/app_provider.dart';
import 'package:ctucl_mobile_manager/providers/auth_provider.dart';
import 'package:ctucl_mobile_manager/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAutomated extends StatefulWidget {

  final String title;
  final String description;
  const HomeAutomated({
    super.key,
    required this.title,
    required this.description
  });

  @override
  State<HomeAutomated> createState() => _HomeAutomatedState();
}

class _HomeAutomatedState extends State<HomeAutomated> {
  final ApiService _apiService = ApiService();
  String _responseText = "Presiona el botón para hacer la consulta";
  Future<void> _fetchData(String command,String path) async {
    final authParams = Provider.of<AuthProviderFlutter>(context, listen: false);
    final appParams = Provider.of<AppProvider>(context, listen: false);
    final String token = authParams.userData['token'];
    try {
      Map<String, dynamic> params = {
        "user_id": 2,
        "name": authParams.userData['name'],
        "lastname": authParams.userData['lastname'],
        "email": authParams.userData['email'],
        "command": command,
        "username": authParams.userData['username'],
        "path": path,
        "topic":appParams.mqttParams['topic']
      };
      print(params);
      final response = await _apiService.mqttQuery(params,token, context);
      setState(() {
        _responseText = response.toString();
      });
    } catch (error) {
      setState(() {
        _responseText = "Error: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Control Remoto")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Text(widget.description, style: TextStyle(
                color: Colors.black54
              ),),
          
              Text("Comandos rapidos:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
              ),
              ButtonAutomated(onClick:()=>{_fetchData('generate_normal_pass','mecanism')}, title: "Generar Pase", color: Colors.indigoAccent),
              ButtonAutomated(onClick: ()=>{_fetchData('generate_special_pass','mecanism')}, title: "Generar Pase Especial", color: Colors.indigoAccent),
              ButtonAutomated(onClick: ()=>{_fetchData('actuador_off','mecanism')}, title: "Apagar Actuador", color: Colors.indigoAccent),
              SizedBox(height: 10,),
              Text("Comandos de Audio:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              ButtonAutomated(onClick: ()=>{_fetchData('warning_sound','audio')}, title: "Advertencia", color: Colors.deepPurpleAccent),
              ButtonAutomated(onClick: ()=>{_fetchData('ctucl_slogan','audio')}, title: "Lema", color: Colors.deepPurpleAccent),
              ButtonAutomated(onClick: ()=>{_fetchData('patience_sound','audio')}, title: "Indicaciones", color: Colors.deepPurpleAccent),
              SizedBox(height: 10,),
              Text("Eventos:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              ButtonAutomated(onClick: ()=>{_fetchData('maintenance','events')}, title: "Mantenimiento", color: Colors.orangeAccent),
            ],
          ),
        ),
      ),
    );
  }
}
