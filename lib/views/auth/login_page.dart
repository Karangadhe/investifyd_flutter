import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/api_service.dart'; // Make sure you import your ApiService file
import './registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  // This function will be called when the user presses the login button
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Show loading indicator
      _errorMessage = ''; // Reset any previous error message
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Check if username and password are provided
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Please fill in both username and password';
      });
      return;
    }

    // Prepare the request body (username and password)
    final body = {
      'userEmail': username,
      'password': password,
    };

    try {
      // Call the API service to fetch login data
      final response = await ApiService.fetchLoginAPI(
          '/ins/authenticate', 'POST',
          body: body);

      // Check the response and handle successful login
      if (response['token'] != null) {
        // Save the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', response['token']);

        // Navigate to another screen (e.g., dashboard or home)r
        Navigator.pushReplacementNamed(context, '/fund');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Login failed: ${response['message']}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Login',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       color: Color.fromARGB(255, 242, 243, 244),
      //     ),
      //   ),
      //   backgroundColor: Color(0xFF0A2542),
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A2542), // Custom theme color
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A2542), // Custom theme color
                      padding: EdgeInsets.symmetric(vertical: 25),
                      textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                );
              },
              child: Text(
                'Create a new account',
                style:
                    TextStyle(color: Color(0xFF0A2542)), // Custom theme color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
