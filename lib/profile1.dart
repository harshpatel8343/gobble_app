import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gobble_1/login.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg9.jpg'),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15,left: 15,right: 15),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(child: Icon(Icons.person),
                      radius:35,
                        backgroundColor: Colors.brown,
                      )
                    ],
                  ),
                  SizedBox(height: 35),
                  Text('NAME:',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold,color: Colors.brown[400],
                    )),
                  ),
                  SizedBox(height: 5),
                  Text('Harsh',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown,
                    )),
                  ),
                  SizedBox(height: 20),
                  Text('Cuisine:',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold,color: Colors.brown[400],
                    )),
                  ),
                  SizedBox(height: 5),
                  Text('Vegetarian',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown,
                    )),
                  ),
                  SizedBox(height: 20),
                  Text('CONTACT:',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold,color: Colors.brown[400],
                    )),
                  ),
                  SizedBox(height: 5),
                  Text('8828226025',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown,
                    )),
                  ),
                  SizedBox(height: 20),
                  Text('MAIL ID:',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold,color: Colors.brown[400],
                    )),
                  ),
                  SizedBox(height: 5),
                  Text('harshpatel12@gmail.com',
                    style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown,
                    )),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,30,0),
                        child: FloatingActionButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>Login()),
                          );
                        },
                          backgroundColor: Colors.brown[800],
                          child: Icon(Icons.arrow_forward_ios,
                              size: 30),
                        ),
                      ),
                    ],
                  )
                ],
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
