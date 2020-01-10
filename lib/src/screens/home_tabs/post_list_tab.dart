import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/post_model.dart';

class PostListTab extends StatelessWidget {
  final List<PostModel> _posts;

  
  PostListTab(this._posts);

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
      itemCount: _posts.length,
      itemBuilder: (context, int index) {
        PostModel post = _posts[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            contentPadding: EdgeInsets.all(5.0),
            subtitle: Html(
              data: post.excerpt['rendered'],
            ),
            leading: FlutterLogo(size: 48.0),
            title: Text(post.title['rendered']),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_posts == null) {
      return _displayError();
    }

    if (_posts.length == 0) {
      return _displayLoading();
    }

    return _displayPosts();
  }
}
