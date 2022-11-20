// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gobble_1/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/UI.dart';

class AuthService{
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return UI();
          } else {
            return const Login();
          }
        });
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
getProfileImg()
{
  if(FirebaseAuth.instance.currentUser!.photoURL!=null){
    return CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
      radius:50,
    );
  }
  else{
    return Icon(Icons.person,size: 50);
  }
}

addSubCollection( String id,title,image,time){
  FirebaseFirestore.instance.collection("users").doc(id).
  collection("favorites").add({
    "title": title,
    "image": image,
    "time": time
  });
}

}