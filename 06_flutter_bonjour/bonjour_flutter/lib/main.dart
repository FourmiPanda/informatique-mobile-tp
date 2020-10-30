import 'package:flutter/material.dart';

void main() => runApp(MonApplication());

class MonApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('Bonjour App'),
        backgroundColor: Color(0xffb74093),
      ),
    body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                  child: Column(
                    children: [
                      Text (
                        'Bonjour',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xffb74093),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text (
                        'Je suis Ross',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xffb74093)
                        ),
                      ),
                      Image.network(
                          'https://pbs.twimg.com/profile_images/786630896279584768/UMKOwJeM.jpg',
                          height: 350
                      ),
                      BoutonContactezMoi(),
                    ],
                  )
              ),
            );
          },
        ),
    )
    ),
    );
  }
}

class BoutonContactezMoi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // background color
        primary: Color(0xffb74093),
      ),
      child: Text('Contactez-moi !'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Contactez-moi'),
              content: Text('Je suis joignable à l\'IMT Atlantique'),
            );
          }
        );
      },
    );
  }
}