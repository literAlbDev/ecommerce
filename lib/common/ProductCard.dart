import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/RateWidget.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/ProductsProvider.dart';
import 'package:ecommerce/providers/WishListProvieder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.index, this.wishList = false});

  final int index;
  final bool wishList;

  int calculateRate(ProductsProvider productsProvider) {

    int rate = 0;

    dynamic revs = productsProvider.categorizedProducts["data"][index]
        ['attributes']['reviews'];
    int len = revs.isNotEmpty ? revs.length : 0;
    if (len > 0) {
      for (Map r in revs) {
        rate += r["attributes"]["rating"] as int;
      }
      rate = rate / len as int;
    }

    return rate;
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);

    String name = wishList
        ? wishListProvider.wishlist!["data"][index]['attributes']['name']
        : productsProvider.categorizedProducts["data"][index]['attributes']
            ['name'];
    String image = wishList
        ? wishListProvider.wishlist!["data"][index]['attributes']['image']
        : productsProvider.categorizedProducts["data"][index]['attributes']
            ['image'];
    String price = wishList
        ? wishListProvider.wishlist!["data"][index]['attributes']['price']
        : productsProvider.categorizedProducts["data"][index]['attributes']
            ['price'];
    int stock = wishList
        ? wishListProvider.wishlist!["data"][index]['attributes']['stock']
        : productsProvider.categorizedProducts["data"][index]['attributes']
            ['stock'];
    bool inWishList = wishList
        ? wishListProvider.wishlist!["data"][index]['attributes']['inWishList']
        : productsProvider.categorizedProducts["data"][index]['attributes']
            ['inWishList'];

    int id = wishList
        ? wishListProvider.wishlist!["data"][index]['id']
        : productsProvider.categorizedProducts["data"][index]['id'];

    int rate = calculateRate(productsProvider);

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColorScheme.primary)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stock <= 10
              ? Banner(
                  message: "limited stock",
                  location: BannerLocation.topEnd,
                  color: AppColorScheme.secondary,
                  child: GestureDetector(
                    onTap: () {
                      productsProvider.setProduct(id);
                      Navigator.pushNamed(context, "/product");
                    },
                    child: Image.network(image),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    productsProvider.setProduct(id);
                    Navigator.pushNamed(context, "/product");
                  },
                  child: Image.network(image),
                ),
          Expanded(child: PrimaryText(name, 13)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RateWidget(rate: rate),
              GestureDetector(
                onTap: () {
                  productsProvider.startLoading();
                  if (inWishList)
                    wishListProvider.removeWishList(id).then((value) {
                      productsProvider.getProducts();
                    });
                  else
                    wishListProvider.addWishList(id).then((value) {
                      productsProvider.getProducts();
                    });
                },
                child: Icon(
                  inWishList ? Icons.favorite : Icons.favorite_border,
                  color: inWishList ? AppColorScheme.primary : Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PrimaryText("\$ $price", 17),
            ],
          ),
        ],
      ),
    );
  }
}
