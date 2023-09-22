import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:ecommerce/common/textwidgets.dart';
import 'package:flutter/material.dart';

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
  bool _passwordHidden = true;
  bool _rpasswordHidden = true;
  bool loading = false;

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
                  obscureText: _passwordHidden,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordHidden = !_passwordHidden;
                        });
                      },
                      icon: Icon(
                        _passwordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _rpasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _rpasswordHidden,
                  decoration: InputDecoration(
                    hintText: "Re-Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _rpasswordHidden = !_rpasswordHidden;
                        });
                      },
                      icon: Icon(
                        _rpasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                FilledButton(
                  onPressed: loading
                      ? null
                      : () {
                          setState(() {
                            loading = true;
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
