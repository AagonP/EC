import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/Store.dart';

class StoreCollection with ChangeNotifier {
  StoreCollection() {
    initPopularStores();
  }

  List<Store> popularStores = [];
  List<Store> stores = [];

  Future<void> initPopularStores() async {
    await FirebaseFirestore.instance
        .collection('stores')
        .where('isPopular', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Store tem = Store(
          id: doc.id,
          images: [doc['imageURL']],
          title: doc['title'],
          distance: doc['distance'].toDouble(),
          address: doc['address'],
          rating: doc['rating'].toDouble(),
          isPopular: doc['isPopular'],
        );
        popularStores.add(tem);
      });
    });
  }

  Future<void> queryStore(String query) async {
    await FirebaseFirestore.instance
        .collection('stores')
        .where('category', arrayContains: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["title"]);
        Store tem = Store(
          id: doc.id,
          images: [doc['imageURL']],
          title: doc['title'],
          distance: doc['distance'].toDouble(),
          address: doc['address'],
          rating: doc['rating'].toDouble(),
          isPopular: doc['isPopular'],
        );
        stores.add(tem);
      });
    });
    notifyListeners();
  }

  void emptyQueryResult() {
    stores.clear();
    notifyListeners();
  }

  List<Store> get getPopularStores => popularStores;

  List<Store> get getQueryStores => stores;
}
