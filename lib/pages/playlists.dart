import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/pages/playListPages/AllPoetsPage.dart';
import 'package:soulrelief/pages/playListPages/albumsPage.dart';
import 'package:soulrelief/pages/playListPages/allDominesPage.dart';
import 'package:soulrelief/pages/playListPages/allSongs.dart';
import 'package:soulrelief/pages/playListPages/artists.dart';
import 'package:soulrelief/pages/playListPages/downloads.dart';
import 'package:soulrelief/pages/playListPages/likedSongsPage.dart';

import '../widgets/recentcards.dart';

class PlayList extends StatelessWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.black87,))
        ],
        title: Text("Playlists",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold),
        ),
        leading: Container(
         child: Padding(
           padding: const EdgeInsets.only(left: 10.0),
           child: Image(
              image: AssetImage(
                "assets/tarnana.png",
              ),
              height: height * 0.12,
              width: width * 0.04,
            ),
         ),
        ),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 50.0, right: 170.0, bottom: 0.0),
                child: Text("Recent Activity",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xFF5F7185),
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: height * 0.16,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentCards(
                        songName: "Takzeeb mitane waale hum",
                        coverImageUrl: 'assets/hqdefault.png',
                      );
                    }),
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LikedSongsPage()),
                    );
                  },
                  leading: Icon(Icons.favorite),
                  title: Text("Liked Songs",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    const snackBar = SnackBar(
                      // padding:EdgeInsets.only(bottom: 10),

                      content: Text('Coming soon ',style: TextStyle(color: Colors.black),),
                      behavior: SnackBarBehavior.floating,
                      //      elevation: 10,
                      backgroundColor: Colors.white,
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      // action: SnackBarAction(
                      // //  label: 'Undo',
                      //   onPressed: () {
                      //     // Some code to undo the change.
                      //   },
                      // ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  DownloadsPage()),
                    // );
                  },
                  leading: Icon(Icons.download_sharp),
                  title: Text("Downloads",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AllSongsPage()),
                    );
                  },
                  leading: Icon(Icons.music_note),
                  title: Text("All Songs",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AlbumsPage()),
                    );
                  },
                  leading: Icon(Icons.album),
                  title: Text("Albums",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ArtistsPage()),
                    );
                  },
                  leading: Icon(Icons.mic_external_on_outlined),
                  title: Text("Artists",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AllPoetsPage()),
                    );
                  },
                  leading: Icon(Icons.mic_external_on_outlined),
                  title: Text("Poets",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AllDominePages()),
                    );
                  },
                  leading: Icon(Icons.select_all),
                  title: Text("Domines",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(
                //color: Colors.cyan,
                height: height*0.06,
                child: ListTile(
                  onTap: (){
                    const snackBar = SnackBar(
                     // padding:EdgeInsets.only(bottom: 10),

                      content: Text('Coming soon ',style: TextStyle(color: Colors.black),),
                      behavior: SnackBarBehavior.floating,
                //      elevation: 10,
                      backgroundColor: Colors.white,
                     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      // action: SnackBarAction(
                      // //  label: 'Undo',
                      //   onPressed: () {
                      //     // Some code to undo the change.
                      //   },
                      // ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  },
                  leading: Icon(Icons.queue_music),
                  title: Text("My PlayList",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              Divider(),
              Container(),
            ],
          ),
        ));
  }
}
