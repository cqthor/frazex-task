import 'dart:convert';

import 'package:frazex_task/models/users_model.dart';
import 'package:http/http.dart' as http;

Future<List<Users>> getUsersdata() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  if (response.statusCode == 200) {
    final List users = json.decode(response.body) as List<dynamic>;
    return users.map((e) => Users.fromJson(e)).toList();
  } else {
    throw Exception();
  }
}

Future<List<Users>> getSearchedUsersdata(String query) async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  if (response.statusCode == 200) {
    final List users = json.decode(response.body) as List<dynamic>;
    return users.map((e) => Users.fromJson(e)).where((user) {
      final titleLower = user.name!.toLowerCase();
      final usernameLower = user.username!.toLowerCase();
      final searchLower = query.toLowerCase();
      final id = user.id.toString();
      return titleLower.contains(searchLower) ||
          usernameLower.contains(searchLower) ||
          id.contains(searchLower);
    }).toList();
  } else {
    throw Exception();
  }
}
