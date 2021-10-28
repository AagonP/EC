import 'package:flutter/material.dart';
import 'package:shop_app/helper/store_collection.dart';
import 'package:shop_app/models/Store.dart';
import 'package:shop_app/screens/home/components/store_card.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Store> popularStore = context.watch<StoreCollection>().getPopularStores;

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Stores", press: () {
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
