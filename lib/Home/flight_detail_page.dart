import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Home/contact_detail.dart';
import 'package:travelex/colors.dart';

class FlightDetailPage extends StatefulWidget {
  final Map<String, dynamic> flight;

  const FlightDetailPage({super.key, required this.flight});

  @override
  State<FlightDetailPage> createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  @override
  Widget build(BuildContext context) {
    String formatTime(String? dateTimeString) {
      if (dateTimeString == null || dateTimeString.isEmpty) return "N/A";
      final dateTime = DateTime.parse(dateTimeString).toLocal();
      final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    }

    final flight = widget.flight;

    final airline = flight['airline'] ?? "Unknown Airline";
    final origin = flight['departure']?.toString() ?? "N/A";
    final destination = flight['arrival']?.toString() ?? "N/A";
    final price = flight['price']?.toString() ?? "N/A";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Details"),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airline Header
              Center(
                child: Column(
                  children: [
                    Icon(LucideIcons.plane, size: 48, color: AppColors.secondary),
                    const SizedBox(height: 8),
                    Text(
                      airline,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Flight ${flight['flightNumber'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Flight Timing Section
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(formatTime(flight["departTime"]),
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(origin),
                            ],
                          ),
                          Icon(LucideIcons.arrowRight, color: AppColors.primary),
                          Column(
                            children: [
                              Text(formatTime(flight['arriveTime']),
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(destination),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      const Text("Duration: 4h 45m • Non-stop",
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Flight Info Card
              _infoCard({
                'Date': flight['departTime'] != null
                    ? "${DateTime.parse(flight['departTime']).toLocal().day}-${DateTime.parse(flight['departTime']).toLocal().month}-${DateTime.parse(flight['departTime']).toLocal().year}"
                    : 'N/A',
                'Departure Airport': origin,
                'Arrival Airport': destination,
                'Airline': airline,
                'Flight Number': flight['flightNumber']?.toString() ?? 'N/A',
                'Price': "\$$price",
              }),

              const SizedBox(height: 20),

              // Price Summary
              _infoCard({
                'Base Fare': '\$${flight["baseFare"] ?? price}',
                'Taxes & Fees': '\$${flight["taxes"] ?? "0"}',
                'Total Price': '\$${flight["totalPrice"] ?? price}',
              }),

              const SizedBox(height: 30),

              // Book Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    print("➡️ Sending flight data to contact page: ${widget.flight}");
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ContactDetailsPage(flight: widget.flight),
                      ),
                    );
                  },
                  child: const Text(
                    "Book This Flight",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(Map<String, String> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: data.entries
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500)),
                        Text(e.value,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
