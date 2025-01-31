import 'package:flutter/material.dart';
import '../views/auth/login_page.dart';
import '../views/dashboard/dashboard_page.dart';
import '../views/mutual fund/fund_list_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String fund = '/fund';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case fund:
        return MaterialPageRoute(builder: (_) => FundListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Unknown Route'))),
        );
    }
  }
}
