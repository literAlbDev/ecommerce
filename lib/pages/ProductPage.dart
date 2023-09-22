import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/CartBottomSheet.dart';
import 'package:ecommerce/common/RateWidget.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: CartBottomSheet(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network("https://placehold.co/400x300.png"),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText("product name like iphone 11", 17),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.favorite,
                      color: AppColorScheme.primary, //changeable
                      size: 40,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText("\$ 65.00", 30),
                  RateWidget(rate: 3, size: 30), // cahnge
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrimaryText("Stock: ", 16),
                  SecondaryText("1000", 16),
                ],
              ),
              SizedBox(height: 13),
              FilledButton(
                onPressed: () {},
                child:
                    const Text("Add to Cart", style: TextStyle(fontSize: 25)),
              ),
              SizedBox(height: 13),
              SecondaryText("Description", 17),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: PrimaryText(
                  "the ldasifina vjnf v  bvnjkfgvrygfbnfm vfhd njjb lfhvb n jhfhbvfkl",
                  14,
                ),
              ),
              SizedBox(height: 13),
              Stack(
                //alignment: Alignment.centerLeft,
                children: [
                  Align(widthFactor: 1, child: SecondaryText("Reviews", 17)),
                  Align(
                    widthFactor: 3,
                    child: FilledButton(
                      onPressed: () {},
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
              for (int index in List.generate(5, (index) => index))
                ReviewWidget(isEditable: index == 0 ? true : false),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.isEditable});

  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              RateWidget(rate: 4),
              SizedBox(width: 7),
              PrimaryText("me", 11),
            ]),
            isEditable
                ? IconButton(
                    onPressed: () {
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
        PrimaryText(
            "the review about the gooood iphone 11 pro max is shipped and in good shape",
            12),
        Divider(),
        SizedBox(height: 20)
      ],
    );
  }
}

class EditReviewDialog extends StatelessWidget {
  EditReviewDialog({super.key});

  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          EditRateWidget(rate: 4, size: 30),
          SizedBox(height: 20),
          FilledButton(
            onPressed: () {},
            child: HeaderText(
              "Save",
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class EditRateWidget extends StatelessWidget {
  const EditRateWidget({super.key, required this.rate, this.size});

  final int rate;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(size: size ?? 20, color: AppColorScheme.secondary, Icons.star),
        Icon(
            size: size ?? 20,
            color: rate >= 2
                ? AppColorScheme.secondary
                : AppColorScheme.secondarySurface,
            Icons.star),
        Icon(
            size: size ?? 20,
            color: rate >= 3
                ? AppColorScheme.secondary
                : AppColorScheme.secondarySurface,
            Icons.star),
        Icon(
            size: size ?? 20,
            color: rate >= 4
                ? AppColorScheme.secondary
                : AppColorScheme.secondarySurface,
            Icons.star),
        Icon(
            size: size ?? 20,
            color: rate >= 5
                ? AppColorScheme.secondary
                : AppColorScheme.secondarySurface,
            Icons.star),
      ],
    );
  }
}
