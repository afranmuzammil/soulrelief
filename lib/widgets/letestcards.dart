import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../builders/gradienttext.dart';
import '../contollers/currentSongContoller.dart';
import '../pages/flotingAudio.dart';
import '../pages/songpage.dart';

class LatestCards extends StatelessWidget {
  LatestCards({Key? key, required this.songName, required this.artistName, required this.lyrics, required this.SongID})
      : super(key: key);

  final String songName;
  final String artistName;
  final String lyrics;
  final String SongID;
  CurrnetSongController currnetSongController = Get.put(CurrnetSongController());

  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;



    void showOverlay() {
      entry = OverlayEntry(
          builder: (context) => Positioned(
                left: 10,
                right: 10,
                bottom: 30,
             //   top: 60,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(
                    height: 50,
                    width: 100,
                    color: Colors.green,
                  ),
                )
              ));
      final overlay = Overlay.of(context)!;
      overlay.insert(entry!);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // showOverlay();

        },
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
                  songName ?? "Dhadakti hai jawan seeno me",
                  style: TextStyle(
                      color: Color(0xFF5F7185),
                      fontSize: 16,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold),
                  gradient: LinearGradient(colors: [Color(0xffdf99da), Color(0xff668fd7)]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        height: height * 0.14,
                        width: width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          // color: pictureBG,
                          image: DecorationImage(
                              fit: BoxFit.fill, image: AssetImage("assets/hidersiaf.png")
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
                                lyrics ??
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF5F7185),
                                    fontSize: 10,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(),
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
                                artistName ?? "Haider Saifullah",
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
                      onPressed: () {
                        print("You pressed Icon Elevated Button");
                        currnetSongController.updateCurrentSong(SongID);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>  SongPage(songID: SongID,)),
                        // );
                      },
                      icon: Icon(Icons.play_arrow), //icon data for elevated button
                      label: Text("Play now"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          //   fixedSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        print("onClick");
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:  GradientText('Coming Soon',  gradient: LinearGradient(colors: [Color(0xffdf99da), Color(0xff668fd7)]),),
                            content: const Text('Custom Playlist will be coming soon'),
                            actions: <Widget>[

                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const GradientText('OK',  gradient: LinearGradient(colors: [Color(0xffdf99da), Color(0xff668fd7)]),),
                              ),
                            ],
                          ),
                        );

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
