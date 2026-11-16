import 'package:flutter/material.dart';
import '../models/album.dart';
import '../services/api_service.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;

  const AlbumDetailScreen({
    super.key,
    required this.albumId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
      ),
      body: FutureBuilder<Album>(
        future: ApiService().fetchAlbum(albumId),
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

          final album = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Album ID: ${album.id}'),
                const SizedBox(height: 10),
                Text('User ID: ${album.userId}'),
                const SizedBox(height: 10),
                Text('Title: ${album.title}'),
              ],
            ),
          );
        },
      ),
    );
  }
}