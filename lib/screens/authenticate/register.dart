import 'package:flutter/material.dart';
import 'package:reuni_gen/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reuni_gen/shared/constants.dart';
import 'package:reuni_gen/shared/loading.dart';

class Register extends StatefulWidget {
  // ToggleView
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Authentification
  final AuthService _auth = AuthService();
  // Formulaire Validation
  final _formKey = GlobalKey<FormState>();
  // Erreur
  String error = '';
  // Loading Statut
  bool loading = false;
  // Email
  String email = '';
  // Mot de passe
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Adresse email'),
                      validator: (val) =>
                          val.isEmpty ? 'Entrer un email valide' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Mot de passe'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Entrer un mot de passe valide (6+ caractères)'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Créer compte',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Veuillez utiliser une adresse valide';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
