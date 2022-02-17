import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final IconData icon;

  Category({required this.id, required this.name, required this.icon});
}

final allCategory = Category(
  id: 0,
  name: "All",
  icon: Icons.pin_drop_outlined,
);

final techCategory = Category(
  id: 1,
  name: "Tech",
  icon: Icons.qr_code_2,
);
final designCategory = Category(
  id: 2,
  name: "Design",
  icon: Icons.brush_outlined,
);

final volunteerCategory = Category(
  id: 3,
  name: "Volunteer",
  icon: Icons.people_alt_outlined,
);

final musicCategory = Category(
  id: 4,
  name: "Music",
  icon: Icons.music_note,
);

final categories = [
  allCategory,
  techCategory,
  designCategory,
  volunteerCategory,
  musicCategory,
];
