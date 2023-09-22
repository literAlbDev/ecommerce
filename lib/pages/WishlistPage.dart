import 'package:ecommerce/common/CartBottomSheet.dart';
import 'package:ecommerce/common/ProductCard.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SurfaceText("Wishlist", 40),
      ),
      bottomSheet: CartBottomSheet(),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 233,
            crossAxisSpacing: 15,
            childAspectRatio: 0.7,
            mainAxisSpacing: 15),
        itemCount: 10,
        itemBuilder: (context, index) => ProductCard(),
      ),
    );
  }
}
