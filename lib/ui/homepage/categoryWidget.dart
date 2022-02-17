import 'package:flutter/material.dart';
import 'package:mahevent/model/category.dart';
import 'package:mahevent/states.dart';
import 'package:mahevent/styles.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<States>(context);
    final isSelected = states.selectedCategory == category.id;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          states.updateCategory(category.id);
        }
      },
      child: Container(
        width: isSelected ? 100 : 80,
        height: isSelected ? 100 : 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35)),
          color: isSelected ? const Color(0xFFFFFFFF) : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              category.icon,
              color: isSelected
                  ? const Color.fromARGB(255, 232, 6, 104)
                  : Colors.white,
              size: isSelected ? 50 : 35,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              category.name,
              style: isSelected ? selectedCategoryTextStyle : categoryTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
