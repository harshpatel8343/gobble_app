// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gobble_1/Services/ResetPassword.dart';
import 'package:gobble_1/pages/favorites.dart';
import 'package:gobble_1/Services/google_sign_in.dart';
import 'package:gobble_1/pages/search_bar.dart';
import 'package:gobble_1/Drawer%20Pages/profile1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gobble_1/pages/login.dart';
import 'package:provider/provider.dart';
import '../Services/RecipeInfo.dart';
import '../Services/recipe.api.dart';
import '../Services/recipe.dart';
import '../Services/favs.dart';
import '../Drawer Pages/header drawer.dart';
import 'package:gobble_1/Drawer Pages/Dashboard.dart';
import 'package:gobble_1/Drawer Pages/AboutUs.dart';
import 'Cuisine.dart';

class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  var currentPage = DrawerSections.dashboard;

   List<Recipes> _recipeslist = [];

  getRecipeData() async{
    _recipeslist = await RecipeApi().getRecipe()!;
  }

  // @override
  // void initState() {
  //   getRecipeData();
  //   super.initState();
  // }

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
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: GNav(
          onTabChange: (index){
            if(index==0){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>UI()));
            }
            if(index==1){
              showSearch(context: context, delegate: SearchUser());

            }
            if(index==2){

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>Cuisine()));
            }
            if(index==3){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>Favorite()));
            }
          },
          tabBackgroundColor: Colors.brown.shade400,
            activeColor: Colors.white,
            padding: EdgeInsets.all(20),
            tabs:[
              GButton(icon: Icons.home,
                text: 'Home',
              ),
              GButton(icon: Icons.search_outlined,
                  text: 'Search',
              ),
              GButton(icon: Icons.local_dining_outlined,
                text: 'Cuisine',
              ),
              GButton(icon: Icons.favorite_border,
                  text: 'Favorites',
              ),
            ],
          ),
      body: FutureBuilder(
          future: getRecipeData(),
          builder:(context, snapshot){
        if(snapshot.connectionState== ConnectionState.waiting)
          {
            return Center(
             child: CircularProgressIndicator(),
            );
          }
        else{
           return ListView.builder(
             shrinkWrap: true,
             itemCount: _recipeslist.length,
             itemBuilder: (BuildContext context, int index) {
               return RecipeCard(
                   title: _recipeslist[index].title,
                   readyInMinutes: _recipeslist[index].readyInMinutes.toString(),
                   thumbnailUrl: _recipeslist[index].image,
                   instructions: _recipeslist[index].instructions,
                   cuisine: _recipeslist[index].cuisines.toString(),
                   c: 0,
                   docID: '', );
               },
             );
           }
        },
      )
    );
  }

Widget MyDrawerList() {
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      children: [
        menuItem(1, "Dashboard", Icons.dashboard_outlined,
            currentPage == DrawerSections.dashboard ? true : false),
        menuItem(2, "Profile", Icons.people_alt_outlined,
            currentPage == DrawerSections.profile ? true : false),
        menuItem(3, "About Us", Icons.event,
            currentPage == DrawerSections.aboutus ? true : false),
        menuItem(4, "Reset Password", Icons.key_outlined,
            currentPage == DrawerSections.reset ? true : false),
        Divider(),
        menuItem(5, "Log Out", Icons.settings_outlined,
            currentPage == DrawerSections.logout ? true : false),
      ],
    ),
  );
}

Widget menuItem(int id, String title, IconData icon, bool selected) {
  return Material(
    color: selected ? Colors.grey[300] : Colors.transparent,
    child: InkWell(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          if (id == 1) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>DashboardPage()));
          } else if (id == 2) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>Profile()));;
          } else if (id == 3) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>aboutus()));
          } else if (id == 4) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>ResetPassword()));
          }else if (id == 5) {
           setState(() async{
             final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
             provider.logOut();
             await FirebaseAuth.instance.signOut();
             Navigator.of(context).push(MaterialPageRoute(
                 builder: (context)=>Login()));
           });
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
enum DrawerSections {
  dashboard,
  profile,
  aboutus,
  settings,
  logout,
  setting,
  reset,
}

class RecipeCard extends StatefulWidget {
  final String? cuisine;
  final String title;
  final String readyInMinutes;
  final String thumbnailUrl;
  final String instructions;
  int c;
  String docID;
  RecipeCard({
    required this.title,
    required this.readyInMinutes,
    required this.thumbnailUrl,
    required this.instructions,
    required this.c,
    required this.docID,
    required this. cuisine,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool like=false;
  String? docID;
  var user=FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Future createFavorite(Favs fav) async {
    final docFav = firestoreInstance.collection("users").
    doc(user?.uid).collection("favorites").doc();
    fav.id = docFav.id;
    docID = fav.id;
    final json = fav.toJson();
    await docFav.set(json);
    widget.c = widget.c + 1;
  }

  void deleteFavorite() async {
    final docFav =
    firestoreInstance.collection("users").doc(user?.uid).collection("favorites").doc(docID);
    await docFav.delete();
    widget.c = widget.c - 1;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>RecipeInfo(
              instructions: widget.instructions,
              url:widget.thumbnailUrl,
              title: widget.title,
              time: widget.readyInMinutes,
              cuisine: widget.cuisine,
            )));
      }
      ,child: Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(widget.thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.title ,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: () async{
                        setState(() {
                          like=!like;
                        });

                        if(like==true && widget.c==0){
                         createFavorite(Favs(
                             id: widget.docID,
                             title:widget.title,
                             time:widget.readyInMinutes,
                             image: widget.thumbnailUrl,
                             info: widget.instructions,
                             cuisine: widget.cuisine
                         ));
                        }
                        if (like == false && widget.c > 0) {
                          deleteFavorite();
                        }

                      },
                          icon: Icon(
                            (like==false? Icons.favorite_border:Icons.favorite),
                            color: Colors.red,
                            size: 25.0,
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(widget.readyInMinutes.toString()+" min"
                        ,style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    ),
    );
  }
}

