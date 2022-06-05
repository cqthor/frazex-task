import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frazex_task/models/users_model.dart';
import 'package:frazex_task/providers/users_provider.dart';
import 'package:frazex_task/services/users_services.dart';
import 'package:frazex_task/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<Users> users = [];
  String query = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    final post = Provider.of<DataClass>(context, listen: false);
    // post.getPostData();
    post.getSearchedPostData(query);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<DataClass>(context);
    return Column(
      children: [
        buildSearch(),
        Expanded(
          child: post.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: Text('${user.id!}'),
                      title: Text(user.name!),
                      subtitle: Text(user.username!),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchUser,
      );
  Future searchUser(String query) async => debounce(() async {
        @override
        // ignore: unused_element
        void initState() {
          super.initState();
          final post = Provider.of<DataClass>(context, listen: false);
          // post.getPostData();
          post.getSearchedPostData(query);
        }

        final post = Provider.of<DataClass>(context);
        final users = await post.getSearchedPostData(query);
        // final users = await getSearchedUsersdata(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.users = users;
        });
      });
}
