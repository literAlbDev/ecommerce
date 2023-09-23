import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressBottomSheet extends StatefulWidget {
  EditAddressBottomSheet({super.key, required this.id, required this.userAddressData});

  final int id;
  final Map<String, dynamic> userAddressData;

  @override
  State<EditAddressBottomSheet> createState() => _EditAddressBottomSheetState();
}

class _EditAddressBottomSheetState extends State<EditAddressBottomSheet> {

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstnameController.text =  widget.userAddressData["first_name"];
    _lastnameController.text = widget.userAddressData["last_name"];
    _addressLine1Controller.text = widget.userAddressData["address_line_1"];
    _addressLine2Controller.text = widget.userAddressData["address_line_2"] ?? "";
    _countryController.text = widget.userAddressData["country"];
    _stateController.text = widget.userAddressData["state"];
    _cityController.text = widget.userAddressData["city"];
    _zipCodeController.text = widget.userAddressData["zip_code"];
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DraggableScrollableSheet(
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: 1,
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
                      // change to api value
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
                                .updateAddress(
                                    _firstnameController.text,
                                    _lastnameController.text,
                                    _addressLine1Controller.text,
                                    _addressLine2Controller.text,
                                    _countryController.text,
                                    _stateController.text,
                                    _cityController.text,
                                    _zipCodeController.text,
                                    widget.id)
                                .then((value) {
                              if (value) Navigator.pop(context);
                            });
                          },
                    child: const Text(
                      "Save",
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
