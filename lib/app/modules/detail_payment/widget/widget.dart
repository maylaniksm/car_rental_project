import 'package:flutter/material.dart';

class ContentTile extends StatelessWidget {
  const ContentTile({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: Row(
        children: [
          Icon(Icons.check_rounded,color: Colors.green,),
          SizedBox(width: 10,),
          Text(title,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
        ],
      ),
    );
  }
}