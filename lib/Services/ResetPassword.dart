import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Password reset link sent!\nKindly check your email"),
        );
      });
    } on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
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
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter your Email ID and we will send you a password reset link",
            textAlign: TextAlign.center,
              style:TextStyle(
                fontSize: 18
              ) ,
            ),
          ),
          SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Email",
                fillColor: Colors.grey[300],
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 15),
          MaterialButton(onPressed: passwordReset,
          child: Text('Reset password'),
            color: Colors.brown[200],
          )
        ],
      ),
    );
  }
}
