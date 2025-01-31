import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/auth/login_page.dart';
import 'views/dashboard/dashboard_page.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF0A2542, // Hex color as theme primary color
          {
            50: Color(0xFFe6f0fa),
            100: Color(0xFFb8d5f0),
            200: Color(0xFF89baf0),
            300: Color(0xFF5a9fe5),
            400: Color(0xFF2b85d2),
            500: Color(0xFF0a2542), // Deep Blue color
            600: Color(0xFF08213b),
            700: Color(0xFF06172f),
            800: Color(0xFF051625),
            900: Color(0xFF040b1a),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
