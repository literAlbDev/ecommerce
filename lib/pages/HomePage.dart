import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/CartBottomSheet.dart';
import 'package:ecommerce/common/ProductCard.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/CartProvider.dart';
import 'package:ecommerce/providers/CategoryProvider.dart';
import 'package:ecommerce/providers/ProductsProvider.dart';
import 'package:ecommerce/providers/ThemeProvider.dart';
import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).initProducts();
    Provider.of<CategoryProvider>(context, listen: false).initCategories();
    Provider.of<CartProvider>(context, listen: false).loadFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
            iconSize: 35,
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              if(themeProvider.theme == 'light')
                themeProvider.setTheme("dark");
              if(themeProvider.theme == 'dark')
                themeProvider.setTheme("light");
            },
            icon: Icon(themeProvider.theme == 'light'
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
            iconSize: 35,
          ),
          IconButton(
            onPressed: () {
              productsProvider.getProducts();
              categoryProvider.getCategories();
            },
            icon: Icon(Icons.refresh),
            iconSize: 35,
          ),
          IconButton(
            onPressed: () {
              userProvider.logout().then((value) {
                if (value) Navigator.pushReplacementNamed(context, "/signin");
              });
            },
            icon: Icon(Icons.logout),
            iconSize: 35,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(50, 70),
          child: !categoryProvider.loading
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        categoryProvider.categories?["data"].length,
                        (index) => CategoryWidget(index: index)),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
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
      body: !productsProvider.loading
          ? GridView.builder(
              padding: EdgeInsets.all(20).copyWith(bottom: 100),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 233,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 15),
              itemCount: productsProvider.categorizedProducts["data"].length,
              itemBuilder: (context, index) => ProductCard(index: index),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    String name =
        categoryProvider.categories?["data"][index]["attributes"]["name"];
    int id = categoryProvider.categories?["data"][index]["id"];
    bool isSelected = categoryProvider.isSelected(id);

    return isSelected
        ? GestureDetector(
            onTap: () {
              categoryProvider.deselectCategory(id);
              productsProvider.categorize(categoryProvider.selectedCategories);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColorScheme.primary),
              child: HeaderText(
                name,
                fontSize: 16,
                color: AppColorScheme.background,
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              categoryProvider.selectCategory(id);
              productsProvider.categorize(categoryProvider.selectedCategories);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColorScheme.primary),
              ),
              child: HeaderText(
                name,
                fontSize: 16,
                color: AppColorScheme.onSurface,
              ),
            ),
          );
  }
}
