import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({Key? key}) : super(key: key);

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final GlobalKey commentsHeaderKey = GlobalKey();

  double commentsHeaderHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Sets initial size of comments bottom sheet. Thanks to it users always see just a header of the bottom sheet at the beginning.
      final double currentCommentsHeaderHeight =
          commentsHeaderKey.currentContext?.size?.height ?? 0;
      if (currentCommentsHeaderHeight != commentsHeaderHeight) {
        setState(() {
          commentsHeaderHeight = currentCommentsHeaderHeight;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => DraggableScrollableSheet(
        initialChildSize: commentsHeaderHeight / constraints.maxHeight,
        minChildSize: commentsHeaderHeight / constraints.maxHeight,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: AppColorScheme.primarySurfaceBackgound,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CartBottomSheetHeader(
                    key: commentsHeaderKey, scrollController: scrollController),
                Expanded(
                  child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) => index == 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 5),
                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  minimumSize: Size(double.infinity, 40),
                                ),
                                child: HeaderText(
                                  "Order",
                                  fontSize: 20,
                                  color: AppColorScheme.background,
                                ),
                              ),
                            )
                          : CartItem()),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartBottomSheetHeader extends StatelessWidget {
  const CartBottomSheetHeader({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BottomSheetDragHandle(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryText("Total", 25),
                PrimaryText("\$ 55.00", 25), //change to api value
              ],
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}

class BottomSheetDragHandle extends StatelessWidget {
  const BottomSheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 7,
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColorScheme.primary,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          heightFactor: 1.3,
          widthFactor: 1,
          child: Container(
            //margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: AppColorScheme.primarySurface),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PrimaryText("product Name like iphone 11", 15),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryText("\$ 65.00", 23),
                        SizedBox(
                          width: 17,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  color: AppColorScheme.primary,
                                  icon: Icon(Icons.remove),
                                ),
                                PrimaryText("5", 20),
                                IconButton(
                                  onPressed: () {},
                                  color: AppColorScheme.primary,
                                  icon: Icon(Icons.add),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "stock: ",
                                  style:
                                      TextStyle(color: AppColorScheme.primary)),
                              TextSpan(
                                  text: "1000",
                                  style: TextStyle(
                                      color: AppColorScheme.secondary)),
                            ])),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                    color: AppColorScheme.primarySurface,
                    style: IconButton.styleFrom(
                        padding: EdgeInsets.only(right: 10),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size(0, 0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          heightFactor: 1,
          widthFactor: 1.2,
          child: Image.network(
            "https://placehold.co/400x300.png",
            scale: 3.5,
            isAntiAlias: false,
          ),
        )
      ],
    );
  }
}
