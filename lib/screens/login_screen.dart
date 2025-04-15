import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});



  @override
  State<LoginScreen> createState() => _LoginScreenState();
  
}

class _LoginScreenState extends State<LoginScreen> {
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

@override
  void dispose() {

    _emailController.dispose();
  _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height: 60,),
            const SizedBox(height: 10,),
            TextFieldInput(textEditingController: _emailController, hintText: "Enter your email", textInputType:TextInputType.emailAddress),
                        const SizedBox(height: 10,),
            TextFieldInput(textEditingController: _passwordController, hintText: "Enter your password", textInputType:TextInputType.text,isPass: true), 
            TextButton(onPressed: (){}, child: Text("Log in")),

            ]
              ),
            )
            
          )
        ) ;
    
  }
}