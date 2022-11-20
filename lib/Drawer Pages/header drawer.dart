import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

String name='';
String mail='';

final user = FirebaseAuth.instance.currentUser!;
final userCollection = FirebaseFirestore.instance.collection("users");

Future <List<String>> getUserData() async {
  DocumentSnapshot data = await userCollection.doc(user.uid).get();
  name = data.get("name");
  mail = data.get("mail");
  return [name,mail];
}

class _MyHeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
     builder: (context,snapshot){
    if (snapshot.connectionState == ConnectionState.waiting)
    return Center(
    child: CircularProgressIndicator(),
    );
     return Container(
        color: Colors.brown[400],
        width: double.infinity,
        height: 130,
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: user.photoURL == null
                  ? CircleAvatar(
                  radius: 45,
                  backgroundImage:
                  AssetImage("assets/profile.png"))
                  : CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              margin: EdgeInsets.only(bottom: 10),
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      );
     }
    );
  }

}


