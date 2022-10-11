import 'package:flutter/material.dart';
import 'package:flutter_application_3/etapes.dart';
import 'package:flutter_application_3/myhomepage.dart';
import 'package:flutter_application_3/outils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Beermaker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const MyHomePage(title: 'Beermaker'),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/routeEtapes': (BuildContext context) =>
              const EtapesPage(title: 'Les étapes de fabrication'),
          '/routeOutils': (BuildContext context) =>
              const OutilsPage(title: 'Les outils de fabrication'),
        });
  }
}
