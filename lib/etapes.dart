import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/strings.dart';

class EtapesPage extends StatefulWidget {
  const EtapesPage({super.key, required this.title});

  final String title;

  @override
  State<EtapesPage> createState() => EtapesPageState();
}

class EtapesPageState extends State<EtapesPage> {
  int _i = 0;
  String _titre = Strings.titre0;
  String _text = Strings.texte0;

  void decrement() {
    if (_i > 0) {
      _i--;
      page();
    }
  }

  void increment() {
    if (_i < 9) {
      _i++;
      page();
    }
  }

  void goFirstPage() {
    if (_i != 0) {
      _i = 0;
      page();
    }
  }

  void goLastPage() {
    if (_i != 8) {
      _i = 8;
      page();
    }
  }

  IconButton buttonNext() {
    IconButton result = const IconButton(onPressed: null, icon: Icon(null));
    if (_i != 8) {
      result = IconButton(
          onPressed: increment,
          icon: const Icon(
            Icons.arrow_forward,
            size: 25,
          ));
    }
    return result;
  }

  IconButton buttonPrevious() {
    IconButton result = const IconButton(onPressed: null, icon: Icon(null));
    if (_i != 0) {
      result = IconButton(
          onPressed: decrement,
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ));
    }
    return result;
  }

  IconButton buttonFirst() {
    IconButton result = const IconButton(onPressed: null, icon: Icon(null));
    if (_i != 0) {
      result = IconButton(
          onPressed: goFirstPage,
          icon: const Icon(
            Icons.skip_previous,
            size: 25,
          ));
    }
    return result;
  }

  IconButton buttonLast() {
    IconButton result = const IconButton(onPressed: null, icon: Icon(null));
    if (_i != 8) {
      result = IconButton(
          onPressed: goLastPage,
          icon: const Icon(
            Icons.skip_next,
            size: 25,
          ));
    }
    return result;
  }

  void page() {
    setState(() {
      switch (_i) {
        case 0:
          _titre = Strings.titre0;
          _text = Strings.texte0;
          break;
        case 1:
          _titre = Strings.titre1;
          _text = Strings.texte1;

          break;
        case 2:
          _titre = Strings.titre2;
          _text = Strings.texte2;

          break;
        case 3:
          _titre = Strings.titre3;
          _text = Strings.texte3;
          break;
        case 4:
          _titre = Strings.titre4;
          _text = Strings.texte4;
          break;
        case 5:
          _titre = Strings.titre5;
          _text = Strings.texte5;
          break;
        case 6:
          _titre = Strings.titre6;
          _text = Strings.texte6;
          break;
        case 7:
          _titre = Strings.titre7;
          _text = Strings.texte7;
          break;
        case 8:
          _titre = Strings.titre8;
          _text = Strings.texte8;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.10,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Image.asset('lib/assets/beermakerlogo350.png'),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                const Text('Etapes de fabrication'),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_titre,
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.all(10)),
            Text(_text),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buttonFirst(),
            buttonPrevious(),
            buttonNext(),
            buttonLast(),
          ],
        ),
      ),
    );
  }
}
