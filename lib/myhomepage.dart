import 'package:flutter/material.dart';
import 'package:flutter_application_3/splashscreen.dart';
import 'package:flutter_application_3/strings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Image.asset('lib/assets/beermakerlogo350.png')],
        title: const Text('Outils de fabrication'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 300,
                child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/routeEtapes'),
                    child: const Text(Strings.strEtapes)),
              ),
              SizedBox(
                height: 100,
                width: 300,
                child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/routeOutils'),
                    child: const Text(Strings.strOutils)),
              ),
            ]),
      ),
    );
  }
}
