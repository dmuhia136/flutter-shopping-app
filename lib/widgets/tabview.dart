import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sales_app/screens/user/products.dart';
import 'package:sales_app/screens/user/shops.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class CustomTabView extends StatelessWidget {
  const CustomTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: ContainedTabBarView(
          tabs: [
            Text('Products'),
            Text('Shop Detail'),
            Text('Sales'),
          ],
          views: [Products(), Shops(),Center(child: Text("Sales"))],
          onChange: (index) => print(index),
        ),

      ),
    );
  }
}
