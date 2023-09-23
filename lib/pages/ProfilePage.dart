import 'package:ecommerce/pages/ProfilePage/AddressCard.dart';
import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/pages/ProfilePage/AddAddressBottomSheet.dart';
import 'package:ecommerce/pages/ProfilePage/EditProfileBottomSheet.dart';
import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getMe();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SurfaceText("Profile", 40),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => EditProfileBottomSheet(userData: userProvider
                    .user?["data"]["attributes"]),
                useSafeArea: true,
                isScrollControlled: true,
              );
            },
            icon: Icon(Icons.edit),
            iconSize: 35,
            color: AppColorScheme.secondary,
          )
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddAddressBottomSheet(),
              useSafeArea: true,
              isScrollControlled: true,
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      body: userProvider.user != null ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 15),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                    userProvider.user?["data"]["attributes"]['name'], 30),
                // change to api value
                SizedBox(height: 5),

                PrimaryText(
                    userProvider.user?["data"]["attributes"]['email'], 30),
                // change to api value
                SizedBox(height: 40),

                Row(children: [PrimaryText("addresses:", 25)]),
                for (int index in List.generate(
                    userProvider
                        .user?["data"]["attributes"]['shippingAddresses']
                        .length,
                    (index) => index))
                  AddressCard(index: index),
              ],
            ),
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}
