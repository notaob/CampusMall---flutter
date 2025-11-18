import 'package:flutter/material.dart';

class Sliders extends StatefulWidget {
  Sliders({Key? key}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Sliders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey,
      alignment: Alignment.center,
       child: Text("轮播图",style: TextStyle(fontSize: 20,color: Colors.red)),
    );
  }
}