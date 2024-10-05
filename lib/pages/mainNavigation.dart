import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:freshers/pages/aiChat.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freshers/pages/first_page.dart';
import 'package:freshers/pages/last_page.dart';
import 'package:freshers/pages/middle_page.dart';
import 'package:freshers/util/smart_device_box.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    FirstPage(),  // Replace with the appropriate first page widget
    MiddlePage(),
    LastPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
         
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.secondary,
        animationCurve: Curves.linearToEaseOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.wysiwyg, color: Colors.white),
          Icon(Icons.library_books, color: Colors.white),
        ],
      ),
    );
  }
}
