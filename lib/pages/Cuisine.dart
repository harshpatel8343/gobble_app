import 'package:flutter/material.dart';
import 'package:gobble_1/pages/CuisineList.dart';
import 'package:google_fonts/google_fonts.dart';

class Cuisine extends StatefulWidget {
  const Cuisine({Key? key}) : super(key: key);

  @override
  State<Cuisine> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisine> {
  List<String> cuisinesList = [
    "Indian",
    "Thai",
    "Chinese",
    "Japanese",
    "Mexican",
    "Italian",
    "Mediterranean"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          centerTitle:true,
          title:Text('Cuisines ',
            style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
              fontSize: 22,fontWeight: FontWeight.normal,color: Colors.white,letterSpacing: 2
            )),
          ),
        ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            CuisineCard(title: cuisinesList[0], image: 'assets/indian_food.jpg'),
            CuisineCard(title: cuisinesList[1], image:'assets/thai.jpg' ),
            CuisineCard(title: cuisinesList[2], image:'assets/chinese.jpg'),
            CuisineCard(title: cuisinesList[3], image: 'assets/japanese.jpg'),
            CuisineCard(title: cuisinesList[4], image:'assets/mexican.jpeg'),
            CuisineCard(title: cuisinesList[5], image: 'assets/italian.jpg'),
            CuisineCard(title: cuisinesList[6], image:'assets/Mediterranean.jpg' ),
          ],
        ),
      )
      
    );
  }
}


class CuisineCard extends StatefulWidget {
  const CuisineCard({Key? key,required this.title,required this.image}) : super(key: key);
final String title;
final String image;
  @override
  State<CuisineCard> createState() => _CuisineCardState();
}

class _CuisineCardState extends State<CuisineCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>CuisineDisplay(name: widget.title)));
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
          image: AssetImage(widget.image),
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
                style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                    fontSize: 25,fontWeight: FontWeight.normal,color: Colors.white,letterSpacing: 2
                )),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    ),
    );
  }
}
