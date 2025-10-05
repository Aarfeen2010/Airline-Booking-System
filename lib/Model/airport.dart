class Airport {
  final String code;
  final String name;
  final String city;
  final String flag;

  Airport({ required this.code,  required this.name,   required this.city,  required this.flag});

  @override
  String toString() => "$city - $name ($code)";
}
