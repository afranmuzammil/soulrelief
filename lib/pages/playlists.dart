import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/pages/playListPages/AllPoetsPage.dart';
import 'package:soulrelief/pages/playListPages/albumsPage.dart';
import 'package:soulrelief/pages/playListPages/allDominesPage.dart';
import 'package:soulrelief/pages/playListPages/allSongs.dart';
import 'package:soulrelief/pages/playListPages/artists.dart';
import 'package:soulrelief/pages/playListPages/downloads.dart';
import 'package:soulrelief/pages/playListPages/likedSongsPage.dart';

import '../builders/gradienttext.dart';
import '../contollers/currentSongContoller.dart';
import '../models/initalizeHive.dart';
import '../widgets/recentcards.dart';

class PlayList extends StatelessWidget {
   PlayList({Key? key}) : super(key: key);
  final recentSongsHive = RecentSongHive.initRecentSongDataHive();
  final recentSongListHive = RecentSongListHive.initRecentSongListDataHive();
   final likedListHive = LikedListHive.initLikedListDataHive();
   CurrnetSongController currnetSongController = Get.put(CurrnetSongController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(

        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9,
                ],
                colors: [
                  Color(0Xff193B92),
                  Color(0Xff110D19),
                  Color(0Xff171F46),
                  Color(0Xff921985),
                ],
              )
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: false,
                pinned: false,
                floating: false,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace:
                LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {


                  return FlexibleSpaceBar(
                    centerTitle: true,
                    // title: Text("Tarana Portal",
                    //     style: TextStyle(
                    //       color: Colors.black54,
                    //       fontSize: 16.0,
                    //     ) //TextStyle
                    // ), //Text
                    background: Container(
                      height: height * 0.1,
                      width: width,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/Tarana- Voice of Islam.png",
                            ),
                            height: height * 0.12,
                            width: width * 0.3,
                          ),

                        ],
                      ),
                    ),
                  );
                }),
                // bottom: PreferredSize(
                //   preferredSize: const Size.fromHeight(30),
                //   child:
                // ),
                //FlexibleSpaceBar
                expandedHeight: height * 0.14,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),

                ], //<Widget>[]
              ),
              SliverList(delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(likedListHive.get("likedSongs")!.songID.isNotEmpty){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  LikedSongsPage()),
                            );
                          }
                        },
                        child: Container(
                          height: height*0.12,
                          width: width *0.40,
              //    alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient:LinearGradient(
                                colors: [Color(0xff721992), Color(0xffFF517B) ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                             //color: Colors.white,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.favorite,color:Colors.white,size: 35,),
                              Text("Liked By\n You!",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
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
                        },
                        child: Container(
                          height: height*0.12,
                          width: width *0.40,
                          //    alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient:LinearGradient(
                              colors: [Color(0xff19923B), Color(0xff33C1C1) ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            //color: Colors.white,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.folder_sharp,color:Colors.white,size: 35,),
                              Text("Your\n Downloads",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                  child: Container(
                    //color: Colors.cyan,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 0.0),

                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.1)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      // color: pictureBG,

                    ),
                    height: height*0.08,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AllSongsPage()),
                        );

                      },
                      leading: Icon(Icons.music_note,color: Colors.white ,),
                      title: Text("All Songs",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                  child: Container(
                    //color: Colors.cyan,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 0.0),

                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.1)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      // color: pictureBG,

                    ),
                    height: height*0.08,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AlbumsPage()),
                        );

                      },
                      leading: Icon(Icons.album,color: Colors.white ,),
                      title: Text("Albums",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                  child: Container(
                    //color: Colors.cyan,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 0.0),

                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.1)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      // color: pictureBG,

                    ),
                    height: height*0.08,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ArtistsPage()),
                        );

                      },
                      leading: Icon(Icons.mic_external_on_outlined,color: Colors.white ,),
                      title: Text("Artists",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                  child: Container(
                    //color: Colors.cyan,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 0.0),

                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.1)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      // color: pictureBG,

                    ),
                    height: height*0.08,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AllDominePages()),
                        );

                      },
                      leading: Icon(Icons.select_all,color: Colors.white ,),
                      title: Text("Domines",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 5,bottom: 5),
                  child: Container(
                    //color: Colors.cyan,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 0.0),

                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.1)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      // color: pictureBG,

                    ),
                    height: height*0.08,
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
                      leading: Icon(Icons.queue_music,color: Colors.white ,),
                      title: Text("My PlayList",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400),
                      ),

                    ),
                  ),
                ),


                Divider(),




                /*Container(
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
                ),*/




                Container(),
              ]))
            ],

          ),
        ));
  }
}
