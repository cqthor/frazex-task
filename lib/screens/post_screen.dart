import 'package:flutter/material.dart';
import 'package:frazex_task/models/posts_models.dart';
import 'package:frazex_task/providers/post_provider.dart';
import 'package:frazex_task/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Posts> posts = [];
  String query = '';
  @override
  void initState() {
    super.initState();
    final post = Provider.of<PostClass>(context, listen: false);
    post.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostClass>(context);
    return Column(
      children: [
        buildSearch(),
        Expanded(
          child: post.loading
              ? const Center(child: CircularProgressIndicator())
              : posts.isEmpty
                  ? ListView.builder(
                      itemCount: post.posts!.length,
                      itemBuilder: (context, index) {
                        final user = post.posts![index];
                        return ListTile(
                          leading: Text('${user.id!}'),
                          title: Text(user.title!),
                          subtitle: Text(user.body!),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final user = posts[index];
                        return ListTile(
                          leading: Text('${user.id!}'),
                          title: Text(user.title!),
                          subtitle: Text(user.body!),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title, id or post',
        onChanged: searchUser,
      );

  void searchUser(String query) {
    final post = Provider.of<PostClass>(context, listen: false);
    final suggestions = post.posts!.where((user) {
      final titleLower = user.title!.toLowerCase();
      final bodyLower = user.body!.toLowerCase();
      final searchLower = query.toLowerCase();
      final id = user.id.toString();
      return titleLower.contains(searchLower) ||
          bodyLower.contains(searchLower) ||
          id.contains(searchLower);
    }).toList();
    setState(() {
      posts = suggestions;
    });
  }
}
