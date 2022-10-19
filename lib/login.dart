import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gobble_1/pages/create.dart';
import 'package:gobble_1/profile1.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey=GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg3.jpg'),fit: BoxFit.cover)
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 80, 0, 0),
              child: Text('Welcome\nback!',
                style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                  fontSize: 45,fontWeight: FontWeight.w100,color: Colors.brown[600],
                )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4,
              right: 35, left: 35
              ),
              child: SingleChildScrollView(
                child: Form(

                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                          labelText: 'Email ID',
                          filled: true,
                            fillColor: Colors.brown[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),

                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            fillColor: Colors.brown[50],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),

                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text('Log in',
                          style: TextStyle(
                            color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500
                          ),
                          ),
                          SizedBox(width: 150),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.brown[600],
                            child: IconButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>Profile()),
                              );
                            },
                                icon: Icon(Icons.arrow_forward, size: 30),
                              color: Colors.white,
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('not yet created an account?',
                          style: TextStyle(
                            color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400
                          ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                                return Create();
                              }),);
                            });
                          },
                              child: Text('Sign Up',
                              style: TextStyle(
                                color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: 20,decoration: TextDecoration.underline
                              ),
                              ),
                          ),
                          TextButton(onPressed: (){
                            setState(() {});
                          },
                            child: Text('Forgot password',
                              style: TextStyle(
                                  color: Colors.black,fontWeight: FontWeight.bold,
                                  fontSize: 17,decoration: TextDecoration.underline
                              ),
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}


