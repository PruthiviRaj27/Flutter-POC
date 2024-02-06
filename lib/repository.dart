import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
       'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}


class Repository {

  late StreamController<List<Album>> _albumsStreamController;

  Repository() {
    _albumsStreamController = StreamController<List<Album>>.broadcast();
    fetchAlbums();
    _fetchAndUpdateData();
  }

  Stream<List<Album>> get albumsStream => _albumsStreamController.stream;


  void fetchAlbums() async {
    final localData = await getLocalAlbums();
    if(localData.isNotEmpty){
      _albumsStreamController.add(localData);
    }
  }

  Future<void> _fetchAndUpdateData() async {
    try {
      // Fetch data from network
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Album> albums =
        data.map((album) => Album.fromJson(album)).toList();

        // Save data to local database
        await saveAlbumsLocally(albums);
        _albumsStreamController.add(albums);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error fetching data from network: $e');
    }
  }

  Future<List<Album>> getLocalAlbums() async {
    final database = DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await database.query('album');
    return List.generate(maps.length, (i) {
      return Album(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        title: maps[i]['title'],
      );
    });
  }

  Future<void> saveAlbumsLocally(List<Album> albums) async {
    final database = DatabaseHelper.database;
    for (var album in albums) {
      await database.insert(
        'album',
        album.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  void dispose() {
    _albumsStreamController.close();
  }

}
