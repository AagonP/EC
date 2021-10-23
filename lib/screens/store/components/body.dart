import 'package:flutter/material.dart';
import 'package:shop_app/models/Store.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/size_config.dart';
import 'store_title.dart';
import 'rounded_container.dart';
import 'food_list.dart';

class Body extends StatelessWidget {
  final Store store;
  final List<Food> foods;

  const Body({
    Key? key,
    required this.store,
    required this.foods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StoreTitle(store: store),
        SizedBox(
          height: getProportionateScreenHeight(78),
        ),
        RoundedContainer(
          color: Colors.white,
          child: FoodList(
            foods: foods,
            store_id: store.id,
          ),
        ),
      ],
    );
  }
}
