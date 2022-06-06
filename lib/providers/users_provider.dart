import 'package:flutter/material.dart';
import 'package:frazex_task/models/users_model.dart';
import 'package:frazex_task/services/users_services.dart';

class DataClass extends ChangeNotifier {
  List<Users>? users;
  // List<Users>? searchedUsers;
  bool loading = false;
  // bool searchLoading = false;
  getPostData() async {
    loading = true;
    users = await getUsersdata();

    loading = false;

    notifyListeners();
  }

  // getSearchedPostData(query) async {
  //   searchLoading = true;
  //   searchedUsers = await getSearchedUsersdata(query);

  //   searchLoading = false;

  //   notifyListeners();
  // }
}
