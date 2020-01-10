import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/scoped_models/app_state.dart';
import 'dart:convert';

import '../api/api_provider.dart';
import '../widgets/text_field.dart';
import '../widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ApiProvider apiProvider = new ApiProvider();
  Map<String, String> _userData = {
    'username': '',
    'email': '',
    'password': '',
    'passwordConfirm': '',
  };

  void _updateValue(String inputKey, String inputValue) {
    Map<String, String> userData = _userData.map((dataKey, dataValue) {
      if (dataKey == inputKey) {
        dataValue = inputValue;
      }

      return MapEntry(dataKey, dataValue);
    });

    setState(() => _userData = userData);
  }

  Future<void> _showDialog(String title, String message, context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(message),
          actions: <Widget>[
            ThemedButton(
              action: () => Navigator.of(context).pop(),
              text: 'Close',
            ),
            SizedBox(height: 12.0),
            ThemedButton(
              action: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              text: 'Login',
            ),
            SizedBox(height: 6.0),
          ],
        );
      },
    );
  }

  void _submit(AppState model, context) async {
    var res = await apiProvider.registerUser(
      _userData['username'],
      _userData['email'],
      _userData['password'],
    );

    switch (res['code']) {
      case 406:
        _showDialog(
          'User Already Exists',
          "Please select a different username or login if you are this user.",
          context,
        );
        break;
      
      case 200:
        var response = await model.apiProvider.loginUser(
          _userData['username'],
          _userData['password'],
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> body = jsonDecode(response.body);

          model.setAndInsertLocalUser(
            body['user_display_name'],
            body['user_email'],
            body['token'],
          );

          Navigator.pushReplacementNamed(context, '/home');
        }
    }
  }

  bool _isSubmitEnabled() {
    String user = _userData['username'];
    String email = _userData['email'];
    String pw = _userData['password'];
    String pwc = _userData['passwordConfirm'];

    return user.length > 0 && email.length > 0 && pw.length > 0 && pw == pwc;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (BuildContext context, child, AppState model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Sign Up', style: Theme.of(context).textTheme.display3),
            elevation: 0,
          ),
          body: Material(
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ThemedTextField(
                      onChanged: (val) => _updateValue('username', val),
                      label: 'Name',
                    ),
                    ThemedTextField(
                      onChanged: (val) => _updateValue('email', val),
                      label: 'Email',
                    ),
                    ThemedTextField(
                      onChanged: (val) => _updateValue('password', val),
                      label: 'Password',
                      obscureText: true,
                    ),
                    ThemedTextField(
                      onChanged: (val) => _updateValue('passwordConfirm', val),
                      label: 'Confirm Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 32.0),
                    ThemedButton(
                      action:
                          _isSubmitEnabled() ? () => _submit(model, context) : null,
                      text: 'Sign Up',
                    ),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
