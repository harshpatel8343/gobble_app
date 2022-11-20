import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobble_1/Services/FavoriteModel.dart';

class FavoriteProvider with ChangeNotifier {
  static void addFavoriteData({
    required String title,
    required String image,
    required String time,
    required String info,

  }) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance
        .collection('favourites')
        .doc(id)
        .set(
      {
        'title': title,
        'image': image,
        'time': time,
        'id':id,
        'info': info
      },
    );
  }
  List<FavoriteModel> Favoritelist = [];
  getFavoriteData() async {
    List<FavoriteModel> favorite_list = [];
    QuerySnapshot value = (await FirebaseFirestore.instance
        .collection('favourites')
        .doc()
        .get()) as QuerySnapshot<Object?>;
    value.docs.forEach((element) {
      FavoriteModel favoriteModel = FavoriteModel(
          title: element.get('title'),
          servings: element.get('servings').toString(),
          image: element.get('image'),
          time: element.get('time').toString(),
          info: element.get('info'),
          isVeg: element.get('isVeg')
      );


      favorite_list.add(favoriteModel);
    });
    Favoritelist = favorite_list;
    notifyListeners();
  }
  List<FavoriteModel> get getFavoritelist{
    return Favoritelist;
  }
}