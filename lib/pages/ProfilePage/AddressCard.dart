import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/pages/ProfilePage/EditAddressBottomSheet.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  AddressCard({
    required this.firstName,
    required this.lastName,
    required this.addressLine1,
    this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
  });

  final String firstName;
  final String lastName;
  final String addressLine1;
  final String? addressLine2;
  final String country;
  final String state;
  final String city;
  final String zipCode;

  final double nameFontSize = 20;
  final double titleFontSize = 11;
  final double valueFontSize = 17;
  final double padding = 7;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 30),
      elevation: 5,
      color: AppColorScheme.surface,
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
                  onPressed: () {},
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
                    this.firstName + " " + this.lastName,
                    style: TextStyle(
                        fontSize: nameFontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => EditAddressBottomSheet(),
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
                        SurfaceText(addressLine2!, valueFontSize),
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
