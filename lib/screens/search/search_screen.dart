import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/helper/store_collection.dart';
import 'package:shop_app/screens/search/component/store_search_card.dart';
import 'package:shop_app/screens/search/component/upperlayer.dart';
import 'package:shop_app/size_config.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  List<Product> searchResults = [];

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;

  @override
  void initState() {
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

  Widget _getLowerLayer() {
    StoreCollection storeState = Provider.of<StoreCollection>(context);
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenHeight(20.0)),
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
            child: TextField(
              controller: searchController,
              onSubmitted: (value) async {
                print('submit $value');
                storeState.emptyQueryResult();
                this.isLoading = true;
                await storeState.queryStore(value.toLowerCase());
                this.isLoading = false;
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
              child: this.isLoading ? CircularProgressIndicator(): ListView.builder(
                itemCount: storeState.stores.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: StoreSearchCard(
                    store: storeState.stores[index],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
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
            upperLayer: UpperLayer(), // The bottomsheet content (Widget)
            animationController: _controller, // The one we created earlier
          ),
        ),
      ),
    );
  }
}
