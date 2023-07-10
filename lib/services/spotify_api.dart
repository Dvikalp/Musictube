import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SpotifyApi {
  static const _baseUrl = 'https://api.spotify.com/v1';
  final client_id='ae0221763b7240cba964dff89988e371';
  final client_secret='0930d09dedd8477f9e3f0f847bc203d3';
  static final basicAuth = base64.encode(utf8.encode('ae0221763b7240cba964dff89988e371:0930d09dedd8477f9e3f0f847bc203d3'));
  static Future<String> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
        'Basic ${basicAuth}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials',
    );
    //print(response);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['access_token'];
    } else {
      throw Exception('Failed to retrieve access token');
    }
  }

  static Future<void> getArtist(String artistId) async {
    final accessToken = await _getAccessToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/artists/$artistId'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
     // print(jsonResponse);
      // Process the artist data
    } else {
      throw Exception('Failed to load artist');
    }
  }
  static Future<List<String?>> getPlayableTracks(String artistId) async {
    final accessToken = await _getAccessToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/artists/$artistId/top-tracks?market=SE'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final tracks = jsonResponse['tracks'] as List<dynamic>;
      print(tracks.map<int?>((track) => track['popularity']as int?).toList());
      return tracks.map<String?>((track) => track['preview_url']as String?).toList();
    } else {
      throw Exception('Failed to load playable tracks');
    }
  }
}
