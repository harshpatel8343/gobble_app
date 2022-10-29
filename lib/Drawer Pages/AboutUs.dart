import 'package:flutter/material.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: Center(
       child: Text('About Us'),
     ),
    );
  }
}
