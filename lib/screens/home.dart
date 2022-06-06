import 'package:flutter/material.dart';
import 'package:frazex_task/providers/locale_provider.dart';
import 'package:frazex_task/screens/post_screen.dart';
import 'package:frazex_task/screens/users_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _pages = [
    UsersScreen(),
    PostsScreen(),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      AppLocalizations.of(context)?.users ?? 'Users',
      AppLocalizations.of(context)?.posts ?? 'Posts',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles.elementAt(_selectedIndex)),
      ),
      body: Center(child: _pages.elementAt(_selectedIndex)),
      drawer: Drawer(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // const Text("Change Language"),
            ElevatedButton(
                onPressed: () {
                  context.read<LocaleProvider>().setLocale(const Locale("az"));
                },
                child: const Text("Change language "))
          ],
        ),
      ))),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xff3580FF),
        unselectedItemColor: const Color(0xff848A94),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_open), label: 'Folder'),
        ],
      ),
    );
  }
}
