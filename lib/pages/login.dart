import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gobble_1/Services/ResetPassword.dart';
import 'package:gobble_1/Services/google_sign_in.dart';
import 'package:gobble_1/pages/create.dart';
import 'package:provider/provider.dart';
import 'UI.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email='',pass='';
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
                padding: EdgeInsets.fromLTRB(20, 110, 0, 0),
                child: Text('Welcome\nback!',style: TextStyle(
                    fontSize: 47,fontWeight: FontWeight.w200,color: Colors.brown[600],
                  ),
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
                          onChanged:(value){
                            email=value;
                          } ,
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
                          onChanged:(value){
                            pass=value;
                          } ,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>ResetPassword()));
                            },
                              child: Text('Forgot password',
                                style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,
                                    fontSize: 15,decoration: TextDecoration.underline
                                ),
                              ),

                            ),
                          ],
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
                              child: IconButton(onPressed: ()async {
                                try {
                                  FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: email, password: pass);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=>UI()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    print('Wrong password provided for that user.');
                                  }
                                }
                              },
                                  icon: Icon(Icons.arrow_forward, size: 30),
                                color: Colors.white,
                              )
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400
                            ),
                            ),
                            TextButton(onPressed: (){
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>create1()));
                              });
                            },
                              child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,
                                    fontSize: 17,decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
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
                                    setState(() async{
                                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                    await provider.googleLogin();
                                    if(FirebaseAuth.instance.currentUser!=null)
                                      {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context)=>UI()));
                                      }
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


