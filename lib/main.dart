
import 'package:flutter/material.dart';
import 'package:gobble_1/Services/authentication.dart';
import 'package:gobble_1/Services/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg4.jpg'), fit:BoxFit.cover )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_zakgeffb.json',
                       repeat: false,
                      height: 350
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0),
              Text('G O B B L E ',
              style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                fontSize: 50,fontWeight: FontWeight.bold,color: Colors.brown[600],
              )),
              ),
              SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,30,0),
                    child: FloatingActionButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>AuthService().handleAuthState()),
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
          ),
        ),
      ),
    );
  }
}



Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

