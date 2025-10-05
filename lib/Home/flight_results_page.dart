import 'package:flutter/material.dart';
class FlightResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> flights;

  const FlightResultsPage({super.key, required this.flights});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flight Results")),
      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return ListTile(
            title: Text("${flight['airline']} ${flight['flight_number']}"),
            subtitle: Text(
              "From: ${flight['departure']}\nTo: ${flight['arrival']}\nStatus: ${flight['status']}",
            ),
          );
        },
      ),
    );
  }
}
