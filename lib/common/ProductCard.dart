import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/RateWidget.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/product"),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColorScheme.primary)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Banner(
              message: "limited stock",
              location: BannerLocation.topEnd,
              color: AppColorScheme.secondary,
              child: Image.network("https://placehold.co/400x300.png"),
            ),
            Expanded(child: PrimaryText("product name iphone 11", 13)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RateWidget(rate: 3),
                GestureDetector(
                  onTap: (){},
                  child: Icon(
                    Icons.favorite,
                    color: AppColorScheme.primary, //changeable
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryText("\$ 180.00", 17),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
