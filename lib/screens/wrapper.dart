import 'package:provider/provider.dart';
import 'package:reuni_gen/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:reuni_gen/models/user.dart';
import 'package:reuni_gen/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
