import 'signup.dart';
import 'package:flutter/material.dart';
import 'ocr_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 227, 227, 233),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Text(
          "LOGIN",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 77, 72, 85)),
        ),
        Text(
          "Enter your credential to login",
          style: TextStyle(color: Color.fromARGB(255, 77, 72, 85)),
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            fillColor: Color.fromARGB(255, 200, 190, 216),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            fillColor: Color.fromARGB(255, 200, 190, 216),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            filled: true,
            prefixIcon: Icon(Icons.password_outlined),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _validateLogin(context);
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 77, 72, 85)),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade300,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Color.fromARGB(255, 77, 72, 85)),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.deepPurple.shade300),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds:1 ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 Future<void> _validateLogin(BuildContext context) async {
  String username = _usernameController.text;
  String password = _passwordController.text;

  if (username.isEmpty || password.isEmpty) {
    _showSnackBar(context, "Please fill in all fields.");
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  String storedUsername = prefs.getString('username') ?? '';
  String storedPassword = prefs.getString('password') ?? '';

  if (storedUsername.isEmpty || storedPassword.isEmpty) {
    _showSnackBar(context, "Invalid credentials or Sign up first.");
  } else if (storedUsername == username && storedPassword == password) {
    _showSnackBar(context, "Login successfully.");
    Future.delayed(Duration(seconds: 1), () {
      // Navigate to HomePage after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OcrScreen()),
      );
    });
  } else {
    // Add this else condition to handle incorrect credentials
    _showSnackBar(context, "Incorrect username or password.");
  }
}
}



