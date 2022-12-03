import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/contollers/currentSongContoller.dart';
import 'package:soulrelief/pages/searchFeed.dart';
import 'dart:developer';
import '../builders/gradienticon.dart';
import '../models/StorageModel.dart';
import '../models/initalizeHive.dart';
import '../models/songStorageModel.dart';
import '../widgets/letestcards.dart';
import '../widgets/recentcards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'flotingAudio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  var top = 0.0;
  bool isPlayerOpened = false;
  final recentSongsHive = RecentSongHive.initRecentSongDataHive();
  final recentSongListHive = RecentSongListHive.initRecentSongListDataHive();
  CurrnetSongController currnetSongController = Get.put(CurrnetSongController());
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  List<String> addinginList = [];
  final CurrentSongHive = SingleSongHive.initSingleSongDataHive();

  //  List<Map<String, dynamic>>? AllTarana;
  //
  //
  // Future<String> loadData() async {
  //   log("from load");
  //   // var data = await rootBundle.loadString("assets/data/Tarana List.json");
  //   // log("fromload ${data[0]}");
  //   // setState(() {
  //   //   //AllTarana = data;
  //   //   log("parsed daata${data}");
  //   // });
  //   final String response = await rootBundle.loadString('assets/data/Tarana List.json');
  //   final data = await json.decode(response);
  //   // log("fromload ${data}");
  //   setState(() {
  //     AllTarana = data;
  //     log("from data ${AllTarana?[0]["song_name"]}");
  //   });
  //
  //
  //   return "success";
  // }
  //
  // Future<String> valuedJson ()async{
  //
  //  // final String response = await rootBundle.loadString('assets/data/Tarana List 2.json');
  // //  final data = await (json.decode(response) as Map).map((key, value) => MapEntry(key as String, value as Map<String, dynamic>));
  //   log("fromload }");
  //   setState(() {
  //    // AllTarana = data;
  //     log("from data 1 ${AllTarana?[0]["song_name"]}");
  //   });
  //   return "s";
  // }
  // List _pokemons = [];
  //
  // // Read content from the json file
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/data/Tarana List.json');
  //   final Map<String, dynamic> data = await json.decode(response);
  //   List AllTarana = [];
  //   data.forEach((final String key, final value) {
  //     print("Key: {{$key}} -> value: ${value}");
  //     AllTarana.add(value);
  //   });
  //
  //   //print(pokemons);
  //   setState(() {
  //     _pokemons = AllTarana;
  //   });
  //   log("hello bro ${_pokemons[0]}");
  // }

  @override
  void initState() {
    addinginList = likedListHive.get("likedSongs")?.songID ?? [];
    // TODO: implement initState
    // loadData();
    // valuedJson();
    // readJson();
    super.initState();
  }

  onSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchFeed()),
    );
    // return SearchFeed();
  }

  getData() async {
    log("hello 2");
    // await  ;
    log("data ${db.collection('AllSongsList').snapshots().map((event) => log("log ${event.docs}"))}");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SafeArea(
      child: Scaffold(
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
          )),
          child: Banner(
            location: BannerLocation.topStart,
            message: 'BETA',
            color: Colors.green.withOpacity(0.6),
            textStyle: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
            child: CustomScrollView(
              slivers: <Widget>[
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  actions: [
                    IconButton(
                        onPressed: () {
                          FirestoreSearchBar(
                            tag: 'example',
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ], //<Widget>[]
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                        )
                      ],
                      border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.0),

                      gradient: LinearGradient(
                        colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.1)],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      // color: pictureBG,
                    ),
                    height: height * 0.25,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0.0, top: 0.0, right: 170.0, bottom: 0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Top picks for you!",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          height: height * 0.16,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: db.collection('AllSongsList').snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((doc) {
                                    //   log(doc["song_name"].toString());
                                    return RecentCards(
                                      songName: "${doc["song_name"].toString()}",
                                      audioImage:
                                          Uri.parse("${doc["audio_image"].toString()}").isAbsolute
                                              ? "${doc["audio_image"].toString()}"
                                              : 'assets/TPicon.png',
                                      SongID: "${doc["song_id"].toString()}",
                                      artistName:
                                          "${"${doc["singer_name"].toString()} • ${doc["audio_length"].toString()}"}",
                                      lyrics: doc["lyrics"],
                                      poetName: doc["poet_name"].toString(),
                                      albumName: doc["album_name"].toString(),
                                      audioFileSize: doc["song_id"].toString(),
                                      audioLength: doc["audio_length"].toString(),
                                      composedBy: doc["composed_by"].toString(),
                                      domineName: doc["domine_name"].toString(),
                                    );
                                  }).toList(),
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
                                    return ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: snapshot.data!.docs.map((doc) {
                                        //   log(doc["song_name"].toString());
                                        return RecentCards(
                                          songName: "${doc["song_name"].toString()}",
                                          audioImage:
                                              Uri.parse("${doc["audio_image"].toString()}").isAbsolute
                                                  ? "${doc["audio_image"].toString()}"
                                                  : 'assets/TPicon.png',
                                          SongID: "${doc["song_id"].toString()}",
                                          artistName:
                                              "${"${doc["singer_name"].toString()} • ${doc["audio_length"].toString()}"}",
                                          lyrics: doc["lyrics"],
                                          poetName: doc["poet_name"].toString(),
                                          albumName: doc["album_name"].toString(),
                                          audioFileSize: doc["song_id"].toString(),
                                          audioLength: doc["audio_length"].toString(),
                                          composedBy: doc["composed_by"].toString(),
                                          domineName: doc["domine_name"].toString(),
                                        );
                                      }).toList(),
                                    );
                                    break;
                                }
                              }
                            },
                          ),
                        )

                        /*Visibility(
                          visible: recentSongListHive.get("recentSongs")?.songID != null,
                          child: recentSongListHive.get("recentSongs")?.songID.isNotEmpty ?? false
                              ? Container(
                                  height: height * 0.16,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recentSongListHive.get("recentSongs")?.songID.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return RecentCards(
                                          songName:
                                              "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songName}",
                                          coverImageUrl: Uri.parse(
                                                      "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songImage}")
                                                  .isAbsolute
                                              ? recentSongsHive
                                                  .get(recentSongListHive
                                                      .get("recentSongs")
                                                      ?.songID[index])!
                                                  .songImage
                                              : 'assets/Tarana- Voice of Islam.png',
                                          songId:
                                              "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songID}",
                                          artistName:
                                              "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.artistName}",
                                        );
                                      }),
                                )
                              : Container(),
                        ),*/
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: AllTarana?.length,
                  //     itemBuilder: (BuildContext context, int index){
                  //      // log("hello ${AllTarana[0].length}");
                  //
                  //   return LatestCards(
                  //     songName: "${AllTarana?[index]["song_name"]}",
                  //     artistName: "${AllTarana?[index]["singer_name"]}",
                  //     lyrics: "${AllTarana?[index]["lyrics"]}",
                  //     SongID: "${AllTarana?[index]["song_id"]}",
                  //   );
                  // })
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 0.0, right: 170.0, bottom: 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your recently played",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Container(
                    child: Visibility(
                      visible: recentSongListHive.get("recentSongs")?.songID != null,
                      child: recentSongListHive.get("recentSongs")?.songID.isNotEmpty ?? false
                          ? Container(
                              //height: height * 0.16,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: recentSongListHive.get("recentSongs")?.songID.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    log(recentSongListHive.get("recentSongs")!.songID.length.toString());
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomListTile(
                                        leading: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          height: height * 0.06,
                                          width: width * 0.12,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            // color: pictureBG,
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage('assets/TPicon.png')
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
                                        title: recentSongsHive
                                            .get(
                                                recentSongListHive.get("recentSongs")?.songID[index])!
                                            .songName,
                                        subtitle:
                                            "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.artistName}",
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
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songID,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.poetName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.albumName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.artistName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.audioLength,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.composedBy,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songImage,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.audioFileSize,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.lyrics,
                                                    recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.domineName
                                                  );
                                                  CurrentSongHive.put("currentSong", singleSong);
                                                  currnetSongController.updateCurrentSong(
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songID,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.poetName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.albumName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.artistName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.audioLength,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songName,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.composedBy,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songImage,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.audioFileSize,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.lyrics,
                                                      recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.domineName
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
                                    );
                                    //   RecentCards(
                                    //   songName:
                                    //       "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songName}",
                                    //   coverImageUrl: Uri.parse(
                                    //               "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songImage}")
                                    //           .isAbsolute
                                    //       ? recentSongsHive
                                    //           .get(recentSongListHive
                                    //               .get("recentSongs")
                                    //               ?.songID[index])!
                                    //           .songImage
                                    //       : 'assets/Tarana- Voice of Islam.png',
                                    //   songId:
                                    //       "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.songID}",
                                    //   artistName:
                                    //       "${recentSongsHive.get(recentSongListHive.get("recentSongs")?.songID[index])!.artistName}",
                                    // );
                                  }),
                            )
                          : Container(),
                    ),
                  ),
                  /*Container(
                    // height: height,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('AllSongsList').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((doc) {
                              // log(doc["song_name"].toString());
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomListTile(
                                  leading: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height: height * 0.06,
                                    width: width * 0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      // color: pictureBG,
                                      image: DecorationImage(
                                          fit: BoxFit.fill, image: AssetImage('assets/Tarana- Voice of Islam.png')
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
                                  subtitle:
                                      "${doc["singer_name"].toString()} • ${doc["audio_length"].toString()}",
                                  trailing: Container(
                                    width: width*0.5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton( onPressed: () {

                                          if(addinginList.contains(currnetSongController.currentSongID)== false){
                                            final songData = LikedSong("${currnetSongController.currentsongName}", "${currnetSongController.currentSongID}", "${currnetSongController.currentartistName}", "${currnetSongController.currentaudioLength}","{currnetSongController.currentaudioImage}");
                                            likedSongsHive.put("${currnetSongController.currentSongID}", songData).then((value) {

                                              setState(() {
                                                addinginList.add("${currnetSongController.currentSongID}");
                                              });

                                              final SongId = LikedList(addinginList);
                                              likedListHive.put("likedSongs", SongId);
                                            });
                                          }
                                          if(addinginList.contains(currnetSongController.currentSongID)== true){

                                            likedSongsHive.delete(currnetSongController.currentSongID).then((value) {

                                              setState(() {
                                                addinginList.remove("${currnetSongController.currentSongID}");
                                              });

                                              final SongId = LikedList(addinginList);
                                              likedListHive.put("likedSongs", SongId);
                                            });
                                          }


                                        }, icon: addinginList.contains(currnetSongController.currentSongID)?RadiantGradientMask(child: Icon(Icons.favorite,color:Colors.white,),)
                                            :Icon(Icons.favorite_border,color:Colors.white,)
                                          ,),

                                        IconButton(
                                      icon: RadiantGradientMask(
                                          child: Icon(Icons.play_circle_filled_rounded, color: Colors.white, size: 40,)),
                                      iconSize: 40.0,
                                      onPressed: (){},
                                    ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.list,color: Colors.white,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              */
                  /*LatestCards(
                                songName: doc["song_name"].toString(),
                                artistName: doc["singer_name"].toString(),
                                lyrics: doc["lyrics"],
                                SongID: doc["song_id"].toString(),
                                poetName: doc["poet_name"].toString(),
                                albumName: doc["album_name"].toString(),
                                audioImage: doc["audio_image"].toString(),
                                audioFileSize: doc["song_id"].toString(),
                                audioLength: doc["audio_length"].toString(),
                                composedBy: doc["composed_by"].toString(),
                                domineName: doc["domine_name"].toString(),
                              );*/ /*
                            }).toList(),
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
                              return ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((doc) {
                                  //   log(doc["song_name"].toString());
                                  return LatestCards(
                                    songName: doc["song_name"].toString(),
                                    artistName: doc["singer_name"].toString(),
                                    lyrics: doc["lyrics"],
                                    SongID: doc["song_id"].toString(),
                                    poetName: doc["poet_name"].toString(),
                                    albumName: doc["album_name"].toString(),
                                    audioImage: doc["audio_image"].toString(),
                                    audioFileSize: doc["song_id"].toString(),
                                    audioLength: doc["audio_length"].toString(),
                                    composedBy: doc["composed_by"].toString(),
                                    domineName: doc["domine_name"].toString(),
                                  );
                                }).toList(),
                              );
                              break;
                          }
                        }
                      },
                    ),
                  ),*/
                ]))
              ],
            ),
          ),
        ),
        // floatingActionButton: floatingActionItem,
      ),
    );
  }

// onPaused() {
//   setState(() {
//     isPlayerOpened = false;
//   });
// }
//
// get floatingActionItem {
//   Widget floatingPlayer = FloatingAudioPlayer(onPaused: onPaused);
//
//   Widget floatingActionButton = FloatingActionButton(
//     onPressed: () {
//       setState(() {
//         isPlayerOpened = true;
//       });
//     },
//     child: Icon(Icons.play_arrow_outlined),
//   );
//
//   return AnimatedSwitcher(
//     reverseDuration: Duration(milliseconds: 0),
//     duration: const Duration(milliseconds: 200),
//     transitionBuilder: (Widget child, Animation<double> animation) {
//       return ScaleTransition(child: child, scale: animation);
//     },
//     child: isPlayerOpened ? floatingPlayer : floatingActionButton,
//   );
// }

}

class CustomListTile extends StatefulWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;

  const CustomListTile(
      {Key? key,
      required this.leading,
      required this.title,
      required this.subtitle,
      required this.trailing})
      : super(key: key);

  @override
  _StatefulStateCupertino createState() => _StatefulStateCupertino();
}

class _StatefulStateCupertino extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
          )
        ],
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.0),

        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.1)],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.all(Radius.circular(14)),
        // color: pictureBG,
      ),
      height: height * 0.09,
      child: Stack(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        alignment: Alignment.topCenter, // Center of Top
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(top: 10, left: height * 0.005, child: widget.leading),
          Positioned(
            left: width * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Container(
                    width: width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.title,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: height * 0.022,
                            )),
                        SizedBox(width: 20),
                        Text(widget.subtitle,
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: height * 0.014,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(right: 5, bottom: 0.1, child: widget.trailing),
        ],
      ),
    );
  }
}
