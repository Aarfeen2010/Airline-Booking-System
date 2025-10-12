import 'package:flutter/material.dart';
import 'package:travelex/Home/seat_selection.dart';
import 'package:travelex/colors.dart';

class ContactDetailsPage extends StatefulWidget {
  final Map<String, dynamic> flight;

  const ContactDetailsPage({super.key, required this.flight});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  String? nationality;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final contactDetails = {
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'postalCode': postalCodeController.text.trim(),
      'nationality': nationality,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SeatSelectionPage(
          flight: widget.flight,
          contactDetails: contactDetails,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flight == null) {
      return const Scaffold(
        body: Center(child: Text("❌ Flight data missing")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Contact Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // --- Name Fields ---
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration:
                          const InputDecoration(labelText: 'Last Name'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- Email ---
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) return 'Invalid email';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // --- Contact Number ---
              TextFormField(
                controller: phoneController,
                decoration:
                    const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (value.length < 10) return 'Invalid number';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // --- Postal Code ---
              TextFormField(
                controller: postalCodeController,
                decoration: const InputDecoration(labelText: 'Postal Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (value.length < 4) return 'Invalid postal code';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // --- Nationality ---
              DropdownButtonFormField<String>(
  decoration: const InputDecoration(labelText: 'Nationality'),
  value: nationality,
  items: [
    {'name': 'Pakistan', 'flag': '🇵🇰'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'UAE', 'flag': '🇦🇪'},
    {'name': 'USA', 'flag': '🇺🇸'},
  ].map((country) {
    return DropdownMenuItem<String>(
      value: country['name'],
      child: Row(
        children: [
          Text(country['flag']!, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Text(country['name']!),
        ],
      ),
    );
  }).toList(),
  onChanged: (value) => setState(() => nationality = value),
  validator: (value) =>
      value == null ? 'Please select nationality' : null,
),


              const SizedBox(height: 30),

              // --- Continue Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.secondary,
                  ),
                  child: const Text(
                    "Continue to Seat Selection",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
