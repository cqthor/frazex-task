// ignore: unused_import
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frazex_task/models/users_model.dart';
import 'package:frazex_task/providers/users_provider.dart';
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
  // Timer? debouncer;
  @override
  void initState() {
    super.initState();
    final post = Provider.of<DataClass>(context, listen: false);
    post.getPostData();
    // init();
    // post.getSearchedPostData(query);
  }

  // init() {
  //   final post = Provider.of<DataClass>(context, listen: false);
  //   setState(() {
  //     users = post.users!;
  //   });
  // }

  // void debounce(
  //   VoidCallback callback, {
  //   Duration duration = const Duration(milliseconds: 1000),
  // }) {
  //   if (debouncer != null) {
  //     debouncer!.cancel();
  //   }

  //   debouncer = Timer(duration, callback);
  // }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<DataClass>(context);

    return Column(
      children: [
        buildSearch(),
        Expanded(
          child: post.loading
              ? const Center(child: CircularProgressIndicator())
              : users.isEmpty
                  ? ListView.builder(
                      itemCount: post.users!.length,
                      itemBuilder: (context, index) {
                        final user = post.users![index];
                        return ListTile(
                          leading: Text('${user.id!}'),
                          title: Text(user.name!),
                          subtitle: Text(user.username!),
                        );
                      },
                    )
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

  // Future searchUser(String query) async => debounce(
  //       () async {
  //         // @override
  //         // // ignore: unused_element
  //         // void initState() {
  //         //   super.initState();
  //         //   final post = Provider.of<DataClass>(context, listen: false);
  //         //   // post.getPostData();
  //         //   post.getSearchedPostData(query);
  //         // }

  //         final post = Provider.of<DataClass>(context, listen: false);
  //         final users = await post.getSearchedPostData(query);
  //         // final users = await getSearchedUsersdata(query);

  //         if (!mounted) return;

  //         setState(
  //           () {
  //             this.query = query;
  //             this.users = users;
  //           },
  //         );
  //       },
  //     );
}
