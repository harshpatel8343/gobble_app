// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeInfo extends StatelessWidget {
  String instructions,url,title,time;
  String? cuisine;
   RecipeInfo({Key? key, required this.instructions,required this.url,required this.title,required this.time,required this.cuisine}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.fromLTRB(15,7, 15, 7),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
              style: GoogleFonts.alfaSlabOne(textStyle:TextStyle(
                fontSize: 20,fontWeight: FontWeight.w100,
                color: Colors.brown[600]
              )),
              ),
              SizedBox(height: 5),
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.brown.withOpacity(0.35),
                      BlendMode.multiply,
                    ),
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
             SizedBox(height: 10),
           Row(
             children: [
               Icon(Icons.restaurant_menu,color: Colors.orange,size: 32,),
               SizedBox(width:5),
               Text(cuisine == null ? " " : "Cuisine",
                 style:TextStyle(
                   fontWeight: FontWeight.bold,
                   letterSpacing: 2,
                   fontSize: 22,
                   color: Colors.brown[600],
                   decoration: TextDecoration.underline,
                 ),
               ),
             ],
           ),
              Text(cuisine == null ? "" : "     "+cuisine!.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
             SizedBox(height: 10),
             Row(
               children: [
                 Icon(Icons.timer_outlined,color: Colors.orange,size: 25),
                 SizedBox(width:5),
                 Text('Preparation time:'
                   ,style: TextStyle(
                     fontWeight: FontWeight.bold,
                     letterSpacing: 2,
                     fontSize: 22,
                     color: Colors.brown[600],
                     decoration: TextDecoration.underline,
                   ),
                 ),
               ],
             ),
              Text("      "+time+" minutes",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
             Row(
               children: [
                 Icon(Icons.edit_note,color: Colors.orange,size: 34),
                 SizedBox(width:5),
                 Text('Instructions:'
                   ,style: TextStyle(
                     fontWeight: FontWeight.bold,
                     letterSpacing: 2,
                     fontSize: 22,
                     color: Colors.brown[600],
                     decoration: TextDecoration.underline,
                   ),
                 ),
               ],
             ),
             Text(instructions,
               style: TextStyle(
               fontSize: 18,
              ),
             ),
            ],
          ),
        ),
      ),

    );
  }
}

