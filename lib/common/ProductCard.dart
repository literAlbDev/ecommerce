import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/RateWidget.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/ProductsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.index});

  final int index;

  int calculateRate(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);

    int rate = 0;

    dynamic revs = productsProvider.categorizedProducts["data"][index]
        ['attributes']['reviews'];
    int len = revs.isNotEmpty ? revs.length : 0;
    if (len > 0) {
      for (Map r in productsProvider.categorizedProducts["data"][index]
          ['attributes']['reviews']) {
        rate += r["attributes"]["rating"] as int;
      }
      rate = rate / len as int;
    }

    return rate;
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);

    String name = productsProvider.categorizedProducts["data"][index]['attributes']
        ['name'];
    String image = productsProvider.categorizedProducts["data"][index]['attributes']
        ['image'];
    String price = productsProvider.categorizedProducts["data"][index]['attributes']
        ['price'];
    int stock = productsProvider.categorizedProducts["data"][index]['attributes']
        ['stock'];
    bool inWishList = productsProvider.categorizedProducts["data"][index]
        ['attributes']['inWishList'];

    int rate = calculateRate(context);

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
                      Navigator.pushNamed(context, "/product");
                    },
                    child: Image.network(image),
                  ),
                )
              : GestureDetector(
                  onTap: () {
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
                onTap: () {},
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
