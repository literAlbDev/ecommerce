import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/CartBottomSheet.dart';
import 'package:ecommerce/common/RateWidget.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/CartProvider.dart';
import 'package:ecommerce/providers/ProductsProvider.dart';
import 'package:ecommerce/providers/ReviewProvider.dart';
import 'package:ecommerce/providers/UserProvider.dart';
import 'package:ecommerce/providers/WishListProvieder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).initProduct();
  }

  int calculateRate(ProductsProvider productsProvider) {
    int rate = 0;

    dynamic revs =
        productsProvider.product?["data"]['attributes']['reviews'] ?? [];
    int len = revs.isNotEmpty ? revs.length : 0;
    if (len > 0) {
      for (Map r in revs) {
        rate += r["attributes"]["rating"] as int;
      }
      rate = (rate / len).round();
    }

    return rate;
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    String name = productsProvider.product?["data"]['attributes']['name'] ?? "";
    String image =
        productsProvider.product?["data"]['attributes']['image'] ?? "";
    String price =
        productsProvider.product?["data"]['attributes']['price'] ?? "";
    String description =
        productsProvider.product?["data"]['attributes']['description'] ?? "";
    int stock = productsProvider.product?["data"]['attributes']['stock'] ?? 0;
    bool inWishList =
        productsProvider.product?["data"]['attributes']['inWishList'] ?? false;

    int id = productsProvider.product?["data"]['id'] ?? 0;

    List reviews =
        productsProvider.product?["data"]['attributes']['reviews'] ?? [];

    int rate = calculateRate(productsProvider);

    return Scaffold(
      appBar: AppBar(),
      bottomSheet: CartBottomSheet(),
      body: !productsProvider.loading
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(image),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(name, 17),
                        GestureDetector(
                          onTap: () {
                            productsProvider.startLoading();
                            if (inWishList)
                              wishListProvider.removeWishList(id).then((value) {
                                productsProvider.getProduct();
                              });
                            else
                              wishListProvider.addWishList(id).then((value) {
                                productsProvider.getProduct();
                              });
                          },
                          child: Icon(
                            inWishList ? Icons.favorite : Icons.favorite_border,
                            color: inWishList
                                ? AppColorScheme.primary
                                : Colors.grey,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(price, 30),
                        RateWidget(rate: rate, size: 30), // cahnge
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PrimaryText("Stock: ", 16),
                        SecondaryText("$stock", 16),
                      ],
                    ),
                    SizedBox(height: 13),
                    FilledButton(
                      onPressed: stock == 0
                          ? null
                          : !cartProvider.inCart(productsProvider.product!)
                              ? () {
                                  cartProvider
                                      .addToCart(productsProvider.product!);
                                }
                              : null,
                      child: const Text("Add to Cart",
                          style: TextStyle(fontSize: 25)),
                    ),
                    SizedBox(height: 13),
                    SecondaryText("Description", 17),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: PrimaryText(
                        description,
                        14,
                      ),
                    ),
                    SizedBox(height: 13),
                    Stack(
                      //alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            widthFactor: 1,
                            child: SecondaryText("Reviews", 17)),
                        Align(
                          widthFactor: 3,
                          child: FilledButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AddReviewDialog(),
                              );
                            },
                            style: FilledButton.styleFrom(
                                minimumSize: Size(0, 0),
                                padding: EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7))),
                            child: HeaderText("Add Review",
                                fontSize: 11, color: AppColorScheme.background),
                          ),
                        ),
                      ],
                    ),
                    for (int index
                        in List.generate(reviews.length, (index) => index))
                      ReviewWidget(index: index),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class AddReviewDialog extends StatelessWidget {
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ReviewProvider reviewProvider = Provider.of<ReviewProvider>(context);
    int productId = Provider.of<ProductsProvider>(context, listen: false)
        .product?['data']['id'];

    return AlertDialog(
      surfaceTintColor: AppColorScheme.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            controller: reviewController,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              hintText: "review",
            ),
          ),
          SizedBox(height: 20),
          Center(
              child: RateWidget(
            rate: reviewProvider.rate,
            size: 30,
          )),
          SizedBox(height: 20),
          FilledButton(
            onPressed: reviewProvider.loading
                ? null
                : () {
                    reviewProvider
                        .addReview(productId, reviewController.text)
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                        Provider.of<ProductsProvider>(context, listen: false)
                            .getProduct();
                        Provider.of<ProductsProvider>(context, listen: false)
                            .getProducts();
                      }
                    });
                  },
            child: HeaderText(
              "Save",
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Text(
            reviewProvider.errors,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class EditReviewDialog extends StatefulWidget {
  EditReviewDialog({super.key});

  @override
  State<EditReviewDialog> createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<EditReviewDialog> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    reviewController.text = Provider.of<ReviewProvider>(context, listen: false)
        .review['attributes']['review'];
  }

  @override
  Widget build(BuildContext context) {
    ReviewProvider reviewProvider = Provider.of<ReviewProvider>(context);
    int reviewId =
        Provider.of<ReviewProvider>(context, listen: false).review['id'];

    return AlertDialog(
      surfaceTintColor: AppColorScheme.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            controller: reviewController,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              hintText: "review",
            ),
          ),
          SizedBox(height: 20),
          Center(
              child: RateWidget(
            rate: reviewProvider.rate,
            size: 30,
          )),
          SizedBox(height: 20),
          FilledButton(
            onPressed: reviewProvider.loading
                ? null
                : () {
                    reviewProvider
                        .updateReview(reviewId, reviewController.text)
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                        Provider.of<ProductsProvider>(context, listen: false)
                            .getProduct();
                        Provider.of<ProductsProvider>(context, listen: false)
                            .getProducts();
                      }
                    });
                  },
            child: HeaderText(
              "Save",
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Text(
            reviewProvider.errors,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    ReviewProvider reviewProvider = Provider.of<ReviewProvider>(context);

    List reviews = productsProvider.product?['data']['attributes']['reviews'];
    String review = reviews[index]['attributes']['review'];
    int rate = reviews[index]['attributes']['rating'];
    String user = reviews[index]['attributes']['user'];
    bool isMe = user ==
        Provider.of<UserProvider>(context).user?['data']['attributes']['name'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              RateWidget(rate: rate),
              SizedBox(width: 7),
              PrimaryText(isMe ? "me" : user, 11),
            ]),
            isMe
                ? IconButton(
                    onPressed: () {
                      reviewProvider.set(reviews[index], rate);
                      showDialog(
                          context: context,
                          builder: (context) => EditReviewDialog());
                    },
                    icon: Icon(Icons.edit, size: 20),
                    color: AppColorScheme.secondary,
                  )
                : SizedBox(width: 0, height: 0),
          ],
        ),
        PrimaryText(review, 12),
        Divider(),
        SizedBox(height: 20)
      ],
    );
  }
}
