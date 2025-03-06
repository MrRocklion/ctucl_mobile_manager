import 'package:ctucl_mobile_manager/presentation/screens/automated_module/menu_automated.dart';
import 'package:ctucl_mobile_manager/presentation/screens/home_screen.dart';
import 'package:ctucl_mobile_manager/presentation/screens/login_screen.dart';
import 'package:ctucl_mobile_manager/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:ctucl_mobile_manager/presentation/screens/automated_module/home_automated.dart';
class MyApp extends StatelessWidget {
  final MaterialTheme materialTheme = MaterialTheme(const TextTheme());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Flutter',
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/automated',
      routes: {
        '/': (context) => HomeScreen(),
        '/login':(context) => LoginScreen(),
        '/automated/':(context) => MenuAutomated(),


      },
    );
  }
}