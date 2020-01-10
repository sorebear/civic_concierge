import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/scoped_models/app_state.dart';
import 'dart:convert';

import '../api/api_provider.dart';
import '../widgets/text_field.dart';
import '../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiProvider apiProvider = new ApiProvider();
  Map<String, String> _userData = {
    'usernameOrEmail': '',
    'password': '',
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
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ThemedButton(
              action: () => Navigator.of(context).pop(),
              text: 'Close',
            ),
          ],
        );
      },
    );
  }

  void _submit(AppState model, context) async {
    var res = await model.apiProvider.loginUser(
      _userData['usernameOrEmail'],
      _userData['password'],
    );

    switch (res.statusCode) {
      case 403:
        _showDialog(
          'Invalid Credentials',
          'The supplied password does not match the username.',
          context,
        );
        break;
      case 200:
        Map<String, dynamic> body = jsonDecode(res.body);

        model.setAndInsertLocalUser(
          body['user_display_name'],
          body['user_email'],
          body['token'],
        );

        Navigator.pushReplacementNamed(context, '/home');
    }
  }

  bool _isEnabled() {
    String user = _userData['usernameOrEmail'];
    String pw = _userData['password'];

    return user.length > 0 && pw.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (BuildContext context, child, AppState model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Login', style: Theme.of(context).textTheme.display3),
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
                      onChanged: (val) => _updateValue('usernameOrEmail', val),
                      label: 'Username / Email',
                    ),
                    ThemedTextField(
                      onChanged: (val) => _updateValue('password', val),
                      label: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 32.0),
                    ThemedButton(
                      action:
                          _isEnabled() ? () => _submit(model, context) : null,
                      text: 'Login',
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
