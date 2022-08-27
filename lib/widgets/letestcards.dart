import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../builders/gradienttext.dart';

class LatestCards extends StatelessWidget {
  const LatestCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: (){},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 6,
          child: SizedBox(
            height: height * 0.30,
            width: width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "LATEST TARANA",
                  style: TextStyle(
                      color: Color(0xFF5F7185),
                      fontSize: 10,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500),
                ),
                GradientText(
                  "Dhadakti hai jawan seeno me",
                  style: TextStyle(
                      color: Color(0xFF5F7185),
                      fontSize: 16,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold),
                  gradient: LinearGradient(colors: [
                    Color(0xffdf99da), Color(0xff668fd7)
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                  child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        height: height*0.14,
                        width: width*0.28,
                        decoration:  BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          // color: pictureBG,
                          image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/hidersiaf.png")
                            //NetworkImage(
                            //  "${Product.products[index].imageUrl}")
                            // CachedNetworkImageProvider(
                            //   items.body["featuredClothingItems"][index]["coverImage"]
                            //       .toString(),
                            // ),
                          ),
                        ),
                        // child: CachedNetworkImage(
                        //   placeholder: (context, imgUrl) => const Text("Image is loading"),
                        //   imageUrl: products.body["items"][index]["coverImage"].toString(),
                        // ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(

                            children: [
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF5F7185),
                                    fontSize: 10,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Artist",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF5F7185),
                                    fontSize: 10,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Haider Saifullah",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF5F7185),
                                    fontSize: 10,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      print("You pressed Icon Elevated Button");
                    },
                    icon: Icon(Icons.play_arrow),  //icon data for elevated button
                    label: Text("Play now"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                     //   fixedSize: const Size(300, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      print("onClick");
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),

                    ),
                    //padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.playlist_add,
                          color: Color(0xFF5F7185),
                          size: 20,
                        ),
                        Text(
                          "Add to Playlist",
                          style: TextStyle(
                              color: Color(0xFF5F7185),
                              fontSize: 10,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500),
                        )

                      ],
                    ),
                  ),


                ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
