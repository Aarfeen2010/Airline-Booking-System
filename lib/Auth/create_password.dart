import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:travelex/Home/home.dart';
import 'package:travelex/Widget/Text/poppins.dart';
import 'package:travelex/colors.dart';

class CreatePasswordPage extends StatefulWidget {
  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final ValueNotifier<bool> _isPasswordFilled = ValueNotifier(false);

  void _checkFields() {
    _isPasswordFilled.value = _passwordController.text.isNotEmpty &&
        _confirmController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    _isPasswordFilled.dispose();
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
          "Create Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🔹 Background Image
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

          // 🔹 Dark Gradient Overlay
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
                        // 🔸 Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_outline,
                            size: 55,
                            color: AppColors.secondary,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // 🔸 Title
                        const Text(
                          "Set New Password",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Enter your new password below",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 4.h),

                        // 🔸 Password Field
                        _passwordField(
                          controller: _passwordController,
                          label: "New Password",
                          obscure: _obscurePassword,
                          onToggle: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        SizedBox(height: 2.h),

                        // 🔸 Confirm Password Field
                        _passwordField(
                          controller: _confirmController,
                          label: "Confirm Password",
                          obscure: _obscureConfirmPassword,
                          onToggle: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        SizedBox(height: 5.h),

                        // 🔸 Reset Button
                        ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordFilled,
                          builder: (_, isFilled, __) => AnimatedOpacity(
                            opacity: isFilled ? 1.0 : 0.6,
                            duration: const Duration(milliseconds: 250),
                            child: ElevatedButton(
                              onPressed: isFilled
                                  ? () {
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) {
                                            return Home();
                                          },));
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
                                text: "Reset Password",
                                color: Colors.white,
                                fontSize: 17.sp,
                              ),
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

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      cursorColor: AppColors.secondary,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.secondary,
          ),
          onPressed: onToggle,
        ),
      ),
      onChanged: (_) => _checkFields(),
    );
  }
}
