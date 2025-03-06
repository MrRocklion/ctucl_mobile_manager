import 'package:ctucl_mobile_manager/presentation/widgets/button_automated.dart';
import 'package:flutter/material.dart';

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
              ButtonAutomated(onClick: (){}, title: "Generar Pase", color: Colors.indigoAccent),
              ButtonAutomated(onClick: (){}, title: "Generar Pase Especial", color: Colors.indigoAccent),
              ButtonAutomated(onClick: (){}, title: "Apagar Actuador", color: Colors.indigoAccent),
              SizedBox(height: 10,),
              Text("Comandos de Audio:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              ButtonAutomated(onClick: (){}, title: "Advertencia", color: Colors.deepPurpleAccent),
              ButtonAutomated(onClick: (){}, title: "Lema", color: Colors.deepPurpleAccent),
              ButtonAutomated(onClick: (){}, title: "Indicaciones", color: Colors.deepPurpleAccent),
              SizedBox(height: 10,),
              Text("Eventos:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              ButtonAutomated(onClick: (){}, title: "Mantenimiento", color: Colors.orangeAccent),
            ],
          ),
        ),
      ),
    );
  }
}
