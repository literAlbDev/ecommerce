import 'package:ecommerce/common/AddressCard.dart';
import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
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
        title: SurfaceText("Profile", 5),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            iconSize: 35,
            color: AppColorScheme.secondary,
          )
        ],
      ),
      body: Padding(
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
              Expanded(
                child: ListView.builder(
                  itemCount: 100,
                  padding: EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return AddressCard(
                      firstName: "first ${index}",
                      lastName: "last ${index}",
                      addressLine1: "address line 1 infos ${index}",
                      addressLine2: "address line 2 infos ${index}",
                      country: "Turkey",
                      state: "Istanbul",
                      city: "Basak",
                      zipCode: "33452",
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
