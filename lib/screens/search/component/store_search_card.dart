import 'package:flutter/material.dart';
import 'package:shop_app/models/Store.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class StoreSearchCard extends StatelessWidget {
  const StoreSearchCard({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to store screen
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: kSecondaryColor.withOpacity(0.1),
                    //   borderRadius: BorderRadius.circular(15),
                    // ),
                    child: Hero(
                      tag: store.id.toString(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          store.images[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "⭐ ${store.rating}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                      children: [
                        TextSpan(
                            text: "\t\t\t\t  📍 ${store.distance} km",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            height: 10,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
