import 'package:flutter/material.dart';
import 'package:frazex_task/models/posts_models.dart';
import 'package:frazex_task/providers/post_provider.dart';
import 'package:frazex_task/widgets/search_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Posts>? posts;
  String query = '';
  @override
  void initState() {
    super.initState();
    final post = Provider.of<PostClass>(context, listen: false);
    post.getPostData();
    init();
  }

  void init() async {
    final post = Provider.of<PostClass>(context, listen: false);
    posts = post.posts;
  }

  // search function
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

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostClass>(context);
    return Column(
      children: [
        SearchWidget(
          text: query,
          hintText:
              AppLocalizations.of(context)?.posthinttext ?? "Title, post or id",
          onChanged: searchUser,
        ),
        Expanded(
          child: post.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: posts?.length ?? post.posts!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Text(posts?[index].id!.toString() ??
                            post.posts![index].id.toString()),
                        title: Text(posts?[index].title! ??
                            post.posts![index].title.toString()),
                        subtitle: Text(posts?[index].body! ??
                            "${post.posts![index].body}"),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
