import 'package:flutter/material.dart';
import 'package:frazex_task/models/users_model.dart';
import 'package:frazex_task/providers/users_provider.dart';
import 'package:frazex_task/widgets/search_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<Users>? users;
  String query = '';

  @override
  void initState() {
    super.initState();
    final post = Provider.of<DataClass>(context, listen: false);
    post.getPostData();

    init();
  }

  void init() async {
    final post = Provider.of<DataClass>(context, listen: false);
    users = post.users;
  }

  // search function
  void searchUser(String query) {
    final post = Provider.of<DataClass>(context, listen: false);
    final suggestions = post.users!.where((user) {
      final titleLower = user.name!.toLowerCase();
      final usernameLower = user.username!.toLowerCase();
      final searchLower = query.toLowerCase();
      final id = user.id.toString();
      return titleLower.contains(searchLower) ||
          usernameLower.contains(searchLower) ||
          id.contains(searchLower);
    }).toList();
    setState(() {
      users = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<DataClass>(context);

    return Column(
      children: [
        SearchWidget(
          text: query,
          hintText: AppLocalizations.of(context)?.userhinttext ??
              "Title, username or id",
          onChanged: searchUser,
        ),
        Expanded(
          child: post.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: users?.length ?? post.users!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Text(users?[index].id!.toString() ??
                            post.users![index].id.toString()),
                        title: Text(users?[index].name! ??
                            post.users![index].name.toString()),
                        subtitle: Text(
                          users?[index].username! ??
                              "${post.users![index].username}",
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
