import 'package:http/http.dart' show Client, Response;
import 'package:wordpress_api_app/src/models/service_model.dart';
import 'dart:convert';
import 'dart:async';

import '../models/page_model.dart';
import '../models/post_model.dart';

class ApiProvider {
  final Client client = Client();
  final String _root = 'https://dayrain.360-biz.com/wp-json';

  Future<Response> loginUser(usernameOrEmail, password) async {
    Map<String, String> headers = new Map();
    headers.addEntries([MapEntry('Content-Type', 'application/x-www-urlencoded')]);
    
    Map<String, String> body = {
      'username': usernameOrEmail,
      'password': password,
    };

    try {
      var res = await client.post(
        '$_root/jwt-auth/v1/token',
        body: body,
      );

      return res;
    } catch(e) {
      print('Error: ' + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> registerUser(Map<String, String> body) async {
    Map<String, String> headers = new Map();
    headers.addEntries([MapEntry('Content-Type', 'application/json')]);
    
    try {
      var res = await client.post(
        '$_root/wp/v2/users/register',
        headers: headers,
        body: jsonEncode(body),
      );

      return jsonDecode(res.body);
    } catch (e) {
      print('Error: ' + e.toString());
      return null;
    }
  }

  Future<ServiceModel> addService(title, content, jwt) async {
    Map<String, String> headers = new Map();
    headers.addEntries([
      MapEntry('Content-Type', 'application/json'),
      MapEntry('Authorization', 'Bearer $jwt'),
    ]);

    Map<String, String> body = {
      'title': title,
      'content': content,
      'slug': 'services',
      'status': 'publish',
    };

    try {
      var res = await client.post(
        '$_root/wp/v2/services',
        headers: headers,
        body: jsonEncode(body),
      );

      if (res.statusCode == 201) {
        var json = jsonDecode(res.body);
        return ServiceModel.fromJson(json);
      }

      return null;
    } catch(e) {
      print('Error: ' + e.toString());
      return null;
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      var res = await client.get('$_root/wp/v2/posts');
      var json = jsonDecode(res.body);

      List<PostModel> posts = [];
      json.forEach((postJson) {
        PostModel post = PostModel.fromJson(postJson);
        posts.add(post);
      });

      return posts;
    } catch (e) {
      print('Error: ' + e.toString());
      return [];
    }
  }

  Future<List<ServiceModel>> getServices() async {
    try {
      var res = await client.get('$_root/wp/v2/services');
      var json = jsonDecode(res.body);

      List<ServiceModel> posts = [];
      json.forEach((postJson) {
        ServiceModel post = ServiceModel.fromJson(postJson);
        posts.add(post);
      });

      return posts;
    } catch (e) {
      print('Error: ' + e.toString());
      return [];
    }
  }

  Future<List<PageModel>> getPages() async {
    try {
      var res = await client.get('$_root/wp/v2/pages');
      var json = jsonDecode(res.body);

      List<PageModel> pages = [];
      json.forEach((pageJson) {
        PageModel page = PageModel.fromJson(pageJson);
        pages.add(page);
      });

      return pages;
    } catch (e) {
      print('Error: ' + e.toString());
      return null;
    }
  }

  Future<PageModel> getPage(int id) async {
    try {
      var res = await client.get('$_root/wp/v2/pages?id=$id');
      var json =
          jsonDecode(res.body).length > 0 ? jsonDecode(res.body)[0] : null;

      if (json == null) {
        return null;
      }

      PageModel page = PageModel.fromJson(json);
      return page;
    } catch (e) {
      print('Error: ' + e.toString());
      return null;
    }
  }
}
