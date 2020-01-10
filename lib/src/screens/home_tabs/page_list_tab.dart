import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/page_model.dart';


 
class PageListTab extends StatelessWidget {
  final List<PageModel> _pages;

  PageListTab(this._pages);

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

  _displayPages() {
    return ListView.builder(
      itemCount: _pages.length,
      itemBuilder: (context, int index) {
        PageModel page = _pages[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            contentPadding: EdgeInsets.all(5.0),
            subtitle: Html(

              data: page.excerpt['rendered'],
            ),
            leading: FlutterLogo(size: 48.0),
            title: Text(page.title['rendered']),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pages == null) {
      return _displayError();
    }

    if (_pages.length == 0) {
      return _displayLoading();
    }

    return _displayPages();
  }
}
