import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/models/Store.dart';

class StoreCollection with ChangeNotifier {
  StoreCollection(){
    initPopularStore();
  }
  List<Store> popularStore = [];

  Future<void> initPopularStore() async {
    await FirebaseFirestore.instance
        .collection('stores')
        .where('isPopular', isEqualTo: true)
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
            isPopular: doc['isPopular']
        );
        popularStore.add(tem);
      });
    });
  }



  List<Store> get getPopularStore => popularStore;

}
