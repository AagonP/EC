import 'package:cloud_firestore/cloud_firestore.dart';

// Function to add a doc
Future<void> addData(String collection, Map<String, dynamic> data) {
  CollectionReference colRef =
      FirebaseFirestore.instance.collection(collection);

  // Call the collection reference to add new document
  return colRef
      .add(data)
      .then((value) => print("A new $collection is added successfully!"))
      .catchError((error) => print("Adding failed: $error."));
}

// Main function where addData is called
void mainAddData(
    {required String collection, required List<Map<String, dynamic>> data}) {
  // TODO: Remember to change the collection name
  for (var i = 0; i < data.length; i++) {
    addData(collection, data[i]);
  }
}

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
    "address":
    "1, Bui Thi Xuan street, ward 4, district 1, Ho Chi Minh city"
  },
  {
    "title": "KFC",
    "rating": 4.1,
    "isPopular": true,
    "imageURL":
    "https://images.foody.vn/res/g1/1488/prof/s640x400/image-3b2daeee-201123110753.jpeg",
    "foods": [""],
    "distance": 4.5,
    "address":
    "102, Ngo Gia Tu street, ward 6, district 5, Ho Chi Minh city"
  },
  {
    "title": "Hanuri",
    "rating": 4.7,
    "isPopular": true,
    "imageURL":
    "https://toplist.vn/images/800px/bibimbap-korean-food-quan-han-thich-hop-cho-cac-cap-doi-89319.jpg",
    "foods": [""],
    "distance": 1.9,
    "address":
    "102, Su Van Hanh street, ward 5, district 10, Ho Chi Minh city"
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
List<Map<String, dynamic>> foods = [
  {
    "title": "Beef hamburger",
    "price": 40,
    "description":
        "This hamburger consists of one cooked ground beef, a layer of cheese and vegetable, all of which are placed inside a sliced bread roll or bun.",
    "imageURL":
        "https://content.api.news/v3/images/bin/3835f6211dbf5f2034b865ac73caef31",
    "categories": ["Hamburger"],
    "store_id": "RRnOlENhaMpcLtyTwr54",
  },
  {
    "title": "Fried chip",
    "price": 30,
    "description":
        "Thinly sliced deep-fried potato with a little cheese powder.",
    "imageURL":
        "https://img.taste.com.au/nkRXrlYH/taste/2016/11/deep-fried-chips-21149-1.jpeg",
    "categories": ["Hamburger"],
    "store_id": "RRnOlENhaMpcLtyTwr54",
  },
  {
    "title": "Pork hamburger",
    "price": 40,
    "description":
        "This hamburger consists of one cooked ground pork, a layer of cheese and vegetable, all of which are placed inside a sliced bread roll or bun.",
    "imageURL":
        "https://www.gordonramsayrestaurants.com/assets/Uploads/_resampled/CroppedFocusedImage63060050-50-Gordon-Ramsay-Brittania-Burger-Mobile.png",
    "categories": ["Hamburger"],
    "store_id": "RRnOlENhaMpcLtyTwr54",
  },
  {
    "title": "Shrimp hamburger",
    "price": 50,
    "description":
        "This hamburger consists of one cooked ground shrimp, a layer of cheese and vegetable, all of which are placed inside a sliced bread roll or bun.",
    "imageURL":
        "https://static.onecms.io/wp-content/uploads/sites/19/2013/09/06/shrimp-burger-ck-x.jpg",
    "categories": ["Hamburger"],
    "store_id": "RRnOlENhaMpcLtyTwr54",
  },
  {
    "title": "Chicken hamburger",
    "price": 40,
    "description":
        "This hamburger consists of one cooked ground chicken, a layer of cheese and vegetable, all of which are placed inside a sliced bread roll or bun.",
    "imageURL":
        "https://images.immediate.co.uk/production/volatile/sites/2/2017/06/Butchies-2.jpg?quality=90&resize=768%2C574",
    "categories": ["Hamburger"],
    "store_id": "RRnOlENhaMpcLtyTwr54",
  },
];
