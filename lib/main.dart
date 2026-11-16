import 'package:flutter/material.dart';
import 'models/album.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlbumListScreen(),
    );
  }
}

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() =>
      _AlbumListScreenState();
}

class _AlbumListScreenState
    extends State<AlbumListScreen> {
  late Future<List<Album>> albums;

  @override
  void initState() {
    super.initState();
    albums = ApiService().fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESTful CRUD Explorer'),
      ),
      body: FutureBuilder<List<Album>>(
        future: albums,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final albumList = snapshot.data ?? [];

          return ListView.builder(
            itemCount: albumList.length,
            itemBuilder: (context, index) {
              final album = albumList[index];

              return ListTile(
                leading: const Icon(Icons.album),
                title: Text(album.title),
                subtitle: Text('Album ID: ${album.id}'),
              );
            },
          );
        },
      ),
    );
  }
}