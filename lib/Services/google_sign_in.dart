import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn= GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;


  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    // ignore: unnecessary_null_comparison
    if (googleUser== null) return;
    _user=googleUser;
    final googleAuth= await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

  notifyListeners();
  }
Future logOut() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
}

  List<String> _recipeslist = [];
  List<String> get favorite => _recipeslist;

  void toggleFavorite(String favorites ) {
    final isExist = _recipeslist.contains(favorites);
    if (isExist) {
      _recipeslist.remove(favorites);
    } else {
      _recipeslist.add(favorites);
    }
    notifyListeners();
  }

  bool isExist(String favorites) {
    final isExist = _recipeslist.contains(favorites);
    return isExist;
  }

  void clearFavorite() {
    _recipeslist = [];
    notifyListeners();
  }

  static GoogleSignInProvider of(BuildContext context , {bool listen = true,} )
  {
    return Provider.of<GoogleSignInProvider> (
      context, listen: listen,);
  }

  }



