import 'package:flutter/material.dart';
import 'package:frazex_task/models/posts_models.dart';
import 'package:frazex_task/services/posts_services.dart';

class PostClass extends ChangeNotifier {
  List<Posts>? posts;

  bool loading = false;

  getPostData() async {
    loading = true;
    posts = await getPostsData();

    loading = false;

    notifyListeners();
  }
}
