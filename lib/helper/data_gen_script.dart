import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: You should define the list of STORES as the following format
List<Map<String, dynamic>> stores = [
  {
    "title": "Pho Hung",
    "rating": 4.1,
    "isPopular": false,
    "imageURL":
        "https://www.disneycooking.com/wp-content/uploads/2020/03/hoc-nau-pho-gia-truyen.jpg",
    "foods": [""],
    "distance": 1.5,
    "address":
        "397a Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
  },
  {
    "title": "Banh mi Sai Gon",
    "rating": 4.8,
    "isPopular": true,
    "imageURL":
        "https://cdnmedia.thethaovanhoa.vn/Upload/tyTrfgkgEUQwPYuvZ4Kn1g/files/2020/03/3203/4w5thy.jpg",
    "foods": [""],
    "distance": 4,
    "address": "1, Bui Thi Xuan street, ward 4, district 1, Ho Chi Minh city"
  },
  {
    "title": "KFC",
    "rating": 4.1,
    "isPopular": true,
    "imageURL":
        "https://images.foody.vn/res/g1/1488/prof/s640x400/image-3b2daeee-201123110753.jpeg",
    "foods": [""],
    "distance": 4.5,
    "address": "102, Ngo Gia Tu street, ward 6, district 5, Ho Chi Minh city"
  },
  {
    "title": "Hanuri",
    "rating": 4.7,
    "isPopular": true,
    "imageURL":
        "https://toplist.vn/images/800px/bibimbap-korean-food-quan-han-thich-hop-cho-cac-cap-doi-89319.jpg",
    "foods": [""],
    "distance": 1.9,
    "address": "102, Su Van Hanh street, ward 5, district 10, Ho Chi Minh city"
  },
  {
    "title": "Gong Cha",
    "rating": 4.8,
    "isPopular": true,
    "imageURL":
        "http://gongcha.com.vn/wp-content/uploads/2018/06/Hinh-Web-OKINAWA-LATTE.png",
    "foods": [""],
    "distance": 3.2,
    "address":
        "31a, Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
  },
];

// TODO: You should define the list of FOODS as the following format
// TODO: Remember! This list of foods is defined as global variable.
// TODO: Therefore, if you have just modify the food list, you must restart the application before clicking "Add Data" button.
List<Map<String, dynamic>> foods = [
  {
    "title": "Bun Bo Hue - full toppings",
    "price": 60,
    "description":
        "Bun bo Hue originated in the beautiful ancient city of Hue in Central Vietnam famous for its Royal Cuisine. Like the more famous Pho Bo, it is a beef noodle dish but is distinctly different due to its history and origins. It is a noodle soup with a rich spicy broth, it contains slices of beef or pork and is topped with leaves and herbs as so many Vietnamese dishes are. It is a meal full of flavours and textural contrasts.",
    "imageURL": "https://culturephamtravel.com/wp-content/uploads/2020/02/Noodle-soup-with-Beef-culture-pham-travel-1.jpg",
    "categories": ["Bun/Pho"],
    "store_id": "QFcvyNuse1FwCXQMINM5",
  },
  {
    "title": "Bun Bo Hue - beef only",
    "price": 45,
    "description":
    "Bun bo Hue originated in the beautiful ancient city of Hue in Central Vietnam famous for its Royal Cuisine. Like the more famous Pho Bo, it is a beef noodle dish but is distinctly different due to its history and origins. It is a noodle soup with a rich spicy broth, it contains slices of beef or pork and is topped with leaves and herbs as so many Vietnamese dishes are. It is a meal full of flavours and textural contrasts.",
    "imageURL": "https://ngonaz.com/wp-content/uploads/2021/09/cach-nau-bun-bo-hue-10.jpg",
    "categories": ["Bun/Pho"],
    "store_id": "QFcvyNuse1FwCXQMINM5",
  },
  {
    "title": "Bun Bo Hue - no pork foot",
    "price": 55,
    "description":
    "Bun bo Hue originated in the beautiful ancient city of Hue in Central Vietnam famous for its Royal Cuisine. Like the more famous Pho Bo, it is a beef noodle dish but is distinctly different due to its history and origins. It is a noodle soup with a rich spicy broth, it contains slices of beef or pork and is topped with leaves and herbs as so many Vietnamese dishes are. It is a meal full of flavours and textural contrasts.",
    "imageURL": "https://bep360.net/wp-content/uploads/2021/05/bun-bo-hue.jpg",
    "categories": ["Bun/Pho"],
    "store_id": "QFcvyNuse1FwCXQMINM5",
  },
  {
    "title": "Chicken Pho",
    "price": 50,
    "description":
        "If you love Vietnamese food, no doubt you have tried Vietnamese rice noodle soup, Pho. Pho is served in practically every Vietnamese restaurant here in the States, so much so that people think Vietnamese food is mainly pho. It is just the tip of the iceberg in Vietnamese cuisine but it’s the most iconic of them all.",
    "imageURL":
        "https://www.recipetineats.com/wp-content/uploads/2020/05/Chicken-Pho_2.jpg",
    "categories": ["Bun/Pho"],
    "store_id": "QFcvyNuse1FwCXQMINM5",
  },
  {
    "title": "Beef Pho",
    "price": 60,
    "description":
        "If you love Vietnamese food, no doubt you have tried Vietnamese rice noodle soup, Pho. Pho is served in practically every Vietnamese restaurant here in the States, so much so that people think Vietnamese food is mainly pho. It is just the tip of the iceberg in Vietnamese cuisine but it’s the most iconic of them all.",
    "imageURL":
        "https://images.squarespace-cdn.com/content/v1/52d3fafee4b03c7eaedee15f/1537811103612-WP6I3LYX6FIAC2VBIQ4K/Vietnamese+Beef+Noodle+Soup+Ph%E1%BB%9F+B%C3%B2?format=1500w",
    "categories": ["Bun/Pho"],
    "store_id": "QFcvyNuse1FwCXQMINM5",
  },
];

// Function to add a doc
Future<void> addData(String collection, Map<String, dynamic> data) {
  CollectionReference colRef =
      FirebaseFirestore.instance.collection(collection);

  // Handle adding food to store
  String storeId = "";
  String foodId = "";
  if (collection == "foods") {
    storeId = data["store_id"];
    // Call the collection reference to add new document
    return colRef.add(data).then((value) {
      foodId = value.id;

      FirebaseFirestore.instance.collection("stores").doc(storeId).update({
        "foods": FieldValue.arrayUnion([foodId])
      });
    }).catchError((error) => print("Adding failed: $error."));
  } else {
    // Call the collection reference to add new document
    return colRef.add(data).then((value) {
      print("Success!");
    }).catchError((error) => print("Adding failed: $error."));
  }
}

// Main function where addData is called
void mainAddData(
    {required String collection, required List<Map<String, dynamic>> data}) {
  // TODO: Remember to change the collection name
  for (var i = 0; i < data.length; i++) {
    addData(collection, data[i]);
  }
}
