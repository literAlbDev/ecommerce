import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressBottomSheet extends StatelessWidget {
  AddAddressBottomSheet({super.key});

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
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DraggableScrollableSheet(
        initialChildSize: 1,
        maxChildSize: 1,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
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
                      //labelText: "First Name",
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
                      //labelText: "Last Name",
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
                      //labelText: "Address Line 1",
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
                      //labelText: "Address Line 2",
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
                      //labelText: "Country",
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
                      //labelText: "State",
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
                      //labelText: "City",
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
                      //labelText: "Zip Code", // change to api value
                      hintText: "Zip Code",
                      hintStyle: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FilledButton(
                    onPressed: userProvider.loading
                        ? null
                        : () {
                            userProvider
                                .addAddress(
                              _firstnameController.text,
                              _lastnameController.text,
                              _addressLine1Controller.text,
                              _addressLine2Controller.text,
                              _countryController.text,
                              _stateController.text,
                              _cityController.text,
                              _zipCodeController.text,
                            )
                                .then((value) {
                              if (value) Navigator.pop(context);
                            });
                          },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Text(
                    userProvider.errors,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
