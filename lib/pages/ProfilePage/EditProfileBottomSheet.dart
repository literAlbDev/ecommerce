import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileBottomSheet extends StatefulWidget {
  EditProfileBottomSheet({super.key, required this.userData});

  final Map<String, dynamic> userData;

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.userData['name'];
    _emailController.text = widget.userData['email'];
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
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      filled: true,
                      // change to api value
                      hintText: "Name",
                      hintStyle: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      filled: true,
                      // change to api value
                      hintText: "Email",
                      hintStyle: const TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !userProvider.isVisible,
                    decoration: InputDecoration(
                      hintText: "New Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          userProvider.toggleVisibility();
                        },
                        icon: Icon(
                          userProvider.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _rpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !userProvider.isVisible,
                    decoration: InputDecoration(
                      hintText: "New Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          userProvider.toggleVisibility();
                        },
                        icon: Icon(
                          userProvider.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
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
                                .updateMe(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    _rpasswordController.text)
                                .then((value) {
                              if (value) Navigator.pop(context);
                            });
                          },
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SecondaryText(
                      "*leave password field empty if you want to only change name or email.",
                      14),
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
