import 'package:flutter/material.dart';
import 'package:frazex_task/models/users_model.dart';
import 'package:frazex_task/services/users_services.dart';

class DataClass extends ChangeNotifier {
  late List<Users> users;
  List<Users>? searchedUsers;
  bool loading = false;

  // getPostData() async {
  //   loading = true;
  //   users = await getUsersdata();

  //   loading = false;

  //   notifyListeners();
  // }

  getSearchedPostData(query) async {
    loading = true;
    searchedUsers = await getSearchedUsersdata(query);

    loading = false;

    notifyListeners();
  }
}
