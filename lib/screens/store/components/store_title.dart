import 'package:flutter/material.dart';
import 'package:shop_app/models/Store.dart';
import 'store_title_card.dart';
import 'store_description.dart';

import '../../../size_config.dart';

class StoreTitle extends StatelessWidget {
  const StoreTitle({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          store.images[0],
          height: getProportionateScreenHeight(270),
        ),
        Positioned(
          top: getProportionateScreenHeight(180),
          left: 10,
          child: StoreTitleCard(
            color: Colors.white,
            child: StoreDescription(
              store: store,
            ),
          ),
        ),
      ],
    );
  }
}
