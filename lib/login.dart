import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gobble_1/authentication.dart';
import 'package:gobble_1/pages/UI.dart';
import 'package:gobble_1/pages/google_sign_in.dart';
import 'package:gobble_1/pages/new create.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) =>  ChangeNotifierProvider(
    create: (context)=> GoogleSignInProvider(),
    child: Scaffold(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
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
                                    builder: (context)=>UI()),
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>create1()));
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    minimumSize: Size(40, 50),
                                  ),
                                    icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
                                    label: Text('Sign up with Google'),
                                    onPressed: (){
                                    setState(() {
                                      AuthService().signInWithGoogle();
                                    });
                                    },
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
      ),
  );

}


