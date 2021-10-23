import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/screens/food_details/food_details_screen.dart';

import 'package:shop_app/size_config.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({Key? key, required this.food, required this.store_id})
      : super(key: key);

  final Food food;
  final String store_id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          FoodDetailsScreen.routeName,
          arguments: FoodDetailsArguments(
            food: food,
            store_id: store_id,
          ),
        );
      },
      child: Column(
        children: [
          Divider(
            thickness: 0.6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: getProportionateScreenHeight(69),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("${food.price.toStringAsFixed(2)} VND"),
                    ],
                  ),
                ),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    food.images[0],
                    height: getProportionateScreenHeight(69),
                    width: getProportionateScreenWidth(69),
                    fit: BoxFit.fill,
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
