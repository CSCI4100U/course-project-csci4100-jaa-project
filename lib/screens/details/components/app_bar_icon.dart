import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  final List<Widget> children;
  final double containerWidth;

  const AppBarIcon({
    super.key,
    required this.children,
    this.containerWidth = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: containerWidth, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,//Colors.white,
        borderRadius: BorderRadius.circular(containerWidth),
      ),
      child: Row(
        children: children,
      ),
    );
  }
}
