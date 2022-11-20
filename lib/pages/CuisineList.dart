// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/CuisineModel.dart';
import '../Services/cuisineAPI.dart';
import '../Services/favs.dart';

class CuisineDisplay extends StatefulWidget {
  const CuisineDisplay({Key? key,required this.name}) : super(key: key);
final String name;
  @override
  State<CuisineDisplay> createState() => _CuisineDisplayState();
}

class _CuisineDisplayState extends State<CuisineDisplay> {

  Future reFresh() async {
    setState(() {});
  }
  List<Results> _CuisineList = [];
  Future getCuisine() async {
    _CuisineList = await CuisineService().getCuisinesData(cuisine: widget.name);
    print(_CuisineList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        centerTitle:true,
        title:Text('G O B B L E ',
          style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
            fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,
          )),
        ),
      ),
        body: FutureBuilder(
          future: getCuisine(),
          builder:(context, snapshot){
            if(snapshot.connectionState== ConnectionState.waiting)
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasError){
              return
                Center(
                  child: SnackBar(content: Text(snapshot.error.toString(),
                    style: TextStyle(letterSpacing: 1.5),),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.redAccent,
                  ),
                );
            }
            else{
              return RefreshIndicator(
                onRefresh: reFresh,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _CuisineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeCard(
                      title: _CuisineList[index].title,
                      thumbnailUrl: _CuisineList[index].image!,
                      // instructions: _CuisineList[index].instruction!,
                      instructions: '',
                      cuisine: _CuisineList[index].cuisine.toString(),
                      c: 0,
                      docID: '',
                      );
                  },
                ),
              );
            }
          },
        )
    );
  }
}
class RecipeCard extends StatefulWidget {
  final String? cuisine;
  final String title;
  final String thumbnailUrl;
  final String instructions;
  int c;
  String docID;
  RecipeCard({
    required this.title,
    required this.thumbnailUrl,
    required this.instructions,
    required this.c,
    required this.docID,
    required this. cuisine,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool like=false;
  String? docID;
  var user=FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Future createFavorite(Favs fav) async {
    final docFav = firestoreInstance.collection("users").
    doc(user?.uid).collection("favorites").doc();
    fav.id = docFav.id;
    docID = fav.id;
    final json = fav.toJson();
    await docFav.set(json);
    widget.c = widget.c + 1;
  }

  void deleteFavorite() async {
    final docFav =
    firestoreInstance.collection("users").doc(user?.uid).collection("favorites").doc(docID);
    await docFav.delete();
    widget.c = widget.c - 1;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: () async{
                        setState(() {
                          like=!like;
                        });

                        if(like==true && widget.c==0){
                          createFavorite(Favs(
                              id: widget.docID,
                              title:widget.title,
                              image: widget.thumbnailUrl,
                              info: widget.instructions,
                              cuisine: widget.cuisine, time: ''
                          ));
                        }
                        if (like == false && widget.c > 0) {
                          deleteFavorite();
                        }

                      },
                          icon: Icon(
                            (like==false? Icons.favorite_border:Icons.favorite),
                            color: Colors.red,
                            size: 25.0,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    ),
    );
  }
}
