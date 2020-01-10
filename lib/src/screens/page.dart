import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../api/api_provider.dart';
import '../models/page_model.dart';

class PageScreen extends StatefulWidget {
  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  final ApiProvider apiProvider = ApiProvider();
  final int _id = 2;
  PageModel _page;

  _PageScreenState() {
    _getContent();
  }

  _getContent() async {
    PageModel page = await apiProvider.getPage(_id);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_page is PageModel) {
      return Scaffold(
        appBar: AppBar(title: Text(_page.title['rendered'])),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              child: Html(
                data: _page.content['rendered'],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('loading'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
