import 'package:flutter/material.dart';
import 'models/album.dart';
import 'services/api_service.dart';
import 'screens/album_detail_screen.dart';

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
  final Set<int> deletedIds = {};

  @override
  void initState() {
    super.initState();
    albums = ApiService().fetchAlbums();
  }

  Future<void> deleteAlbum(Album album) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Album'),
        content: const Text(
          'Are you sure you want to delete this album?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await ApiService().deleteAlbum(album.id);

      if (!mounted) return;

      setState(() {
        deletedIds.add(album.id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Album deleted successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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

          final albumList = (snapshot.data ?? [])
              .where((album) => !deletedIds.contains(album.id))
              .toList();

          return ListView.builder(
            itemCount: albumList.length,
            itemBuilder: (context, index) {
              final album = albumList[index];

              return ListTile(
                leading: const Icon(Icons.album),
                title: Text(album.title),
                subtitle: Text('Album ID: ${album.id}'),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => deleteAlbum(album),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AlbumDetailScreen(albumId: album.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}