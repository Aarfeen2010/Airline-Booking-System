import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Auth/signup_page.dart';
import 'package:travelex/Widget/Auth/Login/auth_text_field.dart';
import 'package:travelex/Widget/Text/roboto.dart';
import 'package:travelex/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
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
                  color: AppColors.text,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              AuthTextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "Email",
                iconColor: AppColors.accent,
                fillColor: AppColors.text.withOpacity(0.1),
                icon: Icons.alternate_email,
              ),
              SizedBox(height: 20),
              AuthTextField(
                fillColor: AppColors.text.withOpacity(0.1),
                iconColor: AppColors.accent,
                keyboardType: TextInputType.text,
                labelText: 'Password',
                obscureText: true,
                icon: Icons.password,
              ),
              SizedBox(height: 30),
              MouseRegion(
                onHover: (event) {
                  setState(() {
                    color = AppColors.primary;
                  });
                },
                onExit: (event) {
                  setState(() {
                    color = AppColors.secondary;
                  });
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color ?? AppColors.secondary,
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
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don\'t have an account?",
                    style: TextStyle(color: AppColors.text),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgot_password');
                },
                child: Roboto(
                  text: "Forgot Your Password?",
                  color: AppColors.secondary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
