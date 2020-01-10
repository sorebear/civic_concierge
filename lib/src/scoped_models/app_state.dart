import 'package:scoped_model/scoped_model.dart';
import 'package:wordpress_api_app/src/api/db_provider.dart';
import 'package:wordpress_api_app/src/models/page_model.dart';
import 'package:wordpress_api_app/src/models/post_model.dart';
import 'package:wordpress_api_app/src/models/service_model.dart';

import '../api/api_provider.dart';

class AppState extends Model {
  final ApiProvider _apiProvider = ApiProvider();
  final DbProvider _dbProvider = DbProvider();

  List<PageModel> _pages;
  List<PostModel> _posts;
  List<ServiceModel> _services;
  
  String _username;
  String _email;
  String _jwt;

  // Getters
  ApiProvider get apiProvider => _apiProvider;
  DbProvider get dbProvider => _dbProvider;

  List<PageModel> get pages => _pages;
  List<PostModel> get posts => _posts;
  List<ServiceModel> get services => _services;

  String get jwt => _jwt;
  String get username => _username;
  String get email => _email;

  setLocalUser(username, email, jwt) {
    _username = username;
    _email = email;
    _jwt = jwt;

    notifyListeners();
  }

  setAndInsertLocalUser(username, email, jwt) {
    setLocalUser(username, email, jwt);
    _dbProvider.setUser(username, email, jwt);
  }

  addService(String title, String content) async {
    ServiceModel newService = await _apiProvider.addService(title, content, _jwt);

    List<ServiceModel> updatedServices = services;
    updatedServices.insert(0, newService);
    _services = updatedServices;

    notifyListeners();
    return newService;
  }

  getPosts(String postType) async {
    switch(postType) {
      case 'posts':
        _posts = await _apiProvider.getPosts();
        break;
      case 'services':
        _services = await _apiProvider.getServices();
        break;
      case 'pages':
        _pages = await _apiProvider.getPages();
        break;
    }

    notifyListeners();
  }
}