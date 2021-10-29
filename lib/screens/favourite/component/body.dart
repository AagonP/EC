import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/store_collection.dart';
import 'package:shop_app/models/Store.dart';
import 'package:shop_app/screens/home/components/store_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    StoreCollection storeCollection = Provider.of<StoreCollection>(context);
    List<Store> favoriteStores = storeCollection.getFavoriteStores;

    return SafeArea(
      child: GridView.count(
        childAspectRatio: 0.75,
        mainAxisSpacing: 50,
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: [
          ...List.generate(
            favoriteStores.length,
            (index) {
              return Dismissible(
                key: Key(favoriteStores[index].id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    storeCollection.toggleFavorite(favoriteStores[index]);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: StoreCard(
                  width: 160,
                  store: favoriteStores[index],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
