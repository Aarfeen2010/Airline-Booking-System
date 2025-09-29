import 'package:flutter/material.dart';
import 'package:travelex/Model/airport.dart';

class BookingScreen extends StatefulWidget {
  final Airport? departure;
  final Airport? arrival;

  const BookingScreen({super.key, this.departure, this.arrival});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    int kids = 0;
    int adults = 1;
    return Scaffold(
      appBar: AppBar(title: const Text("Book a Flight")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildField(
                "Departure",
                "${widget.departure!.city} - ${widget.departure!.name} (${widget.departure!.code})",
              ),
              _buildField(
                "Arrival",
                "${widget.arrival!.city} - ${widget.arrival!.name} (${widget.arrival!.code})",
              ),
              _buildField("Departure Date", "Thu, 02 Oct"),
              _buildField(
                "Passengers",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Passengers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Adults Row
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          "Adults",
                          style: TextStyle(color: Colors.white),
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
                        const Icon(Icons.child_care, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          "Kids",
                          style: TextStyle(color: Colors.white),
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
              _buildField("Class", "Economy"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Do search
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Search", style: TextStyle(fontSize: 16)),
              ),
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
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
        ),
      ],
    );
  }
}

class BuildField extends StatefulWidget {
  final String label;
  final String value;
  final Widget? secondaryWidget;

  BuildField({required this.label, required this.value, this.secondaryWidget});

  @override
  State<BuildField> createState() => _BuildFieldState();
}

class _BuildFieldState extends State<BuildField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(widget.value ?? .secondaryWidget, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
