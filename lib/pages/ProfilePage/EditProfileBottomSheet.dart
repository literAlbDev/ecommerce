import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class EditProfileBottomSheet extends StatelessWidget {
  EditProfileBottomSheet({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 1,
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
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    labelText: "Name",
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
                    labelText: "Email",
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
                  //obscureText: _passwordHidden,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        /*_passwordHidden
                            ? Icons.visibility_off
                            :*/
                        Icons.visibility,
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
                  //obscureText: _passwordHidden,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        /*_passwordHidden
                            ? Icons.visibility_off
                            :*/
                        Icons.visibility,
                      ),
                    ),
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
                SecondaryText("*leave password field empty if you want to only change name or email.", 14),
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
