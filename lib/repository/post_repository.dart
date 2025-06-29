import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/post_model.dart';

class PostRepository {


  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts(int page, int limit) async {
    final response = await http.get(Uri.parse('$_baseUrl?_page=$page&_limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PostModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
