import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/pages/playListPages/AllPoetsPage.dart';
import 'package:soulrelief/pages/playListPages/albumsPage.dart';
import 'package:soulrelief/pages/playListPages/allDominesPage.dart';
import 'package:soulrelief/pages/playListPages/allSongs.dart';
import 'package:soulrelief/pages/playListPages/artists.dart';
import 'package:soulrelief/pages/playListPages/downloads.dart';
import 'package:soulrelief/pages/playListPages/likedSongsPage.dart';

import '../builders/gradienttext.dart';
import '../models/initalizeHive.dart';
import '../widgets/recentcards.dart';

class PlayList extends StatelessWidget {
   PlayList({Key? key}) : super(key: key);
  final recentSongsHive = RecentSongHive.initRecentSongDataHive();
  final recentSongListHive = RecentSongListHive.initRecentSongListDataHive();

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
                child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentSongListHive.get("recentSongs")?.songID.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentCards(
                        songName: "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songName}",
                        coverImageUrl: 'assets/hqdefault.png',
                        songId: "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songID}",
                        artistName: "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.artistName}",
                      );
                    })
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
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:  GradientText('Coming Soon',  gradient: LinearGradient(colors: [Color(0xffdf99da), Color(0xff668fd7)]),),
                        content: const Text('Downloading of songs is Coming soon'),
                        actions: <Widget>[

                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const GradientText('OK',  gradient: LinearGradient(colors: [Color(0xffdf99da), Color(0xff668fd7)]),),
                          ),
                        ],
                      ),
                    );
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
