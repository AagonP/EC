import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/size_config.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   FoodDetailsScreen.routeName,
        //   arguments: FoodDetailsArguments(
        //     food: food,
        //   ),
        // );
        print(food.id);
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
                      Text(food.name),
                      Text("${food.price.toString()} VND"),
                    ],
                  ),
                ),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    food.image,
                    height: getProportionateScreenHeight(69),
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
