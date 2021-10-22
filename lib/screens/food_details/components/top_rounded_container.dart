import 'package:flutter/material.dart';

import '../../../size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
    this.isRounded = true,
    this.topMargin = true,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final bool isRounded;
  final bool topMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin ? getProportionateScreenWidth(20) : 0),
      padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: isRounded ? BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ) : null,
      ),
      child: child,
    );
  }
}
