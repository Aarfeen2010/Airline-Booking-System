import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:travelex/Home/booking_screen.dart';
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
  int _selectedIndex = 0;

  Airport? selectedFromCity;
  Airport? selectedToCity;
  DateTime? selectedDate;
  int passengerCount = 1;

  final List<Airport> cities = [
  Airport(city: "New York", flag: "🇺🇸", name: "JFK Airport", code: "JFK"),
  Airport(city: "London", flag: "🇬🇧", name: "Heathrow", code: "LHR"),
  Airport(city: "Dubai", flag: "🇦🇪", name: "Dubai Intl", code: "DXB"),
  Airport(city: "Paris", flag: "🇫🇷", name: "Charles de Gaulle", code: "CDG"),
  Airport(city: "Karachi", flag: "🇵🇰", name: "Jinnah Intl", code: "KHI"),
  Airport(city: "Istanbul", flag: "🇹🇷", name: "Istanbul Airport", code: "IST"),
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
    final pages = [
      _HomeContent(
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
      const Center(child: Text("Flights Page")),
      const Center(child: Text("Offers Page")),
      const Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image.asset("assets/images/travelex_notext.png"),
            ),
            SizedBox(width: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Travelex',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: pages[_selectedIndex],
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
                      badgeColor: AppColors.accent,
                    ),
                    CarouselSlide(
                      image: "flight1.jpg",
                      badge: "20% off on International flights",
                      badgeColor: AppColors.secondary,
                    ),
                    CarouselSlide(
                      image: "dubai.jpg",
                      badge: "Special fare to Dubai",
                      badgeColor: Colors.pinkAccent,
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TopButtons(icon: Icons.flight_takeoff, label: "Book Now"),
                    TopButtons(icon: Icons.check_circle, label: "Check-in"),
                    TopButtons(icon: Icons.location_on, label: "Track Flight"),
                    TopButtons(icon: Icons.card_giftcard, label: "Offers"),
                  ],
                ),
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
                              text:
                                  widget.selectedDate == null
                                      ? ""
                                      : "${widget.selectedDate!.day}-${widget.selectedDate!.month}-${widget.selectedDate!.year}",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Passenger selector
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 8),
                          const Text("Passengers:"),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: widget.onRemovePassenger,
                          ),
                          Text(
                            widget.passengerCount.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: widget.onAddPassenger,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Travel Deals
          _HomeContent._sectionTitle("Travel Deals"),
          _HomeContent._horizontalDeals([
            GestureDetector(
  onTap: () {
    final dubai = widget.cities.firstWhere(
      (a) => a.city == "Dubai",
      orElse: () => widget.cities.first,
    );

    if (widget.fromCity != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingScreen(
            arrival: dubai,                // always Dubai for this deal
            departure: widget.fromCity!,   // user’s selected "From"
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
    city: "Dubai",
    price: "\$399",
    imagePath: "assets/flight1.jpg", // ⚠️ remove extra .jpg
  ),
),

            // _dealCard("Istanbul", "\$550", "assets/flight1.jpg.jpg"),
            // _dealCard("Maldives", "\$299", "assets/flight1.jpg.jpg"),
          ]),
          _HomeContent._sectionTitle("Top Picks for You"),
          // _horizontalDeals([
          //   _dealCard("Paris", "\$450", "assets/flight1.jpg"),
          //   _dealCard("Rome", "\$350", "assets/flight1.jpg.jpg"),
          // ]),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
 String city = city;

class DealCard extends StatefulWidget {
  final String city;
  final String price;
  final String imagePath;

  DealCard({required this.city, required this.price, required this.imagePath});
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
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
            leading: Text(city.flag!, style: const TextStyle(fontSize: 15)),
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
                  city.name!,
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

  TopButtons({required this.icon, required this.label});
  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },

          child: CircleAvatar(
            backgroundColor: isHovered ? AppColors.accent : AppColors.secondary,
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

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section with background image + overlay
            Stack(
              children: [
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/dubai_bg.jpg"), // your bg
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "DUBAI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "The City of Gold",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // Floating search card
                Positioned(
                  bottom: -40,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: ListTile(
                                  leading: Icon(Icons.flight_takeoff),
                                  title: Text("From"),
                                  subtitle: Text("New York"),
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.grey),
                              Expanded(
                                child: ListTile(
                                  leading: Icon(Icons.flight_land),
                                  title: Text("To"),
                                  subtitle: Text("Dubai"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Expanded(
                                child: ListTile(
                                  leading: Icon(Icons.calendar_today),
                                  title: Text("Date"),
                                  subtitle: Text("May 10"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text("Passengers"),
                                  subtitle: Text("1 Passenger"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                            label: const Text("Search Flights"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Flight Deals Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Flight Deals",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(
                        Icons.local_airport,
                        color: Colors.deepPurple,
                      ),
                      title: const Text("From \$320 — London to Dubai"),
                      subtitle: const Text("5h 30m, nonstop"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Top Attractions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Top Attractions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // _attractionCard("assets/burj.jpg", "Burj Khalifa"),
                  // _attractionCard("assets/desert.jpg", "Desert Safari"),
                  // _attractionCard("assets/marina.jpg", "Dubai Marina"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // About City
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "About the City",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Dubai is known for its modern architecture, luxury shopping — "
                    "and vibrant nightlife. Experience the futuristic skyline and "
                    "the unique blend of tradition and innovation.",
                    style: TextStyle(color: Colors.black87, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Hotels Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hotels",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                // child: Image.asset(
                //   "assets/atlantis.jpg",
                //   width: 60,
                //   height: 60,
                //   fit: BoxFit.cover,
                // ),
              ),
              title: const Text("Atlantis, The Palm"),
              subtitle: const Text("\$239 / night"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                // child: Image.asset(
                //   "assets/jumeirah.jpg",
                //   width: 60,
                //   height: 60,
                //   fit: BoxFit.cover,
                // ),
              ),
              title: const Text("Jumeirah"),
              subtitle: const Text("\$350 / night"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Reusable attraction card
  static Widget _attractionCard(String image, String title) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
