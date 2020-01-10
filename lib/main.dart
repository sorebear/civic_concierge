import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/scoped_models/app_state.dart';
import 'src/app.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final appState = AppState();
  bool _loaded = false;
  bool _loggedIn = false;

  _SplashScreenState() {
    _fetchContent();
    _fetchUser();
  }

  _fetchContent() async {
    appState.getPosts('pages');
    appState.getPosts('posts');
    appState.getPosts('services');
  }

  _fetchUser() async {
    await appState.dbProvider.init();
    var localUser = await appState.dbProvider.fetchUser();

    if (localUser.length > 0) {
      Map<String, dynamic> user = localUser[0];
      appState.setLocalUser(
        user['username'],
        user['email'],
        user['json_web_token'],
      );

      print(user['json_web_token']);
      print(user['username']);

      setState(() => _loggedIn = true);
    }

    setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return MaterialApp(
        home: Scaffold(
          body: Material(
            color: Color.fromRGBO(66, 87, 127, 1),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return ScopedModel(
      model: appState,
      child: App(_loggedIn),
    );
  }
}
