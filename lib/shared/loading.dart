import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://consort-group.com/wp-content/uploads/2017/01/2-assurance-et-sante-357061904.png"),
              fit: BoxFit.cover)),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
