import 'package:flutter/material.dart';
import 'package:wordpress_api_app/src/screens/add_service.dart';
import 'package:wordpress_api_app/src/screens/settings.dart';

import './screens/login.dart';
import './screens/register.dart';
import './screens/home.dart';
import './screens/page.dart';
import './screens/landing.dart';

class App extends StatelessWidget {
  final bool loggedInOnStartup;

  App(this.loggedInOnStartup);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(135, 152, 146, 1),
        accentColor: Color.fromRGBO(205, 162, 156, 1),
        backgroundColor: Color.fromRGBO(242, 237, 233, 1),
        textTheme: TextTheme(
          display4: TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 54.0,
            color: Colors.white,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
          display3: TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 40.0,
            color: Colors.white,
          ),
          display1: TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 28.0,
            color: Colors.white,
          ),
          title: TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 32.0,
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                if (loggedInOnStartup) {
                  return HomeScreen();
                }
                return LandingScreen();
              case '/landing':
                return LandingScreen();
              case '/register':
                return RegisterScreen();
              case '/login':
                return LoginScreen();
              case '/home':
                return HomeScreen();
              case '/settings':
                return SettingsScreen();
              case '/add-service':
                return AddServiceScreen();
              case '/page':
                return PageScreen();
              default:
                return SizedBox();
            }
          },
        );
      },
    );
  }
}
