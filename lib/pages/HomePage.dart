import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/CartBottomSheet.dart';
import 'package:ecommerce/common/ProductCard.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
            iconSize: 35,
            color: Colors.black,
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
            iconSize: 35,
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
            iconSize: 35,
            color: Colors.black,
          ),
        ],
        bottom: PreferredSize(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(10, (index) => CategoryWidget(isSelected: index %2 == 0,)),
            ),
          ),
          preferredSize: Size(50, 70),
        ),
      ),
      drawer: Builder(
        builder: (context) {
          return Drawer(
            backgroundColor: AppColorScheme.background,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(color: AppColorScheme.primary),
                  child: Center(
                    child: HeaderText(
                      "ecommerce",
                      color: AppColorScheme.background,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  horizontalTitleGap: 55,
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                    Scaffold.of(context).closeDrawer();
                  },
                  leading: Icon(Icons.account_circle, size: 33),
                  title: Text("Profile"),
                ),
                ListTile(
                  horizontalTitleGap: 55,
                  onTap: () {
                    Navigator.pushNamed(context, "/wishlist");
                    Scaffold.of(context).closeDrawer();
                  },
                  leading: Icon(Icons.favorite, size: 33),
                  title: Text("Wishlist"),
                ),
                ListTile(
                  horizontalTitleGap: 55,
                  onTap: () {
                    Navigator.pushNamed(context, "/orders");
                    Scaffold.of(context).closeDrawer();
                  },
                  leading: Icon(Icons.shopping_cart, size: 33),
                  title: Text("Orders"),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: CartBottomSheet(),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 233,
            crossAxisSpacing: 15,
            childAspectRatio: 0.7,
            mainAxisSpacing: 15),
        itemCount: 10,
        itemBuilder: (context, index) => ProductCard(),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColorScheme.primary
            ),
            child: HeaderText("category", fontSize: 16, color: AppColorScheme.background,),
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColorScheme.primary),
            ),
            child: HeaderText("category", fontSize: 16, color: AppColorScheme.onSurface,),
          );
  }
}
