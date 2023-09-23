import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/pages/ProfilePage/EditAddressBottomSheet.dart';
import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  AddressCard({required this.index});

  final int index;

  final double nameFontSize = 20;
  final double titleFontSize = 11;
  final double valueFontSize = 17;
  final double padding = 7;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String firstName = userProvider.user?["data"]["attributes"]
        ['shippingAddresses'][index]["first_name"];
    String lastName = userProvider.user?["data"]["attributes"]
        ['shippingAddresses'][index]["last_name"];
    String addressLine1 = userProvider.user?["data"]["attributes"]
        ['shippingAddresses'][index]["address_line_1"];
    String? addressLine2 = userProvider.user?["data"]["attributes"]
        ['shippingAddresses'][index]["address_line_2"];
    String country = userProvider.user?["data"]["attributes"]
        ['shippingAddresses'][index]["country"];
    String state = userProvider.user?["data"]["attributes"]['shippingAddresses']
        [index]["state"];
    String city = userProvider.user?["data"]["attributes"]['shippingAddresses']
        [index]["city"];
    String zipCode = userProvider.user?["data"]["attributes"]
        ['shippingAddresses'][index]["zip_code"];
    int id = userProvider.user?["data"]["attributes"]['shippingAddresses']
        [index]["id"];

    return Card(
      margin: EdgeInsets.only(bottom: 30),
      elevation: 5,
      color: AppColorScheme.primarySurface,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    userProvider.deleteAddress(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  style: IconButton.styleFrom(
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    iconSize: 25,
                  ),
                ),
                Center(
                  child: Text(
                    firstName + " " + lastName,
                    style: TextStyle(
                        fontSize: nameFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => EditAddressBottomSheet(
                              id: id,
                              userAddressData: userProvider.user?["data"]
                                  ["attributes"]['shippingAddresses'][index],
                            ),
                        useSafeArea: true,
                        isScrollControlled: true);
                  },
                  icon: Icon(Icons.edit),
                  color: AppColorScheme.secondary,
                  style: IconButton.styleFrom(
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    iconSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13),
            SecondaryText("address line 1:", titleFontSize),
            SurfaceText(addressLine1, valueFontSize),
            SizedBox(height: padding),
            Builder(
              builder: (context) => addressLine2 != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SecondaryText(
                          "address line 2:",
                          titleFontSize,
                        ),
                        SurfaceText(addressLine2, valueFontSize),
                        SizedBox(height: padding),
                      ],
                    )
                  : SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryText(
                  "Country: ",
                  titleFontSize,
                ),
                Expanded(child: SurfaceText(country, valueFontSize)),
                SizedBox(width: padding),
                SecondaryText(
                  "zip code: ",
                  titleFontSize,
                ),
                Expanded(child: SurfaceText(zipCode, valueFontSize)),
              ],
            ),
            SizedBox(height: padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryText(
                  "state: ",
                  titleFontSize,
                ),
                Expanded(child: SurfaceText(state, valueFontSize)),
                SizedBox(width: 7),
                SecondaryText(
                  "city: ",
                  titleFontSize,
                ),
                Expanded(child: SurfaceText(city, valueFontSize)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
