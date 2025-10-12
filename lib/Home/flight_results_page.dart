import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Home/flight_detail_page.dart';
import 'package:travelex/colors.dart';

class FlightResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> flights;

  const FlightResultsPage({super.key, required this.flights});

  @override
  Widget build(BuildContext context) {
    String formatTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString).toLocal(); // converts UTC → your timezone
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}
final uniqueFlights = flights.where((flight) {
  final duplicate = flights.indexWhere((f) =>
      f['airline'] == flight['airline'] &&
      f['departTime'] == flight['departTime'] &&
      f['arriveTime'] == flight['arriveTime'] &&
      f['departure'] == flight['departure'] &&
      f['arrival'] == flight['arrival']);
  return flights.indexOf(flight) == duplicate;
}).toList();


    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Results"),
        backgroundColor: AppColors.primary,
      ),
      body: flights.isEmpty
          ? const Center(
              child: Text(
                "No flights found.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: uniqueFlights.length,
              itemBuilder: (context, index) {
                    if (index >= flights.length) return SizedBox(); // prevent RangeError

  final flight = uniqueFlights[index];
                final airline = flight['airline'] ?? "Unknown Airline";
                final origin = flight['departure']?.toString() ?? "N/A";
                final destination = flight['arrival']?.toString() ?? "N/A";
               
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: FlightDetailPage(flight: flight)));
                  },
                  child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left section (Flight info)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  Text(
                    airline.isEmpty ? "Unknown Airline" : airline,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                       Icon(LucideIcons.planeTakeoff, size: 16, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text("$origin → $destination",
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 4),
                                 Row(
                    children: [
                       Icon(Icons.access_time, size: 16, color: AppColors.secondary),
                      const SizedBox(width: 6),
                      Text(
                        "${formatTime(flight["departTime"] ?? "2025-10-10T10:30:00Z")} → ${formatTime(flight["arriveTime"] ?? "2025-10-10T20:15:00Z")}",
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                  
                                ],
                              ),
                  
                              // Right section (Price + icon)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "\$${flight["price"]}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Icon(LucideIcons.plane, color: Colors.purple, size: 22),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                );



              },
            ),
    );
  }
}
