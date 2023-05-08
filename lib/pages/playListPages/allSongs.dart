import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../builders/gradienticon.dart';
import '../../builders/gradienttext.dart';
import '../../contollers/currentSongContoller.dart';
import '../../models/StorageModel.dart';
import '../../models/initalizeHive.dart';
import '../../models/songStorageModel.dart';
import '../home.dart';
import '../songpage.dart';

class AllSongsPage extends StatefulWidget {
  const AllSongsPage({Key? key}) : super(key: key);

  @override
  State<AllSongsPage> createState() => _AllSongsPageState();
}

class _AllSongsPageState extends State<AllSongsPage> {
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  final currentPlayListHive = CurrentPlayListHive.initCurrentPlayListDataHive();
  final CurrentSongHive = SingleSongHive.initSingleSongDataHive();
  List<String> addinginList = [];
  CurrnetSongController currnetSongController = Get.put(CurrnetSongController());
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        /*appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.black87,))
          ],
          title: GradientText(
            "All Songs",
            style: TextStyle(
                color: Color(0xFF5F7185),
                fontSize: 20,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold),
            gradient: LinearGradient(colors: [
              Color(0xffdf99da), Color(0xff668fd7)
            ]),
          ),
          leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,), onPressed: () {
            Navigator.of(context).pop();
          },),
          centerTitle: true,
        ),*/
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
                leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () {
                  Navigator.of(context).pop();
                },),
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
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: db.collection('AllSongsList').snapshots(),
                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          //  print("firebase data ${snapshot.data!.docs.map((e) => e.data() as Map<String,dynamic>).toList()}");
                          print("firebase data ${snapshot.data!.docs.map((e)=>json.decode(json.encode(e.data()))).toList()}");
                          snapshot.data!.docs.map((e)=>json.decode(json.encode(e.data()))).toList();
                          return ListView(
                            physics :NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((doc) => GestureDetector(
                              onTap: (){
                                final singleSong = SingleSong(
                                  doc["song_id"].toString(),
                                  doc["poet_name"].toString(),
                                  doc["album_name"].toString(),
                                  doc["singer_name"].toString(),
                                  doc["audio_length"].toString(),
                                  doc["song_name"].toString(),
                                  doc["composed_by"].toString(),
                                  doc["audio_image"].toString(),
                                  doc["song_id"].toString(),
                                  doc["lyrics"],
                                  doc["domine_name"].toString(),
                                );
                                CurrentSongHive.put("currentSong", singleSong);
                                currnetSongController.updateCurrentSong(
                                  doc["song_id"].toString(),
                                  doc["poet_name"].toString(),
                                  doc["album_name"].toString(),
                                  doc["singer_name"].toString(),
                                  doc["audio_length"].toString(),
                                  doc["song_name"].toString(),
                                  doc["composed_by"].toString(),
                                  doc["audio_image"].toString(),
                                  doc["song_id"].toString(),
                                  doc["lyrics"],
                                  doc["domine_name"].toString(),
                                );
                                List<dynamic> Songs = snapshot.data!.docs.map((e) => e.data()).toList();
                                List<String> SongsString = Songs.map((e) => e.toString()).toList();
                                final allSongs = CurrentPlayList(SongsString);
                                currentPlayListHive.put("currentPlayList", allSongs);
                              },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomListTile(

                              leading: Container(
                                    height: height*0.06,
                                    width: width*0.12,
                                    decoration:  BoxDecoration(

                                      borderRadius: BorderRadius.all(Radius.circular(0)),
                                      // color: pictureBG,
                                      image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/TPicon.png')
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
                              title: doc["song_name"].toString(),
                              subtitle: "${doc["singer_name"].toString()} • ${doc["audio_length"].toString()}",
                              trailing: Container(
                                    width: width * 0.5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (addinginList.contains(
                                                currnetSongController.currentSongID) ==
                                                false) {
                                              final songData = LikedSong(
                                                  "${currnetSongController.currentsongName}",
                                                  "${currnetSongController.currentSongID}",
                                                  "${currnetSongController.currentartistName}",
                                                  "${currnetSongController.currentaudioLength}",
                                                  "${currnetSongController.currentaudioImage}",
                                                  "${currnetSongController.currentpoetName}",
                                                  "${currnetSongController.currentalbumName}",
                                                  "${currnetSongController.currentcomposedBy}",
                                                  "${currnetSongController.currentaudioFileSize}",
                                                  "${currnetSongController.currentlyrics}",
                                                  "${currnetSongController.currentdomineName}");
                                              likedSongsHive
                                                  .put("${currnetSongController.currentSongID}",
                                                  songData)
                                                  .then((value) {
                                                setState(() {
                                                  addinginList.add(
                                                      "${currnetSongController.currentSongID}");
                                                });

                                                final SongId = LikedList(addinginList);
                                                likedListHive.put("likedSongs", SongId);
                                              });
                                            }
                                            if (addinginList.contains(
                                                currnetSongController.currentSongID) ==
                                                true) {
                                              likedSongsHive
                                                  .delete(currnetSongController.currentSongID)
                                                  .then((value) {
                                                setState(() {
                                                  addinginList.remove(
                                                      "${currnetSongController.currentSongID}");
                                                });

                                                final SongId = LikedList(addinginList);
                                                likedListHive.put("likedSongs", SongId);
                                              });
                                            }
                                          },
                                          icon: addinginList
                                              .contains(currnetSongController.currentSongID)
                                              ? RadiantGradientMask(
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                          )
                                              : Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          icon: RadiantGradientMask(
                                              child: Icon(
                                                Icons.play_circle_filled_rounded,
                                                color: Colors.white,
                                                size: 40,
                                              )),
                                          iconSize: 40.0,
                                          onPressed: () {
                                            final singleSong = SingleSong(
                                                doc["song_id"].toString(),
                                                doc["poet_name"].toString(),
                                                doc["album_name"].toString(),
                                                doc["singer_name"].toString(),
                                                doc["audio_length"].toString(),
                                                doc["song_name"].toString(),
                                                doc["composed_by"].toString(),
                                                doc["audio_image"].toString(),
                                                doc["song_id"].toString(),
                                                doc["lyrics"],
                                                doc["domine_name"].toString(),
                                            );
                                            CurrentSongHive.put("currentSong", singleSong);
                                            currnetSongController.updateCurrentSong(
                                              doc["song_id"].toString(),
                                              doc["poet_name"].toString(),
                                              doc["album_name"].toString(),
                                              doc["singer_name"].toString(),
                                              doc["audio_length"].toString(),
                                              doc["song_name"].toString(),
                                              doc["composed_by"].toString(),
                                              doc["audio_image"].toString(),
                                              doc["song_id"].toString(),
                                              doc["lyrics"],
                                              doc["domine_name"].toString(),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.list,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                                  ),
                                )
                            ).toList(),
                          );

                          // ListView.builder(
                          //     scrollDirection: Axis.vertical,
                          //     shrinkWrap: true,
                          //     physics: ScrollPhysics(),
                          //     itemCount: 3,
                          //     itemBuilder: (BuildContext context,int index){
                          //
                          //     });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Some Thing went wrong please try restating the Application ",
                              overflow: TextOverflow.visible,
                              style: TextStyle(),
                            ),
                          );
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(
                                child: Text(
                                  "Some Thing went wrong please try restating the Application ${snapshot.hasError}",
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(),
                                ),
                              );

                              break;

                            case ConnectionState.waiting:
                              return Column(
                                children: [
                                  Center(child: CircularProgressIndicator()),
                                  Center(
                                    child: Text("Please wait While loading"),
                                  ),
                                ],
                              );
                              // children =  [
                              //   Center(child: Text("Please wait While loading"),),
                              //
                              // ];
                              break;
                            case ConnectionState.active:
                              return Center(child: CircularProgressIndicator());

                              // children =  [
                              //         Center(child: CupertinoActivityIndicator()),
                              //       ];
                              break;
                            case ConnectionState.done:
                              return  ListView(
                                physics :NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map((doc) => ListTile(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  SongPage(songID: '${doc["song_id"].toString()}',)),
                                    );
                                  },
                                  leading: Container(
                                    height: height*0.06,
                                    width: width*0.12,
                                    decoration:  BoxDecoration(

                                      borderRadius: BorderRadius.all(Radius.circular(0)),
                                      // color: pictureBG,
                                      image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/Tarana- Voice of Islam.png')
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
                                  title: Text(doc["song_name"].toString()),
                                  subtitle: Text("${doc["singer_name"].toString()} • ${doc["audio_length"].toString()}"),
                                  trailing: IconButton(onPressed: (){},icon: Icon(Icons.more_vert),),
                                )
                                ).toList(),
                              );
                              break;
                          }
                        }
                      },
                    ),
                  ],
                ),
              ])),

            ],
          ),
        ));
  }
}
