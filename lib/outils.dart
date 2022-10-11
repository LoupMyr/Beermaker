import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
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
  Column _result = Column();

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
      _result = Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
                '${Strings.strMalt}$malt kg\n${Strings.strBrassage}$brassage L\n${Strings.strRincage}$rincage L\n${Strings.strAmerisant}$amerisant g\n${Strings.strAromatique}$aromatique g\n${Strings.strLevure}$levure g'),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    '${Strings.strMCU}$mcu\n${Strings.strEBC}$ebc\n${Strings.strSRM}$srm'),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Container(
                height: 50,
                width: 200,
                color: Color(int.parse(rgb)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(rgb,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => saveRecette(),
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      );
    });
  }

  void saveRecette() {
    Map<String, dynamic> recettes = new Map();
    bool recupRecettes = false;

    Future<http.Response> recupConnect(
        double litreBiere, double degres, double ebc) {
      return http.post(
        Uri.parse('https://s3-4428.nuage-peda.fr/Beermaker/public/api/recette'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
          <String, String>{
            'litreBiere': litreBiere.toString(),
            'degres': degres.toString(),
            'ebc': ebc.toString()
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.13,
              height: MediaQuery.of(context).size.height * 0.13,
              child: Image.asset('lib/assets/beermakerlogo350.png'),
            ),
            Padding(padding: EdgeInsets.all(5)),
            const Text('Outils de fabrication'),
          ],
        ),
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
              _result,
            ],
          ),
        ),
      ),
    );
  }
}
