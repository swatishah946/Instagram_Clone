import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobilescreen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signupuser() async {
    if (_image == null) {
      showSnackBar("Please select a profile picture", context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      username: _usernameController.text.trim(),
      bio: _bioController.text.trim(),
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    } else {
      // Navigate to home screen or next stepS
       Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) =>    const ResponsiveLayout(webScreenLayout: WebscreenLayout(), mobileScreenLayout: MobilescreenLayout()))
    );
    }
  }

  void navigatetoLogin() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
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
                // ignore: deprecated_member_use
                color: primaryColor,
                height: 60,
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                      : CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('assets/profile_image.png'),
                      ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectimage,
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Enter your username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),
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
              TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: signupuser,
                child: Container(
                  // ignore: sort_child_properties_last
                  child:
                      _isLoading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                          : const Text('SignUp'),

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
                    child: const Text("Already have an account?"),
                  ),
                  GestureDetector(
                    onTap: navigatetoLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      child: const Text(
                        "Login",
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
