import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/calculs.dart';
import 'package:flutter_application_3/recette.dart';
import 'package:flutter_application_3/strings.dart';

class OutilsPage extends StatefulWidget {
  const OutilsPage({super.key, required this.title});

  final String title;

  @override
  State<OutilsPage> createState() => OutilsPageState();
}

class OutilsPageState extends State<OutilsPage> {
  final _formkey = GlobalKey<FormState>();
  double _litreBiere = 0;
  double _degres = 0;
  double _ebcGrain = 0;
  Text _tProduction = const Text('');
  Text _tRegles = const Text('');

  void send() {
    double malt = Calculs.calcMalt(_litreBiere, _degres);
    double brassage = Calculs.calcBrassage(malt);
    double rincage = Calculs.calcRincage(_litreBiere, brassage);
    double amerisant = Calculs.calcAmerisant(_litreBiere);
    double aromatique = _litreBiere;
    double levure = Calculs.calcLevure(_litreBiere);
    double mcu = Calculs.calcMcu(_ebcGrain, _litreBiere);
    double ebc = Calculs.calcEbc(mcu);
    double srm = Calculs.calcSrm(ebc);
    String rgb = Recette.srmToRGB(srm);
    setState(() {
      _tProduction = Text(
          '${Strings.strMalt}$malt kg\n${Strings.strBrassage}$brassage L\n${Strings.strRincage}$rincage L\n${Strings.strAmerisant}$amerisant g\n${Strings.strAromatique}$aromatique g\n${Strings.strLevure}$levure g');
      _tRegles = Text(
          '${Strings.strMCU}$mcu\n${Strings.strEBC}$ebc\n${Strings.strSRM}$srm');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [Image.asset('lib/assets/beermakerlogo350.png')],
          title: const Text('Outils de fabrication'),
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text(Strings.strBiere),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (biere) {
                      if (biere == null || biere.isEmpty) {
                        return Strings.strWrong;
                      } else {
                        _litreBiere = double.parse(biere.toString());
                      }
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text(Strings.strDegres),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (degres) {
                      if (degres == null || degres.isEmpty) {
                        return Strings.strWrong;
                      } else {
                        _degres = double.parse(degres.toString());
                      }
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text(Strings.strEbcGrains),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (ebc) {
                      if (ebc == null || ebc.isEmpty) {
                        return Strings.strWrong;
                      } else {
                        _ebcGrain = double.parse(ebc.toString());
                      }
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        send();
                      }
                    },
                    child: const Text(Strings.strSend)),
                const Padding(padding: EdgeInsets.all(20)),
                Container(
                  alignment: Alignment.centerLeft,
                  child: _tProduction,
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Container(
                  alignment: Alignment.centerLeft,
                  child: _tRegles,
                ),
              ],
            ),
          ),
        ));
  }
}
