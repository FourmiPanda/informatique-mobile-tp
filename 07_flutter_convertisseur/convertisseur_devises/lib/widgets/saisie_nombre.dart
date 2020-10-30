import 'package:convertisseur_devises/devise.dart';
import 'package:convertisseur_devises/styles.dart';
import 'package:flutter/material.dart';

class SaisieNombreWidget extends StatefulWidget {

  SaisieNombreWidget({
    Key key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SaisieNombreWidgetState();
  }

}

class SaisieNombreWidgetState extends State<SaisieNombreWidget> {

  double _valeur; // valeur entrée

  double get valeur => _valeur;


  @override
  void initState() {
    super.initState();
    _valeur = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306),
        child: Column(
            children: [
              Text(
                'Valeur',
                style: AppStyle.labelStyle,
              ),
              Spacer(),
              TextField( style: AppStyle.inputStyle,
                onChanged: (saisie) {
                  var valeurSaisie = double.parse(saisie);
                  setState(() {
                    _valeur = valeurSaisie;
                  });
                },
              ),
            ]),
        height: 100);
  }
}