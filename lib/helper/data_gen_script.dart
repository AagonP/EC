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
void mainAddData({required String collection, required List<Map<String, dynamic>> data}) {
  // TODO: Remember to change the collection name
  for (var i = 0; i < data.length; i++) {
    addData("stores", data[i]);
  }
}


// // Store
// List<Map<String, dynamic>> stores = [
//   {
//     "title": "Pho Hung",
//     "rating": 4.1,
//     "isPopular": false,
//     "imageURL":
//     "https://www.disneycooking.com/wp-content/uploads/2020/03/hoc-nau-pho-gia-truyen.jpg",
//     "foods": [""],
//     "distance": 1.5,
//     "address":
//     "397a Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
//   },
//   {
//     "title": "Banh mi Sai Gon",
//     "rating": 4.8,
//     "isPopular": true,
//     "imageURL":
//     "https://cdnmedia.thethaovanhoa.vn/Upload/tyTrfgkgEUQwPYuvZ4Kn1g/files/2020/03/3203/4w5thy.jpg",
//     "foods": [""],
//     "distance": 4,
//     "address":
//     "1, Bui Thi Xuan street, ward 4, district 1, Ho Chi Minh city"
//   },
//   {
//     "title": "KFC",
//     "rating": 4.1,
//     "isPopular": true,
//     "imageURL":
//     "https://images.foody.vn/res/g1/1488/prof/s640x400/image-3b2daeee-201123110753.jpeg",
//     "foods": [""],
//     "distance": 4.5,
//     "address":
//     "102, Ngo Gia Tu street, ward 6, district 5, Ho Chi Minh city"
//   },
//   {
//     "title": "Hanuri",
//     "rating": 4.7,
//     "isPopular": true,
//     "imageURL":
//     "https://toplist.vn/images/800px/bibimbap-korean-food-quan-han-thich-hop-cho-cac-cap-doi-89319.jpg",
//     "foods": [""],
//     "distance": 1.9,
//     "address":
//     "102, Su Van Hanh street, ward 5, district 10, Ho Chi Minh city"
//   },
//   {
//     "title": "Gong Cha",
//     "rating": 4.8,
//     "isPopular": true,
//     "imageURL":
//     "http://gongcha.com.vn/wp-content/uploads/2018/06/Hinh-Web-OKINAWA-LATTE.png",
//     "foods": [""],
//     "distance": 3.2,
//     "address":
//     "31a, Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
//   },
// ];


// // Store
// List<Map<String, dynamic>> stores = [
//   {
//     "title": "Pho Hung",
//     "rating": 4.1,
//     "isPopular": false,
//     "imageURL":
//     "https://www.disneycooking.com/wp-content/uploads/2020/03/hoc-nau-pho-gia-truyen.jpg",
//     "foods": [""],
//     "distance": 1.5,
//     "address":
//     "397a Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
//   },
//   {
//     "title": "Banh mi Sai Gon",
//     "rating": 4.8,
//     "isPopular": true,
//     "imageURL":
//     "https://cdnmedia.thethaovanhoa.vn/Upload/tyTrfgkgEUQwPYuvZ4Kn1g/files/2020/03/3203/4w5thy.jpg",
//     "foods": [""],
//     "distance": 4,
//     "address":
//     "1, Bui Thi Xuan street, ward 4, district 1, Ho Chi Minh city"
//   },
//   {
//     "title": "KFC",
//     "rating": 4.1,
//     "isPopular": true,
//     "imageURL":
//     "https://images.foody.vn/res/g1/1488/prof/s640x400/image-3b2daeee-201123110753.jpeg",
//     "foods": [""],
//     "distance": 4.5,
//     "address":
//     "102, Ngo Gia Tu street, ward 6, district 5, Ho Chi Minh city"
//   },
//   {
//     "title": "Hanuri",
//     "rating": 4.7,
//     "isPopular": true,
//     "imageURL":
//     "https://toplist.vn/images/800px/bibimbap-korean-food-quan-han-thich-hop-cho-cac-cap-doi-89319.jpg",
//     "foods": [""],
//     "distance": 1.9,
//     "address":
//     "102, Su Van Hanh street, ward 5, district 10, Ho Chi Minh city"
//   },
//   {
//     "title": "Gong Cha",
//     "rating": 4.8,
//     "isPopular": true,
//     "imageURL":
//     "http://gongcha.com.vn/wp-content/uploads/2018/06/Hinh-Web-OKINAWA-LATTE.png",
//     "foods": [""],
//     "distance": 3.2,
//     "address":
//     "31a, Le Dai Hanh street, ward 11, district 10, Ho Chi Minh city",
//   },
// ];