import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  OrderDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 1,
      expand: false,
      builder: (context, scrollController) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 233,
              crossAxisSpacing: 15,
              childAspectRatio: 0.7,
              mainAxisSpacing: 15),
          itemCount: 3,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColorScheme.primary)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network("https://placehold.co/400x300.png"),
                Expanded(child: PrimaryText("product name likefghk;gfnkfm  mkgbn lnmvdf bnf nbmfjkjh hn ghjv iphone 11", 13)),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: AppColorScheme.primary, fontSize: 17),
                    children: [
                      TextSpan(text: "\$ 60.00"),
                      TextSpan(
                          text: "  X  ",
                          style: TextStyle(color: AppColorScheme.secondary)),
                      TextSpan(text: "3"),
                    ],
                  ),
                ),
                PrimaryText("\$ 180.00", 17),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
