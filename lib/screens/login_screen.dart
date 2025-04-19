// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobilescreen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      // Navigate to home screen or next stepS
       Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) =>    const ResponsiveLayout(webScreenLayout: WebscreenLayout(), mobileScreenLayout: MobilescreenLayout()))
    );
    }
  }

  void navigatetoSignup() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              // ignore: deprecated_member_use
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 60,
              ),
              const SizedBox(height: 30),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: loginUser,
                child: Container(
                  // ignore: sort_child_properties_last
                  child:
                      _isLoading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                          : const Text('Login'),

                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: navigatetoSignup,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
