import 'package:ctucl_mobile_manager/presentation/screens/automated_module/menu_automated.dart';
import 'package:ctucl_mobile_manager/presentation/widgets/TransLucentCard.dart';
import 'package:ctucl_mobile_manager/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Map<String,dynamic> response;
  const HomeScreen({
    super.key,
    required this.response,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changePage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuAutomated()));
  }
  @override
  void initState() {
    super.initState();
    final autProviderFlutter =  Provider.of<AuthProviderFlutter>(context, listen: false);
    autProviderFlutter.setLogin(widget.response);
    print("El widget ha sido creado");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modulos Habilitados')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TranslucentCard(title: "Paradas", description: "description", onTap: changePage,assetPath: 'assets/images/automated.png',),
                TranslucentCard(title: "Ajustes", description: "description", onTap: (){},assetPath: 'assets/images/settings.png',)
           ],
            )
          ],
        ),
      )
    );
  }
}