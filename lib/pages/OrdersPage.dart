import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/pages/OrdersPage/OrderDetailsBottomSheet.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SurfaceText("Orders", 40),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
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
                          SecondaryText("${index}", 20), // change with api value
                        ],
                      ),
                      Row(
                        children: [
                          PrimaryText("product quantity: ", 15),
                          SecondaryText("5", 20), // change with api value
                        ],
                      ),
                      Row(
                        children: [
                          PrimaryText("total price: ", 15),
                          SecondaryText("\$ 500.99", 20), // change with api value
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Align(
                        heightFactor: 1.2,
                        widthFactor: 1.0,
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
                                  "https://placehold.co/400x300.png",
                                  scale: 1,
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Align(
                        heightFactor: 1.1,
                        widthFactor: 1.1,
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
                                  "https://placehold.co/400x300.png",
                                  scale: 1,
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Align(
                        heightFactor: 1.0,
                        widthFactor: 1.2,
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
                                  "https://placehold.co/400x300.png",
                                  scale: 1,
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
