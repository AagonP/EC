import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Food.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

final uid = 'mock_user_id';
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
        final id = 1;
        final description = documentSnapshot.data()!['description'];
        final List<String> images = [documentSnapshot.data()!['imageURL']];
        final price = documentSnapshot.data()!['price'];
        final title = documentSnapshot.data()!['title'];
        foods.add(Food(
            id: id,
            description: description,
            images: images,
            price: double.parse(price.toString()),
            title: title));
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
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FutureBuilder<List<Food>>(
        future: queryFoodInCart(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(snapshot.data![index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      // TODO:Remove item from cart
                    });
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
}
