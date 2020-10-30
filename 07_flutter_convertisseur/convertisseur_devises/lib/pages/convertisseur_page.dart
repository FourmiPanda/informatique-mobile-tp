import 'package:convertisseur_devises/devise.dart';
import 'package:convertisseur_devises/styles.dart';
import 'package:flutter/material.dart';

class ConvertisseurDevisePage extends StatefulWidget {

  ConvertisseurDevisePage();

  @override
  State<StatefulWidget> createState() {
    return _ConvertisseurDevisePage();
  }

}
class _ConvertisseurDevisePage extends State<ConvertisseurDevisePage> {

  // les différents "états" de la page
  double _valeur; // valeur saisie
  Devise _deviseInitial; // devise initiale sélectionnée
  Devise _deviseFinale; // devise finale sélectionnée
  double _resultat; // le résultat de la conversion

  // définition des valeurs initiales
  @override
  void initState() {
    super.initState();
    _valeur = 0;
    _resultat = 0;
    _deviseInitial = Devise.EURO;
    _deviseFinale = Devise.DOLLAR;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              'Valeur : ' +  _valeur.toString(),
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
            Spacer(),
            Text(
              'De',
              style: AppStyle.labelStyle,
            ),
            Spacer(),
            DropdownButton(
                isExpanded: true,
                onChanged: (Devise newVal) => {
                    setState(() {
                      _deviseInitial = newVal;
                    })
                },
              value: _deviseInitial,
              items: Devise.values
                  .map<DropdownMenuItem<Devise>>((Devise value) {
                return DropdownMenuItem<Devise>(
                  value: value,
                  child: Text(value.libelle),
                );
              }).toList(),),
            Spacer(),
            Text('Vers', style: AppStyle.labelStyle),
            Spacer(),
            DropdownButton(
                isExpanded: true,
                onChanged: (newVal) => {
                  setState(() {
                    _deviseFinale = newVal;
                  })
                },
              value: _deviseFinale,
              items: Devise.values
                  .map<DropdownMenuItem<Devise>>((Devise value) {
                return DropdownMenuItem<Devise>(
                  value: value,
                  child: Text(value.libelle),
                );
              }).toList(),),
            Spacer(
              flex: 2,
            ),
            ElevatedButton(onPressed: () => {
              setState(() {
                _resultat = (_valeur / _deviseInitial.t) * _deviseFinale.t ;
              })
            }, child: Text('Convertir')),
            Spacer(
              flex: 2,
            ),
            Text(_resultat.toString(), style: AppStyle.labelStyle),
            Spacer(),
          ],
        ));
  }
}