import 'package:flutter/material.dart';
import '../../components/app_side_bar.dart';
import '../../components/app_top_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Dashboard'),
      drawer: AppSideBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dashboard,
                size: 100,
                color: Color(0xFF0A2542),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to your dashboard!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2542),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
