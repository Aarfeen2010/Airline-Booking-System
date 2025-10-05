import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:travelex/Home/flight_results_page.dart';
import 'package:travelex/Model/airport.dart';
import 'package:travelex/colors.dart';

class BookingScreen extends StatefulWidget {
  final Airport? departure;
  final Airport? arrival;

  const BookingScreen({super.key, this.departure, this.arrival});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Airport? selectedDeparture;
  Airport? selectedArrival;
  DateTime? selectedDate;
  String? selectedClass = "economy";

  
  final List<String> classes = [
    "business",
    "economy", 
    "ac class"
  ];
  int kids = 0;
    int adults = 1;
    Future<void> _pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(), // default to today
    firstDate: DateTime.now(),                   // no past dates
    lastDate: DateTime(2100),                    // max limit
  );

  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
    });
  }
}

bool _validateBooking() {
  if (selectedDeparture == null || selectedArrival == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select both departure and arrival.")),
    );
    return false;
  }

  if (selectedDeparture == selectedArrival) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Departure and arrival cannot be the same.")),
    );
    return false;
  }

  if (selectedDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select a date.")),
    );
    return false;
  }
  
  return true;
  
  

  // ✅ If valid
  //Show all the flight results

}
Future<List<Map<String, dynamic>>> fetchFlights({
  required String depIata,
  required String arrIata,
  required String date,
  required int adults,
  required int kids,
  required String cabinClass,
}) async {
  final apiKey = "68de9fee0bd7c525da77e478";

  final url = Uri.parse(
    "https://api.flightapi.io/onewaytrip/$apiKey/$depIata/$arrIata/$date/$adults/USD/${cabinClass.toLowerCase()}/$kids/0",
  );
  print("🔗 Fetching: $url");

  final response = await http.get(url);
  print("📩 Response: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['flights'] == null && data['legs'] == null) {
      throw Exception("API response missing flight data: $data");
    }

    final List flights = data['legs'] ?? data['flights'];
    return flights.map((f) => {
      'airline': f['airline']?['name'] ?? "Unknown",
      'flight_number': f['flight']?['number'] ?? "N/A",
      'departure': f['departure']?['scheduledTimeLocal'] ?? "N/A",
      'arrival': f['arrival']?['scheduledTimeLocal'] ?? "N/A",
      'status': f['status'] ?? "N/A",
    }).toList();
  } else {
    throw Exception("Failed to fetch flights: ${response.statusCode} ${response.reasonPhrase}");
  }
}




final List<Airport> airports = [
  Airport(city: "New York", flag: "🇺🇸", name: "JFK Airport", code: "JFK"),
  Airport(city: "London", flag: "🇬🇧", name: "Heathrow", code: "LHR"),
  Airport(city: "Dubai", flag: "🇦🇪", name: "Dubai Intl", code: "DXB"),
  Airport(city: "Paris", flag: "🇫🇷", name: "Charles de Gaulle", code: "CDG"),
  Airport(city: "Karachi", flag: "🇵🇰", name: "Jinnah Intl", code: "KHI"),
  Airport(city: "Istanbul", flag: "🇹🇷", name: "Istanbul Airport", code: "IST"),
  Airport(city: "Tokyo", flag: "🇯🇵", name: "Haneda", code: "HND"),
];
    @override
  void initState() {
selectedArrival = widget.arrival;
selectedDeparture = widget.departure;
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Book a Flight")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BuildField(
  label: "Departure",
  secondaryWidget: DropdownSearch<Airport>(
    items: (filter, loadProps) {
      return airports;
    },
    selectedItem: selectedDeparture,
    itemAsString: (airport) => "${airport.city} - ${airport.name} (${airport.code})",
    compareFn: (a, b) => a.code == b.code, // required for custom objects
    popupProps: const PopupProps.menu(showSearchBox: true),
    decoratorProps: const DropDownDecoratorProps(
      decoration: InputDecoration(
        hintText: "Select departure",
        border: InputBorder.none,
      ),
    ),
    onChanged: (airport) {
      setState(() => selectedDeparture = airport);
    },
  ),
),

BuildField(
  label: "Arrival",
  secondaryWidget: DropdownSearch<Airport>(
    items: (filter, loadProps) {
      return airports;
    },
    selectedItem: selectedArrival,
    itemAsString: (airport) => "${airport.city} - ${airport.name} (${airport.code})",
    compareFn: (a, b) => a.code == b.code,
    popupProps: const PopupProps.menu(showSearchBox: true),
    decoratorProps: const DropDownDecoratorProps(
      decoration: InputDecoration(
        hintText: "Select arrival",
        border: InputBorder.none,
      ),
    ),
    onChanged: (airport) {
      setState(() => selectedArrival = airport);
    },
  ),
),

              GestureDetector(
                onTap: () {
                  _pickDate(context);
                },
                child: BuildField(label:"Departure Date", 
                secondaryWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedDate == null ? "" :
                "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                Icon(Icons.calendar_today)
                  ],
                ),
                ),
              ),
              BuildField(
                label:"Passengers",
                secondaryWidget:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Passengers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Adults Row
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.black),
                        const SizedBox(width: 8),
                        const Text(
                          "Adults",
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        _buildCounter(
                          count: adults,
                          onAdd: () => setState(() => adults++),
                          onRemove: () {
                            if (adults > 1) {
                              setState(() => adults--);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Kids Row
                    Row(
                      children: [
                        const Icon(Icons.child_care, color: Colors.black),
                        const SizedBox(width: 8),
                        const Text(
                          "Kids",
                          style: TextStyle(color: Colors.black),
                        ),
                        const Spacer(),
                        _buildCounter(
                          count: kids,
                          onAdd: () => setState(() => kids++),
                          onRemove: () {
                            if (kids > 0) {
                              setState(() => kids--);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BuildField(
                
                
                label:"Class", 
              secondaryWidget: DropdownSearch<String>(
                selectedItem: selectedClass,
                popupProps: PopupProps.menu(
                  showSearchBox: false,
                  
                ),
                items: (filter, loadProps) {
                  return classes;
                },
                onChanged: (value) {
                  setState(() {
                    selectedClass = value ?? "economy";
                  });
                },
                
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    hintText: "Select a class",
                    
                  )
                ) ,
                
                
              ),),
              const SizedBox(height: 20),
              ElevatedButton(
  onPressed: () async {
    if (_validateBooking()) {
     final flights = await fetchFlights(
      adults: adults,
      kids: kids,
      cabinClass: selectedClass!,
      depIata: selectedDeparture!.code,
      arrIata: selectedArrival!.code,
      date: "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2,'0')}-${selectedDate!.day.toString().padLeft(2,'0')}",
      );

      if (flights.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No flights found for this route")),
        );
        return; // 👈 important
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FlightResultsPage(flights: flights),
        ),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green[900],
    minimumSize: const Size(double.infinity, 50),
  ),
  child: const Text("Search", style: TextStyle(fontSize: 16)),
)

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounter({
    required int count,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Row(
      children: [
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
        ),
        Text(
          "$count",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
        ),
      ],
    );
  }
}

class BuildField extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? secondaryWidget;

  BuildField({required this.label,  this.value, this.secondaryWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          secondaryWidget ?? Text(value ?? "", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}


