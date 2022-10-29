import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gobble_1/authentication.dart';
import 'package:gobble_1/profile1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gobble_1/login.dart';
import 'header drawer.dart';
import 'package:gobble_1/Drawer Pages/Dashboard.dart';
import 'package:gobble_1/Drawer Pages/AboutUs.dart';
import 'package:gobble_1/Drawer Pages/Settings.dart';
import 'package:gobble_1/Drawer Pages/LogOut.dart';




class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  var currentPage = DrawerSections.dashboard;

    @override
    Widget build(BuildContext context) {
      //var container;
      // if (currentPage == DrawerSections.dashboard) {
      //   container = DashboardPage();
      // } else if (currentPage == DrawerSections.profile) {
      //   container = Profile();
      // } else if (currentPage == DrawerSections.aboutus) {
      //   container = aboutus();
      // } else if (currentPage == DrawerSections.settings) {
      //   container = settings();
      // } else if (currentPage == DrawerSections.logout) {
      //   container = logout();
      // }
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
          tabBackgroundColor: Colors.brown.shade400,
            activeColor: Colors.white,
            padding: EdgeInsets.all(20),
            tabs:[
              GButton(icon: Icons.home,
                text: 'Home',
              ),
              GButton(icon: Icons.favorite_border,
                  text: 'Likes'),
              GButton(icon: Icons.search_outlined,
                  text: 'Search'
              ),
              GButton(icon: Icons.local_dining_outlined,
                text: 'Cuisine',
              ),
            ]
        ),

    );
  }



Widget MyDrawerList() {
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      // shows the list of menu drawer
      children: [
        menuItem(1, "Dashboard", Icons.dashboard_outlined,
            currentPage == DrawerSections.dashboard ? true : false),
        menuItem(2, "Profile", Icons.people_alt_outlined,
            currentPage == DrawerSections.profile ? true : false),
        menuItem(3, "About Us", Icons.event,
            currentPage == DrawerSections.aboutus ? true : false),
        menuItem(4, "Settings", Icons.notes,
            currentPage == DrawerSections.setting ? true : false),
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
                builder: (context)=>settings()));
          }else if (id == 5) {
           setState(() {
             AuthService().signOut();
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
}






