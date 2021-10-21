import 'package:flutter/material.dart';
import 'package:shop_app/models/Food.dart';

import 'package:shop_app/constants.dart';
import '../../../size_config.dart';

class FoodDescription extends StatelessWidget {
  const FoodDescription({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            food.title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Divider(
          thickness: 0.6,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "${food.price.toStringAsFixed(2)} VND",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: DescriptionParagraph(
            food: food,
          ),
        )
      ],
    );
  }
}


class DescriptionParagraph extends StatefulWidget {
  const DescriptionParagraph({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  _DescriptionParagraphState createState() => _DescriptionParagraphState();
}

class _DescriptionParagraphState extends State<DescriptionParagraph> {
  bool fullDetails = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.food.description,
          maxLines: fullDetails ? 8 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              fullDetails = !fullDetails;
            });
          },
          child: Row(
            children: [
              Text(
                fullDetails ? "Hide Detail" : "See More Detail",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              SizedBox(width: 5),
              Icon(
                fullDetails ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 12,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
