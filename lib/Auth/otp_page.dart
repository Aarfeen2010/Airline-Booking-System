import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travelex/Auth/create_password.dart';
import 'package:travelex/Widget/Text/poppins.dart';
import 'package:travelex/colors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  final ValueNotifier<bool> _isOtpComplete = ValueNotifier(false);

  void _checkOtpFilled() {
    _isOtpComplete.value =
        _controllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _isOtpComplete.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Verification",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🔹 Background Image (same as Forgot Password)
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/aeroplane2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Dark gradient overlay
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // 🔹 Glassmorphic Card
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 🔸 Icon section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified_user_rounded,
                            size: 55,
                            color: AppColors.secondary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                    
                        // 🔸 Title
                        const Text(
                          "OTP Verification",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                    
                        const Text(
                          "Enter the 6-digit code sent to your email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 4.h),
                    
                        // 🔸 OTP Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (i) => _otpBox(i)),
                        ),
                        SizedBox(height: 5.h),
                    
                        // 🔸 Verify Button
                        ValueListenableBuilder<bool>(
                          valueListenable: _isOtpComplete,
                          builder: (_, isComplete, __) => AnimatedOpacity(
                            opacity: isComplete ? 1.0 : 0.6,
                            duration: const Duration(milliseconds: 250),
                            child: ElevatedButton(
                              onPressed: isComplete
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
                                minimumSize: Size(double.infinity, 6.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 4,
                              ),
                              child: Poppins(
                                text: "Verify OTP",
                                color: Colors.white,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                    
                        // 🔸 Resend Text
                        TextButton(
                          onPressed: () {
                            // resend logic
                          },
                          child: const Text(
                            "Didn’t receive code? Resend",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpBox(int index) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controllers[index],
      builder: (_, value, __) {
        final isFilled = value.text.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 10.w,
          height: 7.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isFilled ? 0.2 : 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isFilled ? AppColors.secondary : Colors.white30,
              width: 1.4,
            ),
            boxShadow: isFilled
                ? [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 0.8,
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            cursorColor: AppColors.secondary,
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              _checkOtpFilled();
            },
          ),
        );
      },
    );
  }
}
