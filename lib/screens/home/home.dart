import 'package:reuni_gen/models/brew.dart';
import 'package:reuni_gen/screens/home/brew_list.dart';
import 'package:reuni_gen/screens/home/setting_form.dart';
import 'package:reuni_gen/services/auth.dart';
import 'package:reuni_gen/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Réuni-Gen'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.red, Colors.blue])),
          ),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(
              child: Icon(MdiIcons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: BrewList(),
        bottomNavigationBar: Container(
          height: 56,
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Row(
            children: <Widget>[
              Container(
                width: 120,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.chat, color: Colors.white),
                    Text("CHAT", style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Container(
                width: 120,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home, color: Colors.white),
                    Text("CHAT", style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Container(
                width: 120,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.settings, color: Colors.white),
                      onPressed: () => _showSettingsPanel(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
