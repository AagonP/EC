import 'package:flutter/material.dart';

import '../../models/Food.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class FoodDetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final FoodDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as FoodDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(),
      ),
      body: Body(
        food: agrs.food,
      ),
    );
  }
}

class FoodDetailsArguments {
  final Food food;

  FoodDetailsArguments({required this.food});
}
