import 'package:flutter/material.dart';

class EditAddressBottomSheet extends StatelessWidget {
  EditAddressBottomSheet({super.key});

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      minChildSize: 0.7,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                TextFormField(
                  controller: _firstnameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "First Name",
                    // change to api value
                    hintText: "First Name",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _lastnameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "Last Name",
                    // change to api value
                    hintText: "Last Name",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _addressLine1Controller,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "Address Line 1",
                    // change to api value
                    hintText: "Address Line 1",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _addressLine2Controller,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "Address Line 2",
                    // change to api value
                    hintText: "Address Line 2 (not required)",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _countryController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "Country",
                    // change to api value
                    hintText: "Country",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _stateController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "State",
                    // change to api value
                    hintText: "State",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _cityController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "City",
                    // change to api value
                    hintText: "City",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _zipCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "Zip Code", // change to api value
                    hintText: "Zip Code",
                    hintStyle: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Text(
                  "error",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}