import 'package:flutter/material.dart';
import 'package:gobble_1/Services/recipe.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/recipe.api.dart';


class SearchUser extends SearchDelegate {

 List<Recipes> _recipeslist = [];

  getRecipeData() async{
    _recipeslist = await RecipeApi().getRecipe()!;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return  FutureBuilder(
      future: getRecipeData(),
      builder:(context, snapshot){
        if(snapshot.connectionState== ConnectionState.waiting)
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else{
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _recipeslist.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipeCard(
                  title:_recipeslist[index].title,
                  readyInMinutes:_recipeslist[index].readyInMinutes.toString(),
                  thumbnailUrl: _recipeslist[index].image,
                instructions:_recipeslist[index].readyInMinutes.toString(),);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child:Text('G O B B L E ',
        style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
          fontSize: 22,fontWeight: FontWeight.bold,color: Colors.brown[200],
        )),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final String title;
  final String readyInMinutes;
  final String thumbnailUrl;
  final String instructions;
  RecipeCard({
    required this.title,
    required this.readyInMinutes,
    required this.thumbnailUrl,
    required this. instructions,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(widget.thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.title ,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(

                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(widget.readyInMinutes,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}
