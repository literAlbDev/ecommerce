import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                HeaderText("Sign In"),
                SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
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
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        /*_passwordHidden
                            ? Icons.visibility_off
                            :*/ Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FilledButton(
                  onPressed:  () {
                          Navigator.pushNamed(context, "/profile");
                        },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: "Don't have account?"),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/signup");
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ]),
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
