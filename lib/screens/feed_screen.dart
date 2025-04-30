import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/widgets/postcard.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height: 32,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.message_outlined)),
        ],
      ),
      body: PostCard(),
    );
  }
}