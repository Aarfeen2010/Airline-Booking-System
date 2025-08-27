import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travelex/Auth/create_password.dart';
import 'package:travelex/Auth/forgot_password_page.dart';
import 'package:travelex/Auth/login_page.dart';
import 'package:travelex/Auth/onboarding_screen.dart';
import 'package:travelex/Auth/otp_page.dart';
import 'package:travelex/Auth/signup_page.dart';
import 'package:travelex/Auth/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, Orientation, ScreenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: ForgotPasswordPage(),
        );
      },
    );
  }
}
