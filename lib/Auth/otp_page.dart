import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Auth/create_password.dart';
import 'package:travelex/Auth/splash_screen.dart';
import 'package:travelex/Widget/Auth/Login/appbar_widget.dart';
import 'package:travelex/Widget/Auth/Login/auth_text_field.dart';
import 'package:travelex/Widget/Auth/Login/elevated_button_widget.dart';
import 'package:travelex/Widget/Text/poppins.dart';
import 'package:travelex/colors.dart';

class OtpPage extends StatefulWidget {
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  void _checkOtpFilled() {
    setState(() {
      isOtpComplete = _controllers.every(
        (controller) => controller.text.isNotEmpty,
      );
    });
  }

  bool isOtpComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Card(
              margin: EdgeInsets.all(24),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Poppins(
                      text: "Verification",
                      color: AppColors.text,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    Text(
                      'Enter the 6-digit OTP sent to your email',
                      style: TextStyle(fontSize: 18, color: AppColors.text),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => _otpTextField(context, index),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          isOtpComplete
                              ? () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: CreatePasswordPage(),
                                  ),
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Poppins(
                        text: "Verify OTP",
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
          _checkOtpFilled();
        },
      ),
    );
  }
}
