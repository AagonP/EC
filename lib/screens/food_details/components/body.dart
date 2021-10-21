import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/size_config.dart';

import 'quantity_config.dart';
import 'food_description.dart';
import 'top_rounded_container.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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
                          press: () {
                            addItemToCart();
                          },
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

void addItemToCart() {
  final uid = 'mock_user_id';
  final food_id = 'food_id';
  // Food selected will be post to orders collection in Firestore
  // If the food item is not in the cart
  CollectionReference orders = FirebaseFirestore.instance
      .collection('orders')
      .doc(uid)
      .collection('foods');
  orders.doc(food_id).get().then(
    (DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Food item already in cart
        final String new_amount =
            (int.parse(documentSnapshot['quanity']) + 1).toString();
        orders.doc(food_id).update(
          {
            'quanity': new_amount,
          },
        ).catchError((error) => print("Failed to update item to cart: $error"));
      } else {
        // Set new documentID for new item
        orders.doc(food_id).set(
          {
            'quanity': '1',
          },
        ).catchError((error) => print("Failed to add item to cart: $error"));
      }
    },
  );
  // Update total number of items
  orders.doc('no_item').get().then((DocumentSnapshot documentSnapshot) {
    final String new_total_items =
        (int.parse(documentSnapshot['no_item']) + 1).toString();
    orders.doc('no_item').update({
      'no_item': new_total_items,
    });
  });
}
