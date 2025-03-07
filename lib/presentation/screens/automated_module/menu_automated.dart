import 'package:ctucl_mobile_manager/presentation/screens/automated_module/home_automated.dart';
import 'package:ctucl_mobile_manager/presentation/widgets/CardAutomated.dart';
import 'package:ctucl_mobile_manager/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuAutomated extends StatefulWidget {
  const MenuAutomated({super.key});

  @override
  State<MenuAutomated> createState() => _MenuAutomatedState();
}

class _MenuAutomatedState extends State<MenuAutomated> {
  void navegarRuta(String name, String topic, String description) {
    final mqttProvider = Provider.of<AppProvider>(context, listen: false);
    mqttProvider.setMqttParams(name, topic);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeAutomated(title: name,description: description)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routes = [
      {'title': 'Consorcio', 'description': 'Prototipo de pruebas',  'topic': 'desarrollo/commands'},
      {'title': 'Paltas Sur A Norte', 'description': 'Calle catacocha',  'topic': 'paltas_sn//commands'},
      {'title': 'Valle Sur a Norte', 'description': 'Cooperativa Jep',  'topic': 'valle_sn/commands'},
      {'title': 'Valle Norte a Sur', 'description': 'Zona Militar',  'topic': 'valle_ns/commands'},
      {'title': 'Jipiro Sur a Norte', 'description': 'Parada Bajada',  'topic': 'jipiro_sn/commands'},
      {'title': 'Jipiro Norte a Sur', 'description': 'Parada Subida',  'topic': 'jipiro_ns/commands'},
      {'title': 'Coliseo', 'description': 'Coliseo Municipal', 'topic': 'coliseo'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paradas Disponibles"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: routes.length,
          itemBuilder: (context, index) {
            final route = routes[index];
            return CardAutomated(
              title: route['title']!,
              description: route['description']!,
              onTap: () => navegarRuta(route['title']!, route['topic']!,route['description']!),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8); // Separación de 8 píxeles entre los elementos
          },
        ),
      ),
    );
  }
}
