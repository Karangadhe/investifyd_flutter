import 'package:flutter/material.dart';

class AppSideBar extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Home', 'icon': Icons.home, 'route': '/home'},
    {'title': 'Funds', 'icon': Icons.info, 'route': '/fund'},
    {'title': 'Settings', 'icon': Icons.settings, 'route': '/settings'},
  ];

  const AppSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: menuItems.map((item) {
                return ListTile(
                  leading: Icon(item['icon'], color: Colors.black),
                  title: Text(item['title']),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, item['route']);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
