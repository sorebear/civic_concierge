import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/scoped_models/app_state.dart';
import 'package:wordpress_api_app/src/widgets/button.dart';

class SettingsScreen extends StatelessWidget {

  _logout(AppState model, context) async {
    var res = await model.dbProvider.deleteUser();
    if (res == 1) {
      Navigator.pushNamedAndRemoveUntil(context, '/landing', (Route route) {
        return route.isFirst;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (context, child, AppState model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: Center(
            child: ListView(
              children: <Widget>[
                ThemedButton(
                  text: 'Logout',
                  action: () => _logout(model, context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
