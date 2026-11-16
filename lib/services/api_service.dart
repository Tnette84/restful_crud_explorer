import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class ApiService {
  final String baseUrl =
      'https://jsonplaceholder.typicode.com';

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(
      Uri.parse('$baseUrl/albums'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<Album> fetchAlbum(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/albums/$id'),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> deleteAlbum(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/albums/$id'),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 204) {
      throw Exception('Failed to delete album');
    }
  }
}