import 'package:flutter/material.dart';
// Import Login page
// import '../user_data.dart'; // Import user_data.dart to access global users map

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // final TextEditingController _ageController = TextEditingController();

  // Function to handle registration
  void _register() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    // String ageText = _ageController.text;

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    // Validate age
    // int? age = int.tryParse(ageText);
    // if (age == null || age < 18) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('You must be 18 years or older to register')),
    //   );
    //   return;
    // }

    // Add user to in-memory storage (global users map)
    //users[username] = password;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration successful! You can now log in.')),
    );
    Navigator.pop(context); // Go back to Login Page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Register', style: TextStyle(fontWeight: FontWeight.bold)),
      //   backgroundColor: Color(0xFF0A2542), // Custom theme color
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create an Account',
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
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            // TextField(
            //   controller: _ageController,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: 'Age',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     prefixIcon: Icon(Icons.calendar_today),
            //   ),
            // ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2542), // Custom theme color
                padding: EdgeInsets.symmetric(vertical: 25),
                textStyle: TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Already have an account? Login here',
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
