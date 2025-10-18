import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Home/booking_summary_page.dart';
import 'package:travelex/Home/payment_screen.dart';

class SeatSelectionPage extends StatefulWidget {
  final Map<String, dynamic> flight;
  final Map<String, dynamic> contactDetails;

  const SeatSelectionPage({super.key, required this.flight, required this.contactDetails});

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  String? selectedSeat;

  // Example seat layout (A–F, 10 rows)
  final List<String> seatLetters = ['A', 'B', 'C', 'D', 'E', 'F'];
  final int totalRows = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Seat'),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Choose your preferred seat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
        
              // Airplane front indicator
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Cockpit',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 20),
        
              // Seat Grid
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(totalRows, (rowIndex) {
                      int rowNumber = rowIndex + 1;
        
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left Side (A, B, C)
                            ...seatLetters.sublist(0, 3).map((letter) {
                              String seatId = '$letter$rowNumber';
                              return _buildSeat(seatId);
                            }),
        
                            const SizedBox(width: 25), // Aisle space
        
                            // Right Side (D, E, F)
                            ...seatLetters.sublist(3, 6).map((letter) {
                              String seatId = '$letter$rowNumber';
                              return _buildSeat(seatId);
                            }),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
        
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _legendBox(Colors.grey.shade300, 'Available'),
                  const SizedBox(width: 15),
                  _legendBox(Colors.indigo, 'Selected'),
                  const SizedBox(width: 15),
                  _legendBox(Colors.red.shade300, 'Booked'),
                ],
              ),
        
              const SizedBox(height: 25),
        
              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedSeat == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
    builder: (_) => PaymentPage(flight: widget.flight, contactDetails: widget.contactDetails, selectedSeat: selectedSeat!)
  ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    selectedSeat == null
                        ? 'Select a Seat to Continue'
                        : 'Continue with Seat $selectedSeat',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeat(String seatId) {
    // Example of booked seats (you can fetch from API)
    final List<String> bookedSeats = ['A3', 'B4', 'C5', 'D2'];

    bool isBooked = bookedSeats.contains(seatId);
    bool isSelected = selectedSeat == seatId;

    Color seatColor;
    if (isBooked) {
      seatColor = Colors.red.shade300;
    } else if (isSelected) {
      seatColor = Colors.indigo;
    } else {
      seatColor = Colors.grey.shade300;
    }

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              setState(() {
                selectedSeat = seatId;
              });
            },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            seatId,
            style: TextStyle(
              color: isBooked ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _legendBox(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
