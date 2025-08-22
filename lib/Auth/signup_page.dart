import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Auth/login_page.dart';
import 'package:travelex/Widget/Auth/Login/auth_text_field.dart';
import 'package:travelex/Widget/Text/roboto.dart';
import 'package:travelex/colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 23),
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
                'Create Account',
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
              SizedBox(height: 20),
              AuthTextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                labelText: "First Name",
                iconColor: AppColors.accent,
                fillColor: AppColors.text.withOpacity(0.1),
                icon: Icons.account_circle,
              ),
              SizedBox(height: 20),
              AuthTextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                labelText: "Last Name",
                iconColor: AppColors.accent,
                fillColor: AppColors.text.withOpacity(0.1),
                icon: Icons.person_outline,
              ),
              SizedBox(height: 50),
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
                      SnackBar(content: Text('Account created successfully')),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: AppColors.text),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/forgot_password');
                },

                child: Roboto(
                  text: "Forgot Your Password?",
                  fontSize: 14,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
