import 'package:flutter/material.dart';

class StoreTitleCard extends StatelessWidget {
  const StoreTitleCard({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: MediaQuery.of(context).size.width - 20.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 3.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 4.0), // shadow direction: bottom right
          ),
        ],
      ),
      child: child,
    );
  }
}
