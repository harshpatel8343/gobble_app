import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[400],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(FirebaseAuth.instance.currentUser!.photoURL!),
              ),
            ),
          ),
          Text(
            FirebaseAuth.instance.currentUser!.displayName!,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            FirebaseAuth.instance.currentUser!.email!,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}