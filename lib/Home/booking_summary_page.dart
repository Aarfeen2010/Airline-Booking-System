import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelex/Home/home.dart';
import 'package:travelex/colors.dart';

class BookingSummaryPage extends StatelessWidget {
  final Map<String, dynamic> flight;
  final Map<String, dynamic> contactDetails;
  final String selectedSeat;

  const BookingSummaryPage({
    super.key,
    required this.flight,
    required this.contactDetails,
    required this.selectedSeat,
  });

  Future<void> _saveBooking(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final booking = {
      'flight': flight,
      'contactDetails': contactDetails,
      'seat': selectedSeat,
      'status': 'Pending',
      'timestamp': DateTime.now().toString(),
    };

    List<String> existingBookings = prefs.getStringList('bookings') ?? [];
    existingBookings.add(jsonEncode(booking));
    await prefs.setStringList('bookings', existingBookings);

    // ✅ Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Booking confirmed! E-ticket will be emailed shortly.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );

    // ✅ Navigate to Home after short delay
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) =>  Home()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Booking Summary'),
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _sectionTitle('✈️ Flight Information'),
            _infoCard([
              _infoRow(Icons.flight_takeoff, 'From', flight["from"] ?? "Unknown"),
              _infoRow(Icons.flight_land, 'To', flight["to"] ?? "Unknown"),
              _infoRow(Icons.calendar_today, 'Date', flight["date"] ?? "N/A"),
              _infoRow(Icons.airline_seat_recline_normal, 'Class', flight["class"] ?? "Economy"),
            ]),

            const SizedBox(height: 20),
            _sectionTitle('👤 Contact Details'),
            _infoCard([
              _infoRow(Icons.person, 'Name',
                  "${contactDetails["firstName"] ?? ""} ${contactDetails["lastName"] ?? ""}"),
              _infoRow(Icons.email, 'Email', contactDetails["email"] ?? "N/A"),
              _infoRow(Icons.phone, 'Phone', contactDetails["phone"] ?? "N/A"),
              _infoRow(Icons.location_on, 'Postal Code', contactDetails["postalCode"] ?? "N/A"),
              _infoRow(Icons.flag, 'Nationality', contactDetails["nationality"] ?? "N/A"),
            ]),

            const SizedBox(height: 20),
            _sectionTitle('🪑 Seat Selection'),
            _infoCard([
              _infoRow(Icons.event_seat, 'Selected Seat', selectedSeat),
            ]),

            const SizedBox(height: 40),

            // ✅ Confirm Button
            ElevatedButton.icon(
              onPressed: () => _saveBooking(context),
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              label: const Text(
                'Confirm Booking',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Helper Widgets ----

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
