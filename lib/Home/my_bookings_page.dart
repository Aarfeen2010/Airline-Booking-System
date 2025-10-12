import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelex/Home/booking_summary_page.dart';
import 'package:travelex/colors.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList('bookings') ?? [];
    setState(() {
      bookings = stored.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Match app background
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.airplane_ticket, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No bookings yet.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                final flight = booking['flight'];
                final seat = booking['seat'];
                final status = booking['status'];

                // Color coding for status
                Color statusColor;
                switch (status.toString().toLowerCase()) {
                  case 'confirmed':
                    statusColor = Colors.greenAccent;
                    break;
                  case 'pending':
                    statusColor = Colors.orangeAccent;
                    break;
                  case 'cancelled':
                    statusColor = Colors.redAccent;
                    break;
                  default:
                    statusColor = Colors.white70;
                }

                return GestureDetector(
                  onTap: () {
  final flight = booking['flight'];
  final seatSelection = booking['seat'];
  final contactDetails = booking['contactDetails'];

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingSummaryPage(
        flight: flight,
        selectedSeat: seatSelection,
        contactDetails: contactDetails,
      ),
    ),
  );
},

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white, // Dark card color
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.flight_takeoff, color: AppColors.secondary, size: 32),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${flight['departure']} → ${flight['arrival']}',
                                style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Seat: $seat',
                                style:  TextStyle(color: AppColors.secondary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Status: $status',
                                style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
