import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:travelex/Home/flight_results_page.dart';
import 'package:travelex/Model/airport.dart';
import 'package:travelex/colors.dart';

class BookingScreen extends StatefulWidget {
  final Airport? departure;
  final Airport? arrival;
  final DateTime? selectedDate;

  const BookingScreen({super.key, this.departure, this.arrival, this.selectedDate});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
      bool isLoading = false;

  Airport? selectedDeparture;
  Airport? selectedArrival;
  DateTime? selectedDate;
  String? selectedClass = "economy";
  int kids = 0;
  int adults = 1;

  final List<String> classes = ["business", "economy", "first"];

  final List<Airport> airports = [
    Airport(city: "New York", flag: "🇺🇸", name: "JFK Airport", code: "JFK"),
    Airport(city: "London", flag: "🇬🇧", name: "Heathrow", code: "LHR"),
    Airport(city: "Dubai", flag: "🇦🇪", name: "Dubai Intl", code: "DXB"),
    Airport(city: "Paris", flag: "🇫🇷", name: "Charles de Gaulle", code: "CDG"),
    Airport(city: "Karachi", flag: "🇵🇰", name: "Jinnah Intl", code: "KHI"),
    Airport(city: "Istanbul", flag: "🇹🇷", name: "Istanbul Airport", code: "IST"),
    Airport(city: "Tokyo", flag: "🇯🇵", name: "Haneda", code: "HND"),
    Airport(code: "LHE", name: "Allama Iqbal International Airport", city: "Lahore", flag: "🇵🇰")
  ];

  @override
  void initState() {
    super.initState();
    selectedDeparture = widget.departure;
    selectedArrival = widget.arrival;
    selectedDate = widget.selectedDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  bool _validateBooking() {
    if (selectedDeparture == null || selectedArrival == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both departure and arrival.")),
      );
      return false;
    }

    if (selectedDeparture == selectedArrival) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Departure and arrival cannot be the same.")),
      );
      return false;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date.")),
      );
      return false;
    }

    return true;
  }

  Future<List<Map<String, dynamic>>> fetchFlights({
    required String depIata,
    required String arrIata,
    required String date,
    required int adults,
    required int kids,
    required String cabinClass,
  }) async {
    const apiKey = "YOUR-API-KEY";

    final url = Uri.parse(
        "https://api.flightapi.io/onewaytrip/$apiKey/$depIata/$arrIata/$date/$adults/$kids/0/$cabinClass/USD");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Server returned error ${response.statusCode}");
    }

    final body = response.body.trim();

    if (body.startsWith("error code")) {
      throw Exception("The flight server timed out. Please try again.");
    }

    dynamic data;
    try {
      data = json.decode(body);
    } catch (_) {
      throw Exception("Invalid response format from server.");
    }

    if (data is Map && data.containsKey('message')) {
      final msg = data['message'].toString().toLowerCase();
      if (msg.contains("wrong")) throw Exception("No flights found for this route.");
      throw Exception(data['message']);
    }

    if (data['itineraries'] == null || (data['itineraries'] as List).isEmpty) {
      throw Exception("No flights found for this route.");
    }

    final itineraries = data['itineraries'] as List;
    final legs = (data['legs'] ?? []) as List;
    final legMap = {for (var leg in legs) leg['id'].toString(): leg};

    final flights = itineraries.map<Map<String, dynamic>>((item) {
      final legId = (item['leg_ids'] != null && item['leg_ids'].isNotEmpty)
          ? item['leg_ids'][0].toString()
          : null;

      final leg = legId != null ? legMap[legId] : null;

      return {
        'airline': leg?['carriers']?[0]?['name'] ?? 'Unknown',
        'departure': leg?['departure_airport']?['display_code'] ?? depIata,
        'arrival': leg?['arrival_airport']?['display_code'] ?? arrIata,
        'price': item['pricing_options']?[0]?['price']?['amount'] ?? 'N/A',
        'status': 'Available',
      };
    }).toList();

    return flights;
  }

  Widget _buildCounter({
    required int count,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Row(
      children: [
        IconButton(onPressed: onRemove, icon: Icon(Icons.remove_circle, color: AppColors.secondary)),
        Text("$count", style: const TextStyle(color: Colors.black, fontSize: 16)),
        IconButton(onPressed: onAdd, icon: Icon(Icons.add_circle, color: AppColors.primary)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BuildField(
            label: "Departure",
            secondaryWidget: DropdownSearch<Airport>(
              items: (filter, _) => airports,
              selectedItem: selectedDeparture,
              itemAsString: (airport) => "${airport.city} - ${airport.name} (${airport.code})",
              compareFn: (a, b) => a.code == b.code,
              popupProps: const PopupProps.menu(showSearchBox: true),
              decoratorProps: const DropDownDecoratorProps(
                decoration: InputDecoration(hintText: "Select departure", border: InputBorder.none),
              ),
              onChanged: (airport) => setState(() => selectedDeparture = airport),
            ),
          ),
          BuildField(
            label: "Arrival",
            secondaryWidget: DropdownSearch<Airport>(
              items: (filter, _) => airports,
              selectedItem: selectedArrival,
              itemAsString: (airport) => "${airport.city} - ${airport.name} (${airport.code})",
              compareFn: (a, b) => a.code == b.code,
              popupProps: const PopupProps.menu(showSearchBox: true),
              decoratorProps: const DropDownDecoratorProps(
                decoration: InputDecoration(hintText: "Select arrival", border: InputBorder.none),
              ),
              onChanged: (airport) => setState(() => selectedArrival = airport),
            ),
          ),
          GestureDetector(
            onTap: () => _pickDate(context),
            child: BuildField(
              label: "Departure Date",
              secondaryWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedDate == null
                      ? ""
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          BuildField(
            label: "Passengers",
            secondaryWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Passengers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.black),
                    const SizedBox(width: 8),
                    const Text("Adults", style: TextStyle(color: Colors.black)),
                    const Spacer(),
                    _buildCounter(
                      count: adults,
                      onAdd: () => setState(() => adults++),
                      onRemove: () => setState(() { if (adults > 1) adults--; }),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.child_care, color: Colors.black),
                    const SizedBox(width: 8),
                    const Text("Kids", style: TextStyle(color: Colors.black)),
                    const Spacer(),
                    _buildCounter(
                      count: kids,
                      onAdd: () => setState(() => kids++),
                      onRemove: () => setState(() { if (kids > 0) kids--; }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          BuildField(
            label: "Class",
            secondaryWidget: DropdownSearch<String>(
              selectedItem: selectedClass,
              popupProps: const PopupProps.menu(showSearchBox: false),
              items: (filter, _) => classes,
              onChanged: (value) => setState(() => selectedClass = value ?? "economy"),
              decoratorProps: const DropDownDecoratorProps(decoration: InputDecoration(hintText: "Select a class")),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_validateBooking()) {
                try {
                  final flights = await fetchFlights(
                    adults: adults,
                    kids: kids,
                    cabinClass: selectedClass!,
                    depIata: selectedDeparture!.code,
                    arrIata: selectedArrival!.code,
                    date:
                        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
                  );

                  if (flights.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No flights found for this route")),
                    );
                    return;
                  } 
                  

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FlightResultsPage(flights: flights)),
                  );
                  setState(() {
                    isLoading = true;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Flights Not Found")),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              minimumSize: const Size(double.infinity, 50),
            ),
            child:Text("Search", style: TextStyle(fontSize: 16),)
          ),
        ],
      ),
    );

    // Wrap content in Scaffold only if not already inside a Scaffold
    return Scaffold(
      body: SafeArea(child: content),
    );
  }
}

class BuildField extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? secondaryWidget;

  const BuildField({required this.label, this.value, this.secondaryWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          secondaryWidget ?? Text(value ?? "", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
