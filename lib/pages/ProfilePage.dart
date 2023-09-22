import 'package:ecommerce/pages/ProfilePage/AddressCard.dart';
import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/pages/ProfilePage/AddAddressBottomSheet.dart';
import 'package:ecommerce/pages/ProfilePage/EditProfileBottomSheet.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SurfaceText("Profile", 40),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => EditProfileBottomSheet(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 15),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText("albaraa", 30),
                // change to api value
                SizedBox(height: 5),

                PrimaryText("albaraa@gmail.com", 30),
                // change to api value
                SizedBox(height: 40),

                Row(children: [PrimaryText("addresses:", 25)]),
                for (int index in List.generate(7, (index) => index))
                  AddressCard(
                    firstName: "first ${index}",
                    // change to api value
                    lastName: "last ${index}",
                    // change to api value
                    addressLine1: "address line 1 infos ${index}",
                    // change to api value
                    addressLine2: "address line 2 infos ${index}",
                    // change to api value
                    country: "Turkey",
                    // change to api value
                    state: "Istanbul",
                    // change to api value
                    city: "Basak",
                    // change to api value
                    zipCode: "33452", // change to api value
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
