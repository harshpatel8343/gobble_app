import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gobble_1/login.dart';


class create1 extends StatefulWidget {
  const create1({Key? key}) : super(key: key);

  @override
  State<create1> createState() => _create1State();
}

class _create1State extends State<create1> {
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
              padding: EdgeInsets.fromLTRB(20, 60, 0, 0),
              child: Text('Create your\naccount !',
                style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                  fontSize: 28,fontWeight: FontWeight.normal,color: Colors.brown[600],
                )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25,
                  right: 35, left: 35
              ),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(

                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email ID',
                            filled: true,
                            fillColor: Colors.brown[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),


                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: 'Contact',
                            fillColor: Colors.brown[50],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),

                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Password',
                            fillColor: Colors.brown[50],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Confirm password',
                            fillColor: Colors.brown[50],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Get Started',
                              style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown[400],
                              )),
                            ),
                            SizedBox(width: 10),
                            FloatingActionButton(
                              onPressed: (){},
                              backgroundColor: Colors.brown[600],
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 30),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
