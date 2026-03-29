import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  List<Song>? _cacheSongs;

  final Uri songsUri = Uri.https(
    'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  Uri _songByIdUri(String songId) => Uri.https(
    'test-a2a77-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs/$songId.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    if (_cacheSongs != null) {
      return _cacheSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }

      _cacheSongs = result;

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final List<Song> songs = await fetchSongs();

    for (final song in songs) {
      if (song.id == id) {
        return song;
      }
    }
    return null;
  }

  @override
  Future<void> updateSongLikes(String songId, int likes) async {
    final http.Response response = await http.patch(
      _songByIdUri(songId),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'likes': likes}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update song likes');
    }
  }
}
