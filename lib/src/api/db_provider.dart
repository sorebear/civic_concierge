import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

class DbProvider {
  Database localUserDb;

  Future<int> init() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    final path = join(docsDirectory.path, 'local_user.db');
    localUserDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE local_user
            (
              username TEXT PRIMARY KEY,
              email TEXT,
              json_web_token TEXT
            )
        """);
      }
    );

    return 1;
  }

  Future<List<Map<String, dynamic>>> fetchUser() async {
    final results = await localUserDb.query('local_user');
    return results;
  }

  Future<int> setUser(String username, String email, String jwt) async {
    int result = await localUserDb.insert('local_user', {
      'username': username,
      'email': email,
      'json_web_token': jwt
    }); 
    
    return result;
  }

  Future<int> deleteUser() async {
    int result = await localUserDb.delete('local_user');
    return result;
  }

  Future<void> close() async => localUserDb.close();
}