import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/color.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    'https://unsplash.com/photos/woman-reads-a-map-in-a-forest-0VvQjNVDTtw',
                  ),
                ),
                Expanded(child:Padding(padding: 
                EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),),
                ),
                IconButton(onPressed:(){
                  showDialog(context: context, builder: (context)=>Dialog(
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                      shrinkWrap: true,
                      children: [
                        'Delete',
                      ].map((e)=>InkWell(
                        onTap: (){},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                          child: Text(e),
                        ),
                      ),).toList(),
                    ),
                  ),);
                }, icon: Icon(Icons.more_vert))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
