import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/storeCollection.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Store.dart';
import 'package:shop_app/screens/home/components/store_card.dart';
import 'package:shop_app/screens/search/component/store_search_card.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Store> popularStore = context.read<StoreCollection>().getPopularStore;
    print(popularStore.length);

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Stores", press: () {
            print("Store printed");
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                popularStore.length,
                (index) {
                  if (popularStore[index].isPopular)
                    return StoreCard(store: popularStore[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
