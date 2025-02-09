import 'package:flutter/material.dart';
import './core/services/auth_service.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isLoggedIn = await AuthService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: AppRoutes.router, // Fixes Undefined Name Error
    );
  }
}
