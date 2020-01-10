import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/models/service_model.dart';
import 'package:wordpress_api_app/src/scoped_models/app_state.dart';
import 'package:wordpress_api_app/src/screens/home_tabs/services_lists_tab.dart';

import '../api/api_provider.dart';
import '../models/page_model.dart';
import '../models/post_model.dart';
import './home_tabs/page_list_tab.dart';
import './home_tabs/post_list_tab.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (BuildContext context, child, AppState model) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'The Civic Conceirge',
                style: Theme.of(context).textTheme.display1,
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                  child: Icon(Icons.settings),
                ),
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                ServicesListTab(model.services),
                PostListTab(model.posts),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/add-service'),
              child: Icon(Icons.add),
            ),
            bottomNavigationBar: Material(
              color: Theme.of(context).primaryColor,
              child: SafeArea(
                child: TabBar(
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.search, size: 30.0)),
                    Tab(icon: Icon(Icons.alarm, size: 30.0)),
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
