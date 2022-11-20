import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        centerTitle:true,
        title:Text('About us',
          style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
            fontSize: 22,fontWeight: FontWeight.w100,color: Colors.white,
          )),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Last year, we all spent a lot of time on our cell phones searching for recipes. Our new normal has led us to get in touch with our inner chefs. We also learned that searching for recipes via the web on your mobile device can be a laborious task in and of itself. Nine times out of ten, when you find a recipe that looks good, you’re directed to a food blog where you have to scroll through pages of the author’s story about the dish’s history, where they got the ingredients, what the food means to them, and other SEO filler. If you haven’t realized it by now, this is where Gobble come in very handy. We have an extensive recipe archive created by in-house chefs. You can even save your favorite recipes and watch it at your own convenience. You can search among thousands of our recipes and fulfill your cravings.Now that you’ve got all the recipes you need, make sure you have all the essential kitchen tools you need to get cooking! ',
            style: TextStyle(
              fontSize: 20
            ),
            ),
          ),
          Text('Want something to eat?\njust GOBBLE it!',
            style:GoogleFonts.alfaSlabOne(textStyle: TextStyle(
              fontSize: 22,fontWeight: FontWeight.normal,color: Colors.brown[300],
            )),
          ),
        ],
      ),
    );
  }
}

