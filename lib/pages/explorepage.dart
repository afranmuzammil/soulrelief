import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../builders/gradienticon.dart';
import '../widgets/domainsbox.dart';
import '../widgets/poetscards.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.2,
                  width: width,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/tarnana.png",
                        ),
                        height: height * 0.12,
                        width: width * 0.3,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 0.0, top: 0.0, right: 250.0, bottom: 0.0),
                  child: Text("Domains",
                      textAlign:TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF5F7185),
                          fontSize: 16,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  height: height*0.36,
                  //color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                        crossAxisCount: 3,
                      children: [
                        DomainsCards(imageLink: "assets/hamd.png", dominName: "Hamd"),
                        DomainsCards(imageLink: "assets/quran.png", dominName: "Quran"),
                        DomainsCards(imageLink: "assets/naat.png", dominName: "Naat"),
                        DomainsCards(imageLink: "assets/tanzimi.png", dominName: "Tanzeemi"),
                        DomainsCards(imageLink: "assets/akhirath.png", dominName: "Akhirath"),
                        DomainsCards(imageLink: "assets/youth.png", dominName: "Youth"),
                      ]
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 0.0, top: 0.0, right: 190.0, bottom: 0.0),
                  child: Text("Explore by Poets",
                      textAlign:TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF5F7185),
                          fontSize: 16,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w600)
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(

                  height: height*0.16,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context,int index){
                        return  PoetsCards(poetImageLink: 'assets/Allama Iqbal.png', poetName: 'Allama Iqbal',);
                      }),
                ),
               // PoetsCards(poetImageLink: 'assets/Allama Iqbal.png', poetName: 'Allama Iqbal',)
                Padding(
                  padding:
                  const EdgeInsets.only(left: 0.0, top: 8.0, right: 220.0, bottom: 0.0),
                  child: Text("Latest tarane",
                      textAlign:TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF5F7185),
                          fontSize: 16,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w600)
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                      onTap: (){},
                    leading: RadiantGradientMask(child: Icon(Icons.play_arrow,color: Colors.white,size: 38,)),
                    title: Text("Takzeeb mitane waale hum",style: TextStyle(
                        color: Color(0xFF5F7185),
                        fontSize: 13,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w300),),
                    trailing:      IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                      onTap: (){},
                    leading: RadiantGradientMask(child: Icon(Icons.play_arrow,color: Colors.white,size: 38,)),
                    title: Text("Dhadakti hai jawan seeno me",style: TextStyle(
                        color: Color(0xFF5F7185),
                        fontSize: 13,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w300),),
                    trailing:      IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: (){},
                    leading: RadiantGradientMask(child: Icon(Icons.play_arrow,color: Colors.white,size: 38,)),
                    title: Text("Meri SIO Meri SIO",style: TextStyle(
                        color: Color(0xFF5F7185),
                        fontSize: 13,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w300),),
                    trailing:      IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
                  ),
                ),

                SizedBox(height: 10.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}