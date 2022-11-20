import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gobble_1/pages/create.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

String contact='';
String mail = '';
String name='';
final user = FirebaseAuth.instance.currentUser!;
final userCollection = FirebaseFirestore.instance.collection('users');

Future <List<String>> getUserData() async {
  DocumentSnapshot data = await userCollection.doc(user.uid).get();
  name = data.get("name");
  mail = data.get("mail");
  return [name, contact, mail];
}

Stream <List<Users>> readUserData() {
  return FirebaseFirestore.instance.collection("users").snapshots().map(
          (snapshot) =>
          snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
}


class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder(
        future: getUserData(),
        builder: (context,snapshot){
      if (snapshot.connectionState == ConnectionState.waiting)
        return Center(
          child: CircularProgressIndicator(),
        );
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        // decoration: BoxDecoration(
        //     image: DecorationImage(image: AssetImage('assets/bg9.jpg'),fit: BoxFit.cover)
        // ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown[300],
            centerTitle:true,
            title:Text('Profile ',
              style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                fontSize: 22,fontWeight: FontWeight.normal,color: Colors.white,
              )),
              textAlign: TextAlign.start,
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06,left: 15,right: 15),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        user.photoURL == null
                            ? CircleAvatar(
                            radius: 45,
                            backgroundImage:
                            AssetImage("assets/profile.png"))
                            : CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Text('NAME:',
                      style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                        fontSize: 25,fontWeight: FontWeight.w100,color: Colors.brown[400],letterSpacing:2,
                      )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      (user.displayName == null ? name : user.displayName!),
                      style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown[300],
                      )),
                    ),
                    SizedBox(height: 20),
                    Text('CONTACT:',
                      style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                        fontSize: 25,fontWeight: FontWeight.w100,color: Colors.brown[400],letterSpacing:2,
                      )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      contact.toString(),
                      style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown[300],
                      )),
                    ),
                    SizedBox(height: 20),
                    Text('MAIL ID:',
                      style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                        fontSize: 25,fontWeight: FontWeight.w100,color: Colors.brown[400],letterSpacing:2,
                      )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      (user.email == null ? mail : user.email!),
                      style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.normal,color: Colors.brown[300],
                      )),
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0,0,30,0),
                        //   child: FloatingActionButton(onPressed: (){
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context)=>UI()),
                        //     );
                        //   },
                        //     backgroundColor: Colors.brown[800],
                        //     child: Icon(Icons.arrow_forward_ios,
                        //         size: 30),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ) ,
              ),
            ],
          ),
        ),
      );
    },
    );
  }
}
