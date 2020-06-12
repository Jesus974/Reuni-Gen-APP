import 'package:flutter/material.dart';
import 'package:reuni_gen/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reuni_gen/shared/constants.dart';

class Register extends StatefulWidget {
  // ToggleView
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Auth
  final AuthService _auth = AuthService();
  // Validation
  final _formKey = GlobalKey<FormState>();
  // Erreur
  String error = '';

  // Text
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0.0,
        title: Text('Créer un compte'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(MdiIcons.login),
              label: Text(''),
              onPressed: () {
                widget.toggleView();
              })
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Réunigen',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Entrer un email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Adresse email'),
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                validator: (val) => val.length < 6
                    ? 'Entrer un mot de passe valide (6 caractères min)'
                    : null,
                decoration: textInputDecoration.copyWith(hintText: 'Mot de passe'),
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Créer compte',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // Si le formulaire est valide
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(
                            () => error = 'Veuillez entrer un email valide');
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
