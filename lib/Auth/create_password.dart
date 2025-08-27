import 'package:flutter/material.dart';
import 'package:travelex/Widget/Auth/Login/appbar_widget.dart';
import 'package:travelex/Widget/Auth/Login/auth_text_field.dart';
import 'package:travelex/Widget/Auth/Login/elevated_button_widget.dart';
import 'package:travelex/Widget/Text/roboto.dart';
import 'package:travelex/colors.dart';

class CreatePasswordPage extends StatefulWidget {
  @override
  _CreatePasswordPageState createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 12,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: EdgeInsets.all(24),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Roboto(
                    text: "Enter New Password",
                    color: AppColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    labelText: "New Password",
                    iconColor: AppColors.accent,
                    icon: Icons.password,
                    fillColor: AppColors.background.withOpacity(0.1),
                    borderRadius: 20,
                    labelColor: AppColors.text,
                    textColor: AppColors.text,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    labelText: "Confirm Password",
                    iconColor: AppColors.accent,
                    icon: Icons.lock,
                    fillColor: AppColors.background.withOpacity(0.1),
                    borderRadius: 20,
                    labelColor: AppColors.text,
                    textColor: AppColors.text,
                  ),
                  SizedBox(height: 20),
                  ElevatedButtonWidget(
                    buttonText: "Reset Password",
                    snackbarText: "Password reset successfully",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/homepage");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
