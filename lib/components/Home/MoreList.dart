import 'package:flutter/material.dart';

class Morelist extends StatefulWidget {
  Morelist({Key? key}) : super(key: key);

  @override
  _MorelistState createState() => _MorelistState();
}

class _MorelistState extends State<Morelist> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text("更多商品$index",style: TextStyle(fontSize: 20,color: Colors.red)),
        );
      },
    );
  }
}