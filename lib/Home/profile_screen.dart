import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelex/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    
                    // Replace with your image
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Aarfeen Khatri",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "aarfeen@travelex.com",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Info Cards
            _buildInfoTile(Icons.phone, "Phone Number", "+92 300 1234567"),
            _buildInfoTile(Icons.location_on, "Country", "Pakistan 🇵🇰"),
            _buildInfoTile(Icons.calendar_today, "Member Since", "July 2024"),

            const SizedBox(height: 25),

            // Settings Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingTile(Icons.lock, "Privacy & Security"),
            _buildSettingTile(Icons.notifications, "Notifications"),
            _buildSettingTile(Icons.help_outline, "Help & Support"),
            _buildSettingTile(Icons.logout, "Logout", isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey[600])),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isLogout ? Colors.red[50] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : AppColors.primary),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isLogout ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          if (isLogout) {
            // Add logout logic
          }
        },
      ),
    );
  }
}
