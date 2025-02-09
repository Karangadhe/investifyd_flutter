import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppSideBar extends StatelessWidget {
  AppSideBar({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Home', 'icon': Icons.home, 'route': '/dashboard'},
    {'title': 'Funds', 'icon': Icons.info, 'route': '/fund'},
    {'title': 'Settings', 'icon': Icons.settings, 'route': '/settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Center(
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: menuItems.map((item) {
                return ListTile(
                  leading: Icon(item['icon'], color: Colors.black),
                  title: Text(item['title']),
                  onTap: () {
                    context.go(item['route']); // Navigate using go_router
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
