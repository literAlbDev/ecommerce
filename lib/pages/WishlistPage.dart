import 'package:ecommerce/common/CartBottomSheet.dart';
import 'package:ecommerce/common/ProductCard.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/WishListProvieder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<WishListProvider>(context, listen: false).initWishList();
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SurfaceText("Wishlist", 40),
      ),
      bottomSheet: CartBottomSheet(),
      body: !wishListProvider.loading ? GridView.builder(
        padding: EdgeInsets.all(20).copyWith(bottom: 100),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 233,
            crossAxisSpacing: 15,
            childAspectRatio: 0.7,
            mainAxisSpacing: 15),
        itemCount: wishListProvider.wishlist?["data"].length,
        itemBuilder: (context, index) => ProductCard(index: index, wishList: true,),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}
