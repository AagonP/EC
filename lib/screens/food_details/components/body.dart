import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/size_config.dart';
import '../../../helper/auth.dart';

import 'quantity_config.dart';
import 'food_description.dart';
import 'top_rounded_container.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatelessWidget {
  final Food food;

  const Body({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quantityConfig = QuantityConfig(food: food);
    return ListView(
      children: [
        Image.network(
          food.images[0],
          width: getProportionateScreenWidth(401),
          fit: BoxFit.fitWidth,
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
                    quantityConfig,
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
                          press: () async {
                            final uid = Provider.of<AuthenticationService>(
                                    context,
                                    listen: false)
                                .getUser()!
                                .uid;
                            if (!await isOrderCreated(uid)) {
                              await createOrder(uid);
                            }
                            addItemToCart(quantityConfig.quantity,
                                (food.id).toString(), food.price, uid);
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

  Future<void> createOrder(String uid) async {
    final order = FirebaseFirestore.instance.collection('orders');
    // Create new order for the user
    await order.doc(uid).set(
      {
        'total': '0.00',
        'expire_time': '',
      },
    ).catchError((error) => print("Failed to create order: $error"));
    await order.doc(uid).collection('foods').doc('no_item').set(
      {
        'no_item': '0',
      },
    ).catchError((error) => print("Failed to create order: $error"));
  }
}

Future<bool> isOrderCreated(String uid) async {
  bool isCreated = false;
  await FirebaseFirestore.instance.collection('orders').doc(uid).get().then(
    (DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Order is  already created
        isCreated = true;
      } else {
        isCreated = false;
      }
    },
  );
  return isCreated;
}

Future<void> addItemToCart(
    int quantity, String foodId, double foodPrice, String uid) async {
  // Food selected will be post to orders collection in Firestore
  // If the food item is not in the cart
  await FirebaseFirestore.instance.collection('orders').doc(uid).get().then(
    (DocumentSnapshot<Map> documentSnapshot) {
      final String new_total =
          (double.parse(documentSnapshot.data()!['total']) +
                  foodPrice * quantity)
              .toStringAsFixed(2);
      FirebaseFirestore.instance
          .collection('orders')
          .doc(uid)
          .update({'total': new_total});
    },
  );
  CollectionReference orders = FirebaseFirestore.instance
      .collection('orders')
      .doc(uid)
      .collection('foods');

  await orders.doc(foodId).get().then(
    (DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Food item already in cart
        final String new_amount =
            (int.parse(documentSnapshot['quantity']) + quantity).toString();
        orders.doc(foodId).update(
          {
            'quantity': new_amount,
          },
        ).catchError((error) => print("Failed to update item to cart: $error"));
      } else {
        // Set new documentID for new item
        orders.doc(foodId).set(
          {
            'quantity': quantity.toString(),
          },
        ).catchError((error) => print("Failed to add item to cart: $error"));
      }
    },
  );
  // Update total number of items
  await orders.doc('no_item').get().then((DocumentSnapshot documentSnapshot) {
    final String new_total_items =
        (int.parse(documentSnapshot['no_item']) + quantity).toString();
    orders.doc('no_item').update({
      'no_item': new_total_items,
    });
  });
}
