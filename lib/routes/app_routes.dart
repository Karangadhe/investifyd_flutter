import 'package:go_router/go_router.dart';
import '../core/services/auth_service.dart';
import '../views/auth/login_page.dart';
import '../views/auth/registration_page.dart';
import '../views/dashboard/dashboard_page.dart';
import '../views/mutual fund/fund_list_screen.dart';

/// **Public Routes (Accessible without login)**
final List<GoRoute> publicRoutes = [
  GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
];

/// **Private Routes (Require Authentication)**
final List<GoRoute> privateRoutes = [
  GoRoute(
      path: '/dashboard', builder: (context, state) => const DashboardPage()),
  GoRoute(path: '/fund', builder: (context, state) => const FundListScreen()),
];

/// **Global Route Management with Auth Redirection**
class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/login', // Default start route
    redirect: (context, state) async {
      bool isLoggedIn = await AuthService.isLoggedIn();

      final bool isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login'; // Redirect non-authenticated users to login
      }

      if (isLoggedIn && isAuthRoute) {
        return '/dashboard'; // Redirect logged-in users away from auth routes
      }

      return null; // Allow navigation
    },
    routes: [
      ...publicRoutes,
      ...privateRoutes,
    ],
  );
}
