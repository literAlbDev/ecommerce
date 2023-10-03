import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/OrdersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          itemBuilder: (context, index)
          {
            OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);

            int quantity = ordersProvider.order['attributes']['orderDetails'][index]['attributes']['quantity'];
            double price = double.parse(ordersProvider.order['attributes']['orderDetails'][index]['attributes']['price']);
            double total = price * quantity;
            String image = ordersProvider.order['attributes']['orderDetails'][index]['attributes']['product']['attributes']['image'];
            String name = ordersProvider.order['attributes']['orderDetails'][index]['attributes']['product']['attributes']['name'];

            return Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColorScheme.primary)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(image),
                  Expanded(
                      child: PrimaryText(
                          name,
                          13)),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: AppColorScheme.primary, fontSize: 17),
                      children: [
                        TextSpan(text: "\$ $price"),
                        TextSpan(
                            text: "  X  ",
                            style: TextStyle(color: AppColorScheme.secondary)),
                        TextSpan(text: "$quantity"),
                      ],
                    ),
                  ),
                  PrimaryText("\$ " + total.toStringAsFixed(2), 17),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
