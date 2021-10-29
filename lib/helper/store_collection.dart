import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/helper/auth.dart';
import 'package:shop_app/models/Store.dart';

class StoreCollection with ChangeNotifier {
  StoreCollection() {
    initPopularStores();
  }

  String uid = "";
  List<Store> popularStores = [];
  List<Store> stores = [];
  List<Store> favoriteStores = [];

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

  void fetchFavorites(AuthenticationService auth) async {
    if (auth.getUser() != null) {
      uid = auth.getUser()!.uid;
      List<String> favoriteIds = [];

      // Fetch favorite stores
      // Fetch from users
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        List<dynamic> dynamicFavorite = documentSnapshot.get("favorites");
        favoriteIds =
            dynamicFavorite.map((element) => element as String).toList();
        for (String fav in favoriteIds) {
          int idx = popularStores.indexWhere((element) => element.id == fav);
          if (idx != -1) {
            popularStores[idx].isFavourite = true;
          }
        }
      });

      // Fetch stores
      await FirebaseFirestore.instance
          .collection("stores")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          int idx =
              favoriteStores.indexWhere((element) => element.id == doc.id);
          if (favoriteIds.contains(doc.id) && idx == -1) {
            Store temp = Store(
              id: doc.id,
              images: [doc['imageURL']],
              title: doc['title'],
              distance: doc['distance'].toDouble(),
              address: doc['address'],
              rating: doc['rating'].toDouble(),
              isPopular: doc['isPopular'],
              isFavourite: true,
            );
            favoriteStores.add(temp);
          }
        });
      });
      notifyListeners();
    }
  }

  void toggleFavorite(Store store) {
    bool isFavourite = store.isFavourite;

    // Post to Firestore
    if (isFavourite) {
      FirebaseFirestore.instance.collection("users").doc(uid).update({
        "favorites": FieldValue.arrayRemove([store.id]),
      });
    }
    else {
      FirebaseFirestore.instance.collection("users").doc(uid).update({
        "favorites": FieldValue.arrayUnion([store.id]),
      });
    }

    // Modify popularStores and stores
    // Extract indices
    int popularIdx =
        popularStores.indexWhere((element) => element.id == store.id);
    int storeIdx = stores.indexWhere((element) => element.id == store.id);

    // Toggle
    if (popularIdx != -1) {
      popularStores[popularIdx].isFavourite =
          !popularStores[popularIdx].isFavourite;
    }
    if (storeIdx != -1) {
      stores[storeIdx].isFavourite = !stores[storeIdx].isFavourite;
    }

    // Modify favoriteStores
    if (isFavourite) {
      favoriteStores.removeWhere((element) => store.id == element.id);
    } else {
      if (store.isFavourite == false) store.isFavourite = true;
      favoriteStores.add(store);
    }

    notifyListeners();
  }

  Future<void> queryStore(String query) async {
    List<String> favoriteIds = favoriteStores.map((e) => e.id).toList();

    await FirebaseFirestore.instance
        .collection('stores')
        .where('category', arrayContains: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["title"]);
        Store temp = Store(
          id: doc.id,
          images: [doc['imageURL']],
          title: doc['title'],
          distance: doc['distance'].toDouble(),
          address: doc['address'],
          rating: doc['rating'].toDouble(),
          isPopular: doc['isPopular'],
          isFavourite: favoriteIds.contains(doc.id) ? true : false,
        );
        stores.add(temp);
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

  List<Store> get getFavoriteStores => favoriteStores;
}
