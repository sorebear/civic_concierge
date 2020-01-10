import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/service_model.dart';

class ServicesListTab extends StatelessWidget {
  final List<ServiceModel> _services;

  
  ServicesListTab(this._services);

  _displayLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _displayError() {
    return Center(
      child: Text('There was an error loading this content.'),
    );
  }

  _displayPosts() {
    return ListView.builder(
      itemCount: _services.length,
      itemBuilder: (context, int index) {
        ServiceModel service = _services[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            contentPadding: EdgeInsets.all(5.0),
            leading: FlutterLogo(size: 48.0),
            title: Text(service.title['rendered']),
            subtitle: Html(
              data: service.content['rendered'],
            ),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_services == null) {
      return _displayError();
    }

    if (_services.length == 0) {
      return _displayLoading();
    }

    return _displayPosts();
  }
}
