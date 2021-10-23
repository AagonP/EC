import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/auth.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Food.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

List<int> quanities = [];

Future<List<Food>> queryFoodInCart(String uid) async {
  List<Food> foods = [];
  List<String> food_ids = [];
  quanities = [];
  await FirebaseFirestore.instance
      .collection('orders')
      .doc(uid)
      .collection('foods')
      .get()
      .then((QuerySnapshot<Map> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      if (doc.id != 'no_item') {
        food_ids.add(doc.id);
        quanities.add(int.parse(doc.data()['quantity']));
      }
    });
  });

  await Future.forEach(food_ids, (item) async {
    await FirebaseFirestore.instance
        .collection('foods')
        .doc(item.toString())
        .get()
        .then((DocumentSnapshot<Map> documentSnapshot) {
      if (documentSnapshot.exists) {
        final id = documentSnapshot.id;
        final description = documentSnapshot.data()!['description'];
        final List<String> images = [documentSnapshot.data()!['imageURL']];
        final price = documentSnapshot.data()!['price'];
        final title = documentSnapshot.data()!['title'];
        foods.add(Food(
          id: id,
          description: description,
          images: images,
          price: double.parse(price.toString()),
          title: title,
        ));
      }
    });
  });
  return foods;
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthenticationService>(context, listen: false)
        .getUser()!
        .uid;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FutureBuilder<List<Food>>(
        future: queryFoodInCart(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(snapshot.data![index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    CollectionReference orderedFoods = FirebaseFirestore
                        .instance
                        .collection('orders')
                        .doc(uid)
                        .collection('foods');

                    await deleteItemFromCart(
                        orderedFoods, index, uid, snapshot);
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(
                    cart: Cart(
                        product: snapshot.data![index],
                        numOfItem: quanities[index]),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> deleteItemFromCart(CollectionReference<Object?> orderedFoods,
      int index, String uid, AsyncSnapshot<List<Food>> snapshot) async {
    // Minus from total quantity
    late String new_total_items;
    await orderedFoods
        .doc('no_item')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      new_total_items =
          (int.parse(documentSnapshot['no_item']) - quanities[index])
              .toString();
      orderedFoods.doc('no_item').update({
        'no_item': new_total_items,
      });
    });
    // Minus from total price
    await FirebaseFirestore.instance.collection('orders').doc(uid).get().then(
      (DocumentSnapshot<Map> documentSnapshot) {
        final String new_total =
            (double.parse(documentSnapshot.data()!['total']) -
                    snapshot.data![index].price * quanities[index])
                .toStringAsFixed(2);
        FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .update({'total': new_total});
      },
    );
    // Delete item from Firebase
    await orderedFoods
        .doc(snapshot.data![index].id.toString())
        .delete()
        .then((value) => print("Food item deleted"))
        .catchError(
            (error) => print("Failed to delete food item from cart: $error"));

    // If the last item is removed from database, store_id is set to empty
    if (new_total_items == "0") {
      await FirebaseFirestore.instance.collection('orders').doc(uid).get().then(
        (DocumentSnapshot<Map> documentSnapshot) {
          FirebaseFirestore.instance
              .collection('orders')
              .doc(uid)
              .update({'store_id': ""});
        },
      );
    }
  }
}
