import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Food.dart';

import '../../../size_config.dart';

class QuantityConfig extends StatefulWidget {
  QuantityConfig({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;
  var quantity = 1;

  @override
  _QuantityConfigState createState() => _QuantityConfigState();
}

class _QuantityConfigState extends State<QuantityConfig> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Text(
            "Quantity",
            style: Theme.of(context).textTheme.headline5,
          ),
          Spacer(),
          Text(
            "$quantity",
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black38,
                ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            showShadow: true,
            press: () {
              setState(() {
                quantity = quantity > 0 ? quantity - 1 : quantity;
                widget.quantity = quantity;
              });
            },
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                quantity += 1;
                widget.quantity = quantity;
              });
            },
          ),
        ],
      ),
    );
  }
}
