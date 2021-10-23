import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/auth.dart';
import 'package:shop_app/models/Cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthenticationService>(context, listen: false)
        .getUser()!
        .uid;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return CheckoutCard(
            subtotal: data['total'],
            store_id: data['store_id'],
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
