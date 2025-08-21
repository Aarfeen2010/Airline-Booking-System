import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF4FC3F7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text(
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF4FC3F7)),
                ),
                onChanged: (value) => email = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF4FC3F7)),
                ),
                onChanged: (value) => password = value,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4FC3F7),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged in successfully')),
                  );
                },
                child: Text('Login', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Color(0xFFFF7043), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
