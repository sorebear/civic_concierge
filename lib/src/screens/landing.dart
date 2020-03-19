import 'package:flutter/material.dart';

import '../widgets/button.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/LPCS_Logo_Crop.png',
                width: MediaQuery.of(context).size.width - 80,
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 32.0),
              ThemedButton(
                text: 'Sign Up',
                action: () => Navigator.pushNamed(context, '/register'),
              ),
              SizedBox(height: 16.0),
              ThemedButton(
                text: 'Login',
                action: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
