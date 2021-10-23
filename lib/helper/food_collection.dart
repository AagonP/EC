import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Food.dart';

class FoodCollection {
  List<Food> foods = [];

  Future<List<Food>> queryFoods(String storeId) async {
    await FirebaseFirestore.instance
        .collection('foods')
        .where('store_id', isEqualTo: storeId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Food tem = Food(
          id: doc.id,
          title: doc['title'],
          description: doc['description'],
          images: [doc['imageURL']],
          price: doc['price'].toDouble(),
        );
        foods.add(tem);
      });
    });
    return foods;
  }

  List<Food> get getFoods => foods;
}
