import 'package:convertisseur_devises/devise.dart';
import 'package:convertisseur_devises/styles.dart';
import 'package:flutter/material.dart';

class ListeDeviseWidget extends StatefulWidget {

  ListeDeviseWidget({
    Key key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListeDeviseWidgetState();
  }

}

class ListeDeviseWidgetState extends State<ListeDeviseWidget> {

  Devise _deviseInitial; // devise initiale sélectionnée
  Devise _deviseFinale; // devise finale sélectionnée

  Devise get deviseInitial => _deviseInitial;
  Devise get deviseFinale => _deviseFinale;


  @override
  void initState() {
    super.initState();
    _deviseInitial = Devise.EURO;
    _deviseFinale = Devise.DOLLAR;
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306),
        child: Column(
            children: [
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
            ]),
        height: 300);
  }
}