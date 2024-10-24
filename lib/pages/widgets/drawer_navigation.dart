import 'package:flutter/material.dart';
import 'package:sqflite_app/pages/todo_page.dart';

import '../contact_page.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TodoPage())),
              child: ItemDrawer(title: 'Todo', menuIcon: Icons.list)),
          GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ContactPage())),
              child:
                  ItemDrawer(title: 'Contact', menuIcon: Icons.contact_page)),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemDrawer extends StatelessWidget {
  String title;
  IconData menuIcon;
  ItemDrawer({
    super.key,
    required this.title,
    required this.menuIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(menuIcon),
      title: Text('$title'),
    );
  }
}
