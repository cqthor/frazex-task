import 'dart:convert';

import 'package:frazex_task/models/posts_models.dart';
import 'package:http/http.dart' as http;

Future<List<Posts>> getPostsData() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  if (response.statusCode == 200) {
    final List posts = json.decode(response.body) as List<dynamic>;
    return posts.map((e) => Posts.fromJson(e)).toList();
  } else {
    throw Exception();
  }
}
