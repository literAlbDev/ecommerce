import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/pages/OrdersPage/OrderDetailsBottomSheet.dart';
import 'package:ecommerce/providers/OrdersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false).initOrders();
  }

  @override
  Widget build(BuildContext context) {
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SurfaceText("Orders", 40),
      ),
      body: !ordersProvider.loading ? ListView.builder(
        itemCount: ordersProvider.orders['data'].length,
        itemBuilder: (context, index) {
          dynamic order = ordersProvider.orders['data'][index];
          int id = ordersProvider.orders['data'][index]['id'];
          double total = double.parse(ordersProvider.orders['data'][index]['attributes']['total']);
          int quantity = 0;
          List images = [];

          ordersProvider.orders['data'][index]['attributes']['orderDetails'].forEach((elemnt) {
            quantity += elemnt['attributes']['quantity'] as int;
            images.add(elemnt['attributes']['product']['attributes']['image']);
          });

          return GestureDetector(
            onTap: () {
              ordersProvider.order = order;
              showModalBottomSheet(
                context: context,
                builder: (context) => OrderDetailsBottomSheet(),
                useSafeArea: true,
                isScrollControlled: true,
              );
            },
            child: Card(
              margin: EdgeInsets.all(11),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            PrimaryText("id: ", 15),
                            SecondaryText("$id", 20),
                            // change with api value
                          ],
                        ),
                        Row(
                          children: [
                            PrimaryText("product quantity: ", 15),
                            SecondaryText("$quantity", 20), // change with api value
                          ],
                        ),
                        Row(
                          children: [
                            PrimaryText("total price: ", 15),
                            SecondaryText("\$ $total", 20),
                            // change with api value
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: List.generate(images.length > 3 ? 3 : images.length, (index) {
                        return Align(
                            heightFactor: 1.2 - (index != 0 ? index/10 : 0),
                            widthFactor: 1.0 + (index != 0 ? index/10 : 0),
                            child: Container(
                              width: 100,
                              height: 70,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.5))
                                ],
                                //border: Border.all(color: Colors.black),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      images[index],
                                      scale: 1,
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          );
                      }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
