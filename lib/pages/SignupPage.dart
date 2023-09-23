import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:ecommerce/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderText("Sign Up"),
                SizedBox(height: 50),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !userProvider.isVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                SizedBox(height: 15),
                TextFormField(
                  controller: _rpasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !userProvider.isVisible,
                  decoration: InputDecoration(
                    hintText: "Re-Password",
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
                SizedBox(height: 15),
                FilledButton(
                  onPressed: userProvider.loading
                      ? null
                      : () {
                          userProvider
                              .signup(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _rpasswordController.text)
                              .then((value) {
                            if (value)
                              Navigator.pushReplacementNamed(
                                  context, "/home");
                          });
                        },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Already have an account ?"),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/signin");
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}
