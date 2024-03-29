import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import 'food_tile.dart';

import '../../../size_config.dart';

class FoodList extends StatelessWidget {
  const FoodList({
    Key? key,
    required this.foods,
  }) : super(key: key);

  final List<Food> foods;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            "Menu",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...List.generate(
          foods.length,
          (index) => FoodTile(
            food: foods[index],
          ),
        ),
      ],
    );
  }
}
