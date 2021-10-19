import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/search/component/store_search_card.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late String selectedPeriod;
  late String selectedCategory;
  late String selectedPrice;

  List<Product> products = [
    Product('assets/images/hoc-nau-pho-gia-truyen.jpg',
        'Skullcandy headset L325', 'Lorem ipsum dolor sit amet', 102.99),
    Product('assets/images/hoc-nau-pho-gia-truyen.jpg',
        'Skullcandy headset X25', 'Lorem', 55.99),
    Product('assets/images/hoc-nau-pho-gia-truyen.jpg',
        'Blackzy PRO hedphones M003', 'Lorem', 152.99),
  ];

  List<String> timeFilter = [
    'Brand',
    'New',
    'Latest',
    'Trending',
    'Discount',
  ];

  List<String> categoryFilter = [
    'Skull Candy',
    'Boat',
    'JBL',
    'Micromax',
    'Seg',
  ];

  List<String> priceFilter = [
    '\$50-200',
    '\$200-400',
    '\$400-800',
    '\$800-1000',
  ];

  List<Product> searchResults = [];

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;

  @override
  void initState() {
    selectedPeriod = timeFilter[0];
    selectedCategory = categoryFilter[0];
    selectedPrice = priceFilter[0];

    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search',
                  style: TextStyle(
                    color: Color(0xff202020),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(color: Colors.orange, width: 1),
            //   ),
            // ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  List<Product> tempList = [];
                  products.forEach((product) {
                    if (product.name.toLowerCase().contains(value)) {
                      tempList.add(product);
                    }
                  });
                  setState(() {
                    searchResults.clear();
                    searchResults.addAll(tempList);
                  });
                  return;
                } else {
                  setState(() {
                    searchResults.clear();
                    searchResults.addAll(products);
                  });
                }
              },
              cursorColor: Color(0xff202020),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                suffix: TextButton(
                  onPressed: () {
                    searchController.clear();
                    searchResults.clear();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              // color: Colors.orange[50],
              child: ListView.builder(
                itemCount: demoProducts.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: StoreSearchCard(
                    product: demoProducts[index],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
//          controller: _scrollController,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedPeriod = timeFilter[index];
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 20.0),
                          decoration: selectedPeriod == timeFilter[index]
                              ? BoxDecoration(
                                  color: Color(0xffFDB846),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45)))
                              : BoxDecoration(),
                          child: Text(
                            timeFilter[index],
                            style: TextStyle(fontSize: 16.0),
                          ))),
                ),
              ),
              itemCount: timeFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = categoryFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedCategory == categoryFilter[index]
                          ? BoxDecoration(
                              color: Color(0xffFDB846),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45)))
                          : BoxDecoration(),
                      child: Text(
                        categoryFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: categoryFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPrice = priceFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedPrice == priceFilter[index]
                          ? BoxDecoration(
                              color: Color(0xffFDB846),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45)))
                          : BoxDecoration(),
                      child: Text(
                        priceFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          body: RubberBottomSheet(
            lowerLayer: _getLowerLayer(), // The underlying page (Widget)
            upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
            animationController: _controller, // The one we created earlier
          ),
        ),
      ),
    );
  }
}

class Product {
  String image;
  String name;
  String description;
  double price;

  Product(this.image, this.name, this.description, this.price);
}
