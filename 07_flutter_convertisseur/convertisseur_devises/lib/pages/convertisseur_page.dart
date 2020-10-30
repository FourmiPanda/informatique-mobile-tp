import 'package:convertisseur_devises/widgets/liste_devises.dart';
import 'package:convertisseur_devises/widgets/saisie_nombre.dart';
import 'package:convertisseur_devises/styles.dart';
import 'package:convertisseur_devises/devise.dart';
import 'package:flutter/material.dart';

class ConvertisseurDevisePage extends StatefulWidget {

  ConvertisseurDevisePage();

  @override
  State<StatefulWidget> createState() {
    return _ConvertisseurDevisePage();
  }

}
class _ConvertisseurDevisePage extends State<ConvertisseurDevisePage> {

  double _resultat; // le résultat de la conversion

  // définition des valeurs initiales
  @override
  void initState() {
    super.initState();
    _resultat = 0;
  }

  final keySaisieNombre = new GlobalKey<SaisieNombreWidgetState>();
  final keyListeDevise = new GlobalKey<ListeDeviseWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Spacer(),
            //Saisie nombre
            SaisieNombreWidget(
              key: keySaisieNombre
            ),
            Spacer(),
            //Liste devise
            ListeDeviseWidget(
              key: keyListeDevise
            ),
            Spacer(
              flex: 2,
            ),
            ElevatedButton(onPressed: () => {
              setState(() {
                _resultat = (keySaisieNombre.currentState.valeur / keyListeDevise.currentState.deviseInitial.t) * keyListeDevise.currentState.deviseFinale.t ;
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


