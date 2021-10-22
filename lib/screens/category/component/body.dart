import 'package:flutter/material.dart';
import 'package:shop_app/models/storeCollection.dart';
import 'package:shop_app/screens/search/search_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreCollection storeState = Provider.of<StoreCollection>(context);

    void queryCategory(String query) async{
      storeState.emptyQueryResult();
      await storeState.queryStore(query);
      Navigator.pushNamed(context, SearchScreen.routeName);
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SpecialOfferCard(
              image: "assets/images/Fried_Chicken-1024x536.png",
              category: "Fried Chicken",
              numOfBrands: 5,
              press: () {
                queryCategory('fried chicken');
              },
            ),
            SpecialOfferCard(
              image: "assets/images/tra-sua-truyen-thong.jpg",
              category: "Milk Tea",
              numOfBrands: 5,
              press: () {
                queryCategory('milk tea');
              },
            ),
            SpecialOfferCard(
              image: "assets/images/bibimbap-a-popular-Korean-dish.jpg",
              category: "Korean Food",
              numOfBrands: 5,
              press: () {
                queryCategory('korean food');
              },
            ),
            SpecialOfferCard(
              image: "assets/images/4w5thy.jpg",
              category: "Bread",
              numOfBrands: 5,
              press: () {
                queryCategory('bread');
              },
            ),
            SpecialOfferCard(
              image: "assets/images/hoc-nau-pho-gia-truyen.jpg",
              category: "Bun/Pho",
              numOfBrands: 5,
              press: () {
                queryCategory('bun/pho');
              },
            ),
            SpecialOfferCard(
              image: "assets/images/l-intro-1618426559.jpg",
              category: "Hamburger",
              numOfBrands: 5,
              press: () {
                queryCategory('hamburger');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(30)),
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: getProportionateScreenWidth(330),
          height: getProportionateScreenWidth(150),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 330/150,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.5),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
