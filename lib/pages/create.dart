import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gobble_1/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';

class create1 extends StatefulWidget {
  const create1({Key? key}) : super(key: key);

  @override
  State<create1> createState() => _create1State();
}

class _create1State extends State<create1> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  var value;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }
 String email='',pass='', name='',phone='';
  String? docID='';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg9.jpg'),fit: BoxFit.cover)
      ),
      child: Scaffold(
        key: _scaffoldKey,
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
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                         controller: _nameController,
                        onChanged:(value){
                          name=value;
                        } ,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Name',
                            filled: true,
                            fillColor: Colors.brown[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        // controller: _emailController,
                          validator: MultiValidator(
                            [
                              EmailValidator(errorText: 'Enter a valid email address'),
                            ]
                          ),
                        onChanged:(value){
                          email=value;
                        } ,
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
                        controller: _phoneController,
                        onChanged:(value){
                          phone=value;
                        } ,
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: " "'*Required'),
                            PatternValidator(r'^[0-9]+$', errorText:'Enter a valid number'),
                            MaxLengthValidator(10, errorText: 'Enter a valid number'),
                            MinLengthValidator(10, errorText: 'Enter a valid number')
                        ]
                        ),
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
                        // controller: _passwordController,
                        validator: MultiValidator(
                          [
                            MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Password must have at least one special character')
                          ]
                        ),
                        onChanged:(value){
                          pass=value;
                        } ,
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
                        validator: (val)=>
                            MatchValidator(errorText: 'Passwords do not match').validateMatch(val!, pass),
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
                              onPressed:(){
                                EmailSignUp();
                              },
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



  Future EmailSignUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass);
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('users').
      doc(user?.uid).set(
          {
            "name":name,
            "number": phone,
            "mail": email,
            "userID": user?.uid,
          }
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

Stream<List<Users>> readUsers() => FirebaseFirestore.instance
    .collection("users")
    .snapshots()
    .map((snapshot) =>
    snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

Future createUser(Users user) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc();
  user.id = docUser.id;
  final json = user.toJson();
  await docUser.set(json);
}


class Users {
  String id;
  final String name;
  final String mail;
  final String contact;

  Users({
    this.id = '',
    required this.mail,
    required this.name,
    required this.contact,
  });

  Map<String, dynamic> toJson() => {
    'userID': id,
    'name': name,
    'mail': mail,
    'contact': contact,
  };

  static Users fromJson(Map<String, dynamic> json) => Users(
    name: json["name"],
    mail: json["mail"],
    contact: json["contact"],
    id: json["userID"],
  );
}

