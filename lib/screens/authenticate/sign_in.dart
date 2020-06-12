import 'package:reuni_gen/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reuni_gen/shared/constants.dart';

class SignIn extends StatefulWidget {
  // ToggleView
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Auth
  final AuthService _auth = AuthService();
  // Validation
  final _formKey = GlobalKey<FormState>();

  // Text
  String email = '';
  String password = '';
  // Erreur
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0.0,
        title: Text('Se connecter'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(MdiIcons.accountPlus),
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
              SizedBox(height: 20.0),
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
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Se connecter',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // Si le formulaire est valide
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'L\'adresse email ou le mot de passe n\est pas reconnu';
                        });
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
