import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelex/Home/booking_screen.dart';
import 'package:travelex/Home/my_bookings_page.dart';
import 'package:travelex/Model/airport.dart';
import 'package:travelex/Widget/Home/HomeScreen/carousel_slide.dart';
import 'package:travelex/colors.dart';

class City {
  final String name;
  final String flag; // Can be emoji or image path

  City(this.name, this.flag);

  @override
  String toString() => name; // dropdown_search uses this by default
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;

  Airport? selectedFromCity;
  Airport? selectedToCity;
  DateTime? selectedDate;
  int passengerCount = 1;

  final List<Airport> cities = [
    Airport(city: "New York", flag: "🇺🇸", name: "JFK Airport", code: "JFK"),
    Airport(city: "London", flag: "🇬🇧", name: "Heathrow", code: "LHR"),
    Airport(city: "Dubai", flag: "🇦🇪", name: "Dubai Intl", code: "DXB"),
    Airport(
        city: "Paris", flag: "🇫🇷", name: "Charles de Gaulle", code: "CDG"),
    Airport(city: "Karachi", flag: "🇵🇰", name: "Jinnah Intl", code: "KHI"),
    Airport(
        city: "Istanbul", flag: "🇹🇷", name: "Istanbul Airport", code: "IST"),
    Airport(city: "Tokyo", flag: "🇯🇵", name: "Haneda", code: "HND"),
  ];

  Future<void> _selectDate(BuildContext context) async {
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

  void _incrementPassenger() => setState(() => passengerCount++);
  void _decrementPassenger() {
    if (passengerCount > 1) {
      setState(() => passengerCount--);
    }
  }

  @override
  Widget build(BuildContext context) {
    

    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        child:_HomeContent(
        fromCity: selectedFromCity,
        toCity: selectedToCity,
        onFromChanged: (val) => setState(() => selectedFromCity = val),
        onToChanged: (val) => setState(() => selectedToCity = val),
        onDateTap: () => _selectDate(context),
        selectedDate: selectedDate,
        passengerCount: passengerCount,
        onAddPassenger: _incrementPassenger,
        onRemovePassenger: _decrementPassenger,
        cities: cities,
      ),
      ),
      
    );
  }
}

/// ---------------------------
/// Home Content Widget
/// ---------------------------
class _HomeContent extends StatefulWidget {
  final Airport? fromCity;
  final Airport? toCity;
  final ValueChanged<Airport?> onFromChanged;
  final ValueChanged<Airport?> onToChanged;
  final VoidCallback onDateTap;
  final DateTime? selectedDate;
  final int passengerCount;
  final VoidCallback onAddPassenger;
  final VoidCallback onRemovePassenger;
  final List<Airport> cities;

  const _HomeContent({
    required this.fromCity,
    required this.toCity,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onDateTap,
    required this.selectedDate,
    required this.passengerCount,
    required this.onAddPassenger,
    required this.onRemovePassenger,
    required this.cities,
  });

  @override
  State<_HomeContent> createState() => _HomeContentState();

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
    );
  }

  static Widget _horizontalDeals(List<Widget> cards) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: cards,
      ),
    );
  }
}

class _HomeContentState extends State<_HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   filterQuality: FilterQuality.high,

              //   image: AssetImage("assets/images/cloud.jpg"),
              // ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Offer Box
                CarouselSlider(
                  items: [
                    CarouselSlide(
                      image: "hajj.jpg",
                      badge: "Hajj and Umrah packages",
                      badgeColor: AppColors.primary,
                    ),
                    CarouselSlide(
                      image: "flight1.jpg",
                      badge: "20% off on International flights",
                      badgeColor: AppColors.primary,
                    ),
                    CarouselSlide(
                        image: "dubai.jpg",
                        badge: "Special fare to Dubai",
                        badgeColor: AppColors.primary),
                  ],
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                  ),
                ),
                const SizedBox(height: 16),

                // Buttons row
                
                const SizedBox(height: 20),

                // Modern Search flight box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Side by side From & To
                      Row(
                        children: [
                          Expanded(
                            child: CityDropdown(
                              label: "From",
                              icon: Icons.flight_takeoff,
                              items: widget.cities,
                              selectedItem: widget.fromCity,
                              onChanged: widget.onFromChanged,
                            ),
                          ),
                          SizedBox(width: 6),
                          // Swap button
                          GestureDetector(
                            onTap: () {
                              final temp = widget.fromCity;
                              widget.onFromChanged(widget.toCity);
                              widget.onToChanged(temp);
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xff1E90FF),
                              child: const Icon(
                                Icons.swap_horiz,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),

                          Expanded(
                            child: CityDropdown(
                              label: "To",
                              icon: Icons.flight_land,
                              items: widget.cities,
                              selectedItem: widget.toCity,
                              onChanged: widget.onToChanged,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Date Picker
                      GestureDetector(
                        onTap: widget.onDateTap,
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.calendar_today),
                              labelText: "Departure Date",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: TextEditingController(
                              text: widget.selectedDate == null
                                  ? ""
                                  : "${widget.selectedDate!.day}-${widget.selectedDate!.month}-${widget.selectedDate!.year}",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
  onPressed: () {
    if (widget.fromCity != null && widget.toCity != null && widget.selectedDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BookingScreen(
            departure: widget.fromCity,
            arrival: widget.toCity,
            selectedDate: widget.selectedDate,
            
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select all fields")),
      );
    }
  },
  child: Text("Search Flights"),
)


                      // Passenger selector
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Travel Deals
          _HomeContent._sectionTitle("Travel Deals"),
          _HomeContent._horizontalDeals([
            _travelDeals("Dubai", "assets/images/dubai.jpg"),
            _travelDeals("Karachi",  "assets/images/karachi.jpg"),
            _travelDeals("New York", "assets/images/new_york.jpg")

          ]),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
  Widget _travelDeals(String cityName, String imgPath) {
    return GestureDetector(
              onTap: () {
                final dubai = widget.cities.firstWhere(
                  (a) => a.city == cityName,
                  orElse: () => widget.cities.first,
                );

                if (widget.fromCity != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(
                        arrival: dubai, // always Dubai for this deal
                        departure: widget.fromCity!, // user’s selected "From"
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select your departure city first"),
                    ),
                  );
                }
              },
              child: DealCard(
                city: cityName,
                imagePath: imgPath, // ⚠️ remove extra .jpg
              ),
            );
  }
}

String city = city;

class DealCard extends StatefulWidget {
  final String city;
  final String imagePath;

  const DealCard({super.key, required this.city,  required this.imagePath});
  @override
  State<DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.15),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.city,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------
/// Dropdown Widget
/// ---------------------------
class CityDropdown extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Airport> items;
  final Airport? selectedItem;
  final ValueChanged<Airport?>? onChanged;

  const CityDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<Airport> cities = [
      Airport(city: "New York", flag: "🇺🇸", name: "JFK airport", code: "JFK"),
      Airport(
        city: "London",
        flag: "🇬🇧",
        name: "London airport",
        code: "LAP",
      ),
      Airport(
        city: "Dubai",
        flag: "🇦🇪",
        name: "Dubai international airport",
        code: "DIP",
      ),
      Airport(
        city: "Paris",
        flag: "🇫🇷",
        name: "Paris France Air",
        code: "PFA",
      ),
      Airport(
        city: "Karachi",
        flag: "🇵🇰",
        name: "karachi international airport",
        code: "KIA",
      ),
      Airport(
        city: "Istanbul",
        flag: "🇹🇷",
        name: "Istanbul airport",
        code: "IFK",
      ),
      Airport(city: "Tokyo", flag: "🇯🇵", name: "Tokyo Japan", code: "TJK"),
      Airport(
          code: "LHE",
          name: "Allama Iqbal International Airport",
          city: "Lahore",
          flag: "🇵🇰")
    ];

    return DropdownSearch<Airport>(
      compareFn: (Airport? a, Airport? b) => a?.name == b?.name,
      items: (filter, loadProps) {
        return items;
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        itemBuilder: (context, city, isSelected, isDisabled) {
          return ListTile(
            leading: Text(city.flag, style: const TextStyle(fontSize: 15)),
            // Or Image.asset(city.flag, width: 30) if you want PNG/SVG flags
            title: Text(
              "${city.city} - ${city.name}",
              style: TextStyle(fontSize: 16, overflow: TextOverflow.visible),
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
            subtitle: Text(city.code),
          );
        },
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      dropdownBuilder: (context, city) {
        if (city == null) return Text(label, overflow: TextOverflow.visible);
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                  city.name,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        );
      },
      selectedItem: selectedItem,
      onChanged: onChanged,
    );
  }
}

class TopButtons extends StatefulWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const TopButtons({super.key, required this.icon, required this.label, this.onTap});
  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: CircleAvatar(
            backgroundColor: AppColors.secondary,
            child: Icon(widget.icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}




