import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Auth/signup_page.dart';
import 'package:travelex/Widget/Auth/Login/appbar_widget.dart';
import 'package:travelex/Widget/Auth/Login/auth_text_field.dart';
import 'package:travelex/Widget/Auth/Login/elevated_button_widget.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppbarWidget(text: "Login"),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,

            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [Colors.white, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  "assets/images/aeroplane2.jpg",
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                    ElevatedButtonWidget(
                      buttonText: "Login",
                      snackbarText: 'Logged in successfully',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/homepage");
                      },
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
          ),
        ],
      ),
    );
  }
}
