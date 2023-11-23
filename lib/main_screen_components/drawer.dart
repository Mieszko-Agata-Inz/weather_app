import 'package:flutter/material.dart';

class DrawerBurger extends StatelessWidget {
  const DrawerBurger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: Key("drawer"),
      width: 260,
      child: Column(),
    );
  }
}
