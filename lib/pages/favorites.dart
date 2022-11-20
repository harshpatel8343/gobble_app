import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gobble_1/Services/RecipeInfo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'UI.dart';
import '../Services/favs.dart';


class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Stream<List<Favs>> readFavourites() =>
      FirebaseFirestore.instance.collection('users').doc(user?.uid).collection(
          'favorites')
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Favs.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        centerTitle:true,
        leading: IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>UI()));},
            icon: Icon(Icons.arrow_back)),
        title:Text('Favorites',
          style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
            fontSize: 22,fontWeight: FontWeight.normal,color: Colors.white,
          )),
        ),
      ),
      body: StreamBuilder<List<Favs>> (
          stream: readFavourites(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error occurred!"),
              );
            } else if (snapshot.hasData) {
              final favs = snapshot.data!;
              return ListView(
                children: favs.map(buildFavs).toList(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("Empty"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }

  Widget buildFavs(Favs favs) {
    return FavoriteData(
      title: favs.title!,
      image: favs.image!,
      time: favs.time!.toString(),
      docId: favs.id,
      c: 1,
      info: favs.info!,
      cuisne: favs.cuisine!,
    );
  }
}

class FavoriteData extends StatefulWidget {
  final String? title;
  final String? cuisne;
  final String? image;
  final String? time;
  final String? docId;
  final String? info;
  late final int c;
  FavoriteData({Key? key,
    required this.title,
    required this.image,
    required this.cuisne,
    required this.time,
    required this.docId,
    required this.info,
    required this.c,
  })
      : super(key: key);

  @override
  State<FavoriteData> createState() => _FavoriteDataState();
}

class _FavoriteDataState extends State<FavoriteData> {
  var user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Future deleteFavorite() async {
    final docFav =
    firestoreInstance.collection("users").doc(user?.uid).collection("favorites").doc(widget.docId);
    await docFav.delete();
    widget.c = widget.c - 1;
  }

  @override
  Widget build(BuildContext context) {
    bool like = true;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>RecipeInfo(
              instructions: widget.info!,
              url:widget.image!,
              title: widget.title!,
              time: widget.time!,
              cuisine: widget.cuisne,
            )
          )
        );
      }
      ,child: Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
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
            Colors.black.withOpacity(0.5),
            BlendMode.multiply,
          ),
          image: NetworkImage(widget.image!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.title! ,
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
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              like = !like;
                            });
                            if (like == false ) {
                              await deleteFavorite();
                            }
                          },
                          icon: Icon(
                            (like == false ? Icons.favorite_border : Icons.favorite),
                            color: Colors.red,
                            size: 25.0,
                          )
                      )
                    ],
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
                      Text(widget.time.toString() + " min"
                        ,style: TextStyle(
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
    ),
    );
  }
}