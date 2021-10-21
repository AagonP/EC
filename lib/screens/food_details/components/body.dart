import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/size_config.dart';

import 'quantity_config.dart';
import 'food_description.dart';
import 'top_rounded_container.dart';

class Body extends StatelessWidget {
  final Food food;

  const Body({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          food.images[0],
          height: getProportionateScreenHeight(290),
          width: getProportionateScreenWidth(401),
          fit: BoxFit.fill,
        ),
        TopRoundedContainer(
          isRounded: false,
          topMargin: false,
          color: Colors.white,
          child: Column(
            children: [
              FoodDescription(
                food: food,
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    QuantityConfig(
                      food: food,
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
