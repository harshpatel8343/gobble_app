import 'package:flutter/material.dart';
import 'package:gobble_1/pages/UI.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gobble_1/login.dart';
import 'package:firebase_auth/firebase_auth.dart';



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
                      CircleAvatar(backgroundImage: NetworkImage('FirebaseAuth.instance.currentUser!.photoURL!'),
                      radius:35,
                        //backgroundColor: Colors.brown,
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
                  Text(FirebaseAuth.instance.currentUser!.displayName!,
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
                  Text(FirebaseAuth.instance.currentUser!.phoneNumber!,
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
                  Text(FirebaseAuth.instance.currentUser!.email!,
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
                              builder: (context)=>UI()),
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
