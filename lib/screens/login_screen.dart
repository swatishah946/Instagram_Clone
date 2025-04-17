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
 super.dispose();
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
              Flexible(flex: 2,child: Container(),),
              // ignore: deprecated_member_use
              SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height: 60,),
            const SizedBox(height: 30,),
            TextFieldInput(textEditingController: _emailController, hintText: "Enter your email", textInputType:TextInputType.emailAddress),
                        const SizedBox(height: 20,),
            TextFieldInput(textEditingController: _passwordController, hintText: "Enter your password", textInputType:TextInputType.text,isPass: true), 
            const SizedBox(height: 20,),

InkWell(
  child: Container(
  width: double.infinity,
  height: 50,
  padding: EdgeInsets.symmetric(vertical: 12),
  alignment: Alignment.center,
  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
  color: blueColor,
  ),
  child: const Text('Login'),
  
  ),
),
                      const SizedBox(height: 20,),
Flexible( flex: 2,child: Container(),),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Text("Don't have an account?"),

    ),
    GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 4),
        child: const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold),),
      
      ),
    ),
  ],
)
            ]
              ),
            ),

            
          )
        ) ;
    
  }
}