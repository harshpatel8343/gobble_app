import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {

  String? title;
  String? image;
  String? instruction;
  int? readyInMinutes;
  List? cuisine;
  RecipesMain? recipesMain;
  List<Recipes>? _recipeslist = [];

 getRecipe({String? query}) async {
    String url = "https://api.spoonacular.com/recipes/random?apiKey=778c2e35947e43e5bfb8b6db903b6964&number=15";
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        title = data["recipes"][0]["title"].toString();
        image = data["recipes"][0]["image"];
        cuisine = data["recipes"][0]["cuisines"];
        instruction=data["recipes"][0]["instructions"];
        readyInMinutes = data["recipes"][0]["readyInMinutes"];
        debugPrint(title);
        // debugPrint(readyInMinutes.toString());
        print(response.statusCode);
        var recipesMain = RecipesMain.fromJson(data);
        _recipeslist = recipesMain.recipes;
        // print(response.statusCode);
        if (query!= null){
          _recipeslist = _recipeslist?.where((element) => element.title.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      }
      else {
        print(response.statusCode);
      }
      return _recipeslist;
    }
    on Exception catch (e) {
      print(e);
    }
    // return _recipeslist;
  }
}