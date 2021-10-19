import 'package:flutter/material.dart';
import '../../models/Store.dart';
import '../../models/Food.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
// import 'package:shop_app/screens/store/store_screen.dart';
// import 'package:shop_app/models/Store.dart';
// import 'package:shop_app/models/Food.dart';

class StoreScreen extends StatelessWidget {
  static String routeName = "/store";

  @override
  Widget build(BuildContext context) {
    final StoreArguments agrs =
        ModalRoute.of(context)!.settings.arguments as StoreArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.store.rating),
      ),
      body: Body(
        store: agrs.store,
        foods: agrs.foods,
      ),
    );
  }
}

class StoreArguments {
  final Store store;
  final List<Food> foods;

  StoreArguments({
    required this.store,
    required this.foods,
  });
}
