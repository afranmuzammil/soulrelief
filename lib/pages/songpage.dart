import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:soulrelief/pages/home.dart';
import 'package:text_scroll/text_scroll.dart';
import '../builders/gradienticon.dart';
import '../builders/gradienttext.dart';
import '../contollers/common.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:we_slide/we_slide.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio_cache/just_audio_cache.dart';
import '../contollers/currentSongContoller.dart';
import '../models/StorageModel.dart';
import '../models/initalizeHive.dart';
import '../models/songStorageModel.dart';
import '../widgets/letestcards.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class SongPage extends StatefulWidget {
  const SongPage({Key? key,  required this.songID,  this.onTap}) : super(key: key);
  final String songID;
  final Function? onTap;


  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final _player = AudioPlayer();
  final db = FirebaseFirestore.instance;
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  final recentSongsHive = RecentSongHive.initRecentSongDataHive();
  final recentSongListHive = RecentSongListHive.initRecentSongListDataHive();
  final DownloadedSongsHive = DownloadedSongHive.initDownloadedSongDataHive();
  final DownloadedSongsListHive = DownloadedSongListHive.initDownloadedSongListDataHive();
  final CurrentSongHive = SingleSongHive.initSingleSongDataHive();
  final currentPlayListHive = CurrentPlayListHive.initCurrentPlayListDataHive();
  CurrnetSongController currnetSongController = getx.Get.put(CurrnetSongController());
  List<String> addinginList = [];
  List<String> downloadSongsinList = [];
  var t = true;
  /// String songId="12ig9Z23DlI2frx0pb8DozUcqGrYsg7vQ";
  String? songId;
  var offlineSongFile;
  //_SongPageState(this.songId);
  // var duration = await player.setUrl('https://foo.com/bar.mp3');
  // var duration = await player.setFilePath('/path/to/file.mp3');
  // var duration = await player.setAsset('path/to/asset.mp3');

  List songIDList = [];


  @override
  void initState() {
    addinginList = likedListHive.get("likedSongs")?.songID??[];
    songId = currnetSongController.currentSongID;
    print("songid : $songId");
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.black,
    ));
    init();

    Timer.periodic(Duration(seconds: 3), (timer) {
      if(currnetSongController.currentSongID != songId){
        init();
        setState(() {
          songId = currnetSongController.currentSongID;
        });
      }
      // getData();
    });



  }

  List<DocumentSnapshot>? documentList;


  Future<void> init() async {
    log("song Init Started") ;
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.

    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      //await _player.existedInLocal(url: "https://drive.google.com/uc?export=view&id=$songId") == true
      if(DownloadedSongsListHive.get("downloadSongs")!.songID.contains(
          currnetSongController.currentSongID)){
        log("from Downloads ${DownloadedSongsHive.get(currnetSongController.currentSongID)!.filePath}");
        //await _player.dynamicSet( url: "https://drive.google.com/uc?export=view&id=$songId");
        ////TODO: have a look at his download of audio
        await _player.setAudioSource(
            AudioSource.uri(
              Uri.parse(
                  "${DownloadedSongsHive.get(currnetSongController.currentSongID)!.filePath}"),
              tag: MediaItem(
                // Specify a unique ID for each media item:
                id: '1',
                // Metadata to display in the notification:
                album: "Album name",
                title: "Song name",
                artUri: Uri.parse("${DownloadedSongsHive.get(currnetSongController.currentSongID)!.filePath}"),
              ),
            ));
        downloadSongsinList = DownloadedSongsListHive.get("downloadSongs")!.songID;
      }else{
      //  _player.cacheFile( url: "https://drive.google.com/uc?export=view&id=${currnetSongController.currentSongID}");
        log("from online");
        await _player.setAudioSource(
            AudioSource.uri(
          Uri.parse(
              "https://drive.google.com/uc?export=view&id=${currnetSongController.currentSongID}"),
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: '1',
            // Metadata to display in the notification:
            album: "${currnetSongController.currentalbumName}",
            title: "${currnetSongController.currentsongName}",
            artUri: Uri.parse("https://drive.google.com/uc?export=view&id=${currnetSongController.currentSongID}"),
          ),
        )); //1-HPfLLirpw2REb-quLmxq6MyEtQ3jZep
      }


      // await FirebaseFirestore.instance
      //     .collection("song_ids_list").doc("song_ids").get().then((value) =>
      // {
      //   log("whrere ${value["all_ids"][0]}"),
      //
      //   setState(() {
      //     for (int i = 0; i <= value["all_ids"].length; i++) {
      //       if (songIDList.contains(value["all_ids"][i]) == false) {
      //         songIDList.add(value["all_ids"][i]);
      //         log("hello ${songIDList}");
      //       }
      //     }
      //   }),
      //
      // });
      //_player.seek(Duration.zero);



      // s.map((event) => log(event.data().toString()));


    }
    catch (e) {
      print("Error loading audio source: $e");
      if(e.toString()=="Null check operator used on a null value"){
        await _player.setAudioSource(
            AudioSource.uri(
              Uri.parse(
                  "https://drive.google.com/uc?export=view&id=${currnetSongController.currentSongID}"),
              tag: MediaItem(
                // Specify a unique ID for each media item:
                id: '1',
                // Metadata to display in the notification:
                album: "Album name",
                title: "Song name",
                artUri: Uri.parse("https://drive.google.com/uc?export=view&id=${currnetSongController.currentSongID}"),
              ),
            ));
      }
    }
  }

  nextSong() {


    int currentSongIndex =  currentPlayListHive.get("currentPlayList")!.songID.indexOf(currnetSongController.currentSongID);
    int currentListLength = currentPlayListHive.get("currentPlayList")!.songID.length;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        log(currentSongIndex.toString());
        log(currentListLength.toString());
        if (currentListLength != (currentSongIndex+1)) {
         var nextSongIndex = currentSongIndex + 1;
         log(nextSongIndex.toString());
         log("${currentPlayListHive.get("currentPlayListHive")?.songID[nextSongIndex]}");
         //TODO: Make proper hive for current playlist so that data can be saved and played
          final singleSong = SingleSong(
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
          );
          CurrentSongHive.put("currentSong", singleSong);
          currnetSongController.updateCurrentSong(
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songID,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.poetName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.albumName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.artistName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioLength,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songName,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.composedBy,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.songImage,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.audioFileSize,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.lyrics,
              DownloadedSongsHive.get(currentPlayListHive.get("currentPlayList")?.songID[nextSongIndex])!.domineName
          );
       //   currnetSongController.updateCurrentSong(newSongID, poetName, albumName, artistName, audioLength, songName, composedBy, audioImage, audioFileSize, lyrics, domineName)
         init();
        }
      });
    });
  }

  prvSong() {
    int currentSongIndex = songIDList.indexOf(songId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if(songIDList.length != 1){
          songId = songIDList[currentSongIndex - 1];
        }

      });
    });
  }



  addSongToRecent(songID,songName,artistName,audioLength,songImage,
      domineName,
      lyrics,
      audioFileSize,
      composedBy,
      albumName,
      poetName){
    List<String> listOfRecentSong = recentSongListHive.get("recentSongs")?.songID??[];

    if(listOfRecentSong.contains(songID)== false){
      final songData = RecentSong(songName, songID, artistName, audioLength, songImage,domineName,
          lyrics,
          audioFileSize,
          composedBy,
          albumName,
          poetName);
      if(listOfRecentSong.length == 5){
        listOfRecentSong.removeLast();
      }
      recentSongsHive.put("$songID", songData).then((value) {

        setState(() {
          listOfRecentSong.add("$songID");
            t=false;
        });

        final SongId = RecentSongList(listOfRecentSong);
        recentSongListHive.put("recentSongs", SongId);
      });
    }

  }

  // @override
  // void dispose() {
  //   // WidgetsBinding.instance?.removeObserver(this);
  //   // Release decoders and buffers back to the operating system making them
  //   // available for other apps to use.
  //   _player.dispose();
  //   super.dispose();
  // }
  bool isfirst = true;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) =>
              PositionData(
                  position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final WeSlideController _controller = WeSlideController();
    final double _panelMinSize = 127.0;
    final double _panelMaxSize = MediaQuery
        .of(context)
        .size
        .height;
    final size = MediaQuery
        .of(context)
        .size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
       // backgroundColor: Colors.transparent,
       //  appBar: AppBar(
       //    backgroundColor: Colors.transparent,
       //    elevation: 0,
       //    actions: [
       //      // IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
       //      IconButton(onPressed: () {
       //
       //          log(recentSongListHive.get("recentSongs")!.songID.toString());
       //
       //      }, icon: Icon(Icons.more_vert, color: Colors.black87,))
       //    ],
       //    // title: GradientText(
       //    //   "Albums",
       //    //   style: TextStyle(
       //    //       color: Color(0xFF5F7185),
       //    //       fontSize: 20,
       //    //       fontFamily: GoogleFonts.poppins().fontFamily,
       //    //       fontWeight: FontWeight.bold),
       //    //   gradient: LinearGradient(colors: [
       //    //     Color(0xffdf99da), Color(0xff668fd7)
       //    //   ]),
       //    // ),
       //    leading: IconButton(
       //      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,), onPressed: () {
       //
       //        widget.onTap!();
       //
       //    //  Navigator.of(context).pop();
       //    },),
       //    centerTitle: true,
       //  ),
        body: currnetSongController.obx(
          (data){
            //var data = snapshot.data!.data();
            //var value = currnetSongController.currentsongName;
            //log("song name $value");
            if(t){
              addSongToRecent(currnetSongController.currentSongID,currnetSongController.currentsongName,currnetSongController.currentartistName,currnetSongController.currentaudioLength,currnetSongController.currentaudioImage,currnetSongController.currentdomineName,currnetSongController.currentlyrics,currnetSongController.currentaudioFileSize,currnetSongController.currentcomposedBy,currnetSongController.currentalbumName,currnetSongController.currentpoetName);
            }
            return Container(
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
              height: height,
              width: width,
              child: SafeArea(
                child: CustomScrollView(

                  slivers: [
                    // Container(
                    //   height: height * 0.2,
                    //   width: width,
                    //   // color: Colors.red,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Image(
                    //         image: AssetImage(
                    //           "assets/tarnana.png",
                    //         ),
                    //         height: height * 0.12,
                    //         width: width * 0.3,
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                            widget.onTap!();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      actions: [
                        IconButton(
                            onPressed: () async {
                              log("downloading the song...");
                              offlineSongFile = await DefaultCacheManager().getSingleFile("https://drive.google.com/uc?export=view&id=${currnetSongController.currentSongID}").
                              then((value) { log("song is downloaded${value.path}");
                              if (downloadSongsinList.contains(
                                  currnetSongController.currentSongID) ==
                                  false) {
                                final songData = DownloadedSong(
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
                                    "${currnetSongController.currentdomineName}",
                                    "${value.path.toString()}"
                                );
                                DownloadedSongsHive
                                    .put("${currnetSongController.currentSongID}",
                                    songData)
                                    .then((value) {
                                  setState(() {
                                    downloadSongsinList.add(
                                        "${currnetSongController.currentSongID}");
                                  });

                                  final SongId = DownloadedSongList(downloadSongsinList);
                                  DownloadedSongsListHive.put("downloadSongs", SongId);
                                });
                                log("songAdded to the downloadedList");
                              }
                              });

                              // if (addinginList.contains(
                              //     currnetSongController.currentSongID) ==
                              //     true) {
                              //   likedSongsHive
                              //       .delete(currnetSongController.currentSongID)
                              //       .then((value) {
                              //     setState(() {
                              //       addinginList.remove(
                              //           "${currnetSongController.currentSongID}");
                              //     });
                              //
                              //     final SongId = LikedList(addinginList);
                              //     likedListHive.put("likedSongs", SongId);
                              //   });
                              // }
                              //
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
                          Container(

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
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              // color: pictureBG,

                            ),

                            child: Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 20,
                              shadowColor: Color(0xFFC3539A),
                              child: SizedBox(
                                  height: height * 0.52,
                                  width: width * 0.85,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextScroll(
                                        "${currnetSongController.currentsongName}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: GoogleFonts
                                                .poppins()
                                                .fontFamily,
                                            fontWeight: FontWeight.bold),
                                        velocity:  Velocity(pixelsPerSecond: Offset(12, 0)),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0.0, 22, 0.0, 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          shadowColor: Color(0xFFC3539A),
                                          elevation: 20,
                                          child: Container(
                                            height: height * 0.25,
                                            width: width * 0.45,
                                            decoration: BoxDecoration(

                                              borderRadius: BorderRadius.all(Radius.circular(14)),
                                              // color: pictureBG,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white.withOpacity(0.2),
                                                  Colors.white.withOpacity(0.2)
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                              image: DecorationImage(fit: BoxFit.fill,
                                                  image: AssetImage("assets/TPicon.png")
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
                                        ),
                                      ),
                                      StreamBuilder<PositionData>(
                                        stream: _positionDataStream,
                                        builder: (context, snapshot) {
                                          final positionData = snapshot.data;
                                          return SeekBar(

                                            duration: positionData?.duration ?? Duration.zero,
                                            position: positionData?.position ?? Duration.zero,
                                            bufferedPosition:
                                            positionData?.bufferedPosition ?? Duration.zero,
                                            onChangeEnd: _player.seek,
                                          );
                                        },
                                      ),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [

                                          ControlButtons(_player, songIdList: songIDList,
                                            currentSongID: songId!,
                                            Nextsong: () {
                                              nextSong();
                                            },
                                            prvsong: () {
                                              prvSong();
                                            },),


                                        ],
                                      ),

                                      //  ControlButtons(_player),
                                      // Display seek bar. Using StreamBuilder, this widget rebuilds
                                      // each time the position, buffered position or duration changes.

                                    ],
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),

                    ])),


                  ],
                ),
              ),
            );
          },
        )


    );
  }

  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>> SongPlayFunction(double height, double width, BuildContext context) {
    //var snapshot = await documentRef.get({ source: 'cache' }

      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
         // future: db.collection("AllSongsList").doc("songId").get(),
          builder: (_, snapshot) {

            WidgetsBinding.instance.addPostFrameCallback((_){
              if(isfirst){
                setState(() {
                  isfirst = false;
                });
                log(isfirst.toString());
              }
            });
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');
            if (snapshot.hasData) {
              var data = snapshot.data!.data();
              var value = currnetSongController.currentsongName;
              log("song name $value");
              if(t){
                addSongToRecent(currnetSongController.currentSongID,currnetSongController.currentsongName,currnetSongController.currentartistName,currnetSongController.currentaudioLength,currnetSongController.currentaudioImage,currnetSongController.currentdomineName,currnetSongController.currentlyrics,currnetSongController.currentaudioFileSize,currnetSongController.currentcomposedBy,currnetSongController.currentalbumName,currnetSongController.currentpoetName);
              }
              return Container(
                height: height,
                width: width,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(

                      children: [
                        // Container(
                        //   height: height * 0.2,
                        //   width: width,
                        //   // color: Colors.red,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Image(
                        //         image: AssetImage(
                        //           "assets/tarnana.png",
                        //         ),
                        //         height: height * 0.12,
                        //         width: width * 0.3,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 10,
                          shadowColor: Color(0xFFC3539A),
                          child: SizedBox(
                              height: height * 0.66,
                              width: width * 0.85,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GradientText(
                                    "${currnetSongController.currentsongName}",
                                    style: TextStyle(
                                        color: Color(0xFF5F7185),
                                        fontSize: 18,
                                        fontFamily: GoogleFonts
                                            .poppins()
                                            .fontFamily,
                                        fontWeight: FontWeight.bold),
                                    gradient: LinearGradient(colors: [
                                      Color(0xffdf99da), Color(0xff668fd7)
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 22, 0.0, 50),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      shadowColor: Color(0xFFC3539A),
                                      elevation: 20,
                                      child: Container(
                                        height: height * 0.25,
                                        width: width * 0.45,
                                        decoration: BoxDecoration(

                                          borderRadius: BorderRadius.all(Radius.circular(14)),
                                          // color: pictureBG,
                                          image: DecorationImage(fit: BoxFit.fill,
                                              image: AssetImage("assets/Allama Iqbal.png")
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
                                    ),
                                  ),
                                  StreamBuilder<PositionData>(
                                    stream: _positionDataStream,
                                    builder: (context, snapshot) {
                                      final positionData = snapshot.data;
                                      return SeekBar(

                                        duration: positionData?.duration ?? Duration.zero,
                                        position: positionData?.position ?? Duration.zero,
                                        bufferedPosition:
                                        positionData?.bufferedPosition ?? Duration.zero,
                                        onChangeEnd: _player.seek,
                                      );
                                    },
                                  ),
                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [

                                      ControlButtons(_player, songIdList: songIDList,
                                        currentSongID: songId!,
                                        Nextsong: () {
                                          nextSong();
                                        },
                                        prvsong: () {
                                          prvSong();
                                        },),


                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton( onPressed: () {

                                          if(addinginList.contains(currnetSongController.currentSongID)== false){
                                            final songData = LikedSong("${currnetSongController.currentsongName}", "${currnetSongController.currentSongID}", "${currnetSongController.currentartistName}", "${currnetSongController.currentaudioLength}","${currnetSongController.currentaudioImage}","${currnetSongController.currentpoetName}","${currnetSongController.currentalbumName}","${currnetSongController.currentcomposedBy}","${currnetSongController.currentaudioFileSize}","${currnetSongController.currentlyrics}","${currnetSongController.currentdomineName}");
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
                                          :Icon(Icons.favorite_border,color:Color(0XFF5F7185),)
                                        ,),
                                        Text("${data!['album_name']}".toUpperCase(),style :TextStyle(
                                            color: Color(0xFF5F7185),
                                            fontSize: 16,
                                            fontFamily: GoogleFonts.poppins().fontFamily,
                                            fontWeight: FontWeight.w600)),
                                        IconButton( onPressed: () {
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
                                        }, icon: Icon(Icons.playlist_add,color:Color(0XFF5F7185),) ,),
                                    ],
                                  )
                                  //  ControlButtons(_player),
                                  // Display seek bar. Using StreamBuilder, this widget rebuilds
                                  // each time the position, buffered position or duration changes.

                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: height,
                          width: width * 0.85,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff3B4C77), Color(0xffD1549E)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            // color: pictureBG,

                          ),
                          child: ContainedTabBarView(
                            tabBarProperties: TabBarProperties(
                              indicatorColor: Colors.white,
                            ),
                            initialIndex: 1,
                            tabs: [
                              Text('Next'),
                              Text('Lyrics'),
                              Text("Info")
                            ],
                            views: [
                              Container(
                                child: StreamBuilder<QuerySnapshot>(
                               //   stream: db.collection('AllSongsList').snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return
                                        ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: snapshot.data!.docs
                                              .map((doc) =>
                                              ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    songId = doc["song_id"].toString();
                                                    init();
                                                  });
                                                  print(doc["song_id"].toString());
                                                },
                                                leading: Container(
                                                  height: height * 0.06,
                                                  width: width * 0.12,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(0)),
                                                    // color: pictureBG,
                                                    image: DecorationImage(fit: BoxFit.fill,
                                                        image: AssetImage('assets/hqdefault.png')
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
                                                title: Text(doc["song_name"].toString(),
                                                  style: TextStyle(color: Colors.white),),
                                                subtitle: Text("${doc["singer_name"]
                                                    .toString()} • ${doc["audio_length"]
                                                    .toString()}",
                                                    style: TextStyle(color: Colors.white)),
                                                trailing: IconButton(onPressed: () {},
                                                  icon: Icon(Icons.more_vert),
                                                  color: Colors.white,),
                                              ),


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
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Text(
                                    "${data["lyrics"].toString()}",
                                    //maxLines: 10,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: GoogleFonts
                                            .poppins()
                                            .fontFamily,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container()
                            ],
                            onChange: (index) => print(index),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
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
                  var data = snapshot.data!.data();
                  var value = currnetSongController.currentsongName;
                  log("song name $value");

                  if(t){
                    addSongToRecent(currnetSongController.currentSongID,currnetSongController.currentsongName,currnetSongController.currentartistName,currnetSongController.currentaudioLength,currnetSongController.currentaudioImage,currnetSongController.currentdomineName,currnetSongController.currentlyrics,currnetSongController.currentaudioFileSize,currnetSongController.currentcomposedBy,currnetSongController.currentalbumName,currnetSongController.currentpoetName);
                  }
                  return Container(
                    height: height,
                    width: width,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(

                          children: [
                            // Container(
                            //   height: height * 0.2,
                            //   width: width,
                            //   // color: Colors.red,
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Image(
                            //         image: AssetImage(
                            //           "assets/tarnana.png",
                            //         ),
                            //         height: height * 0.12,
                            //         width: width * 0.3,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 10,
                              shadowColor: Color(0xFFC3539A),
                              child: SizedBox(
                                  height: height * 0.66,
                                  width: width * 0.85,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GradientText(
                                        "${currnetSongController.currentsongName}",
                                        style: TextStyle(
                                            color: Color(0xFF5F7185),
                                            fontSize: 18,
                                            fontFamily: GoogleFonts
                                                .poppins()
                                                .fontFamily,
                                            fontWeight: FontWeight.bold),
                                        gradient: LinearGradient(colors: [
                                          Color(0xffdf99da), Color(0xff668fd7)
                                        ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0.0, 22, 0.0, 50),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          shadowColor: Color(0xFFC3539A),
                                          elevation: 20,
                                          child: Container(
                                            height: height * 0.25,
                                            width: width * 0.45,
                                            decoration: BoxDecoration(

                                              borderRadius: BorderRadius.all(Radius.circular(14)),
                                              // color: pictureBG,
                                              image: DecorationImage(fit: BoxFit.fill,
                                                  image: AssetImage("assets/kdefult.png")
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
                                        ),
                                      ),
                                      StreamBuilder<PositionData>(
                                        stream: _positionDataStream,
                                        builder: (context, snapshot) {
                                          final positionData = snapshot.data;
                                          return SeekBar(

                                            duration: positionData?.duration ?? Duration.zero,
                                            position: positionData?.position ?? Duration.zero,
                                            bufferedPosition:
                                            positionData?.bufferedPosition ?? Duration.zero,
                                            onChangeEnd: _player.seek,
                                          );
                                        },
                                      ),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [

                                          ControlButtons(_player, songIdList: songIDList,
                                            currentSongID: songId!,
                                            Nextsong: () {
                                              nextSong();
                                            },
                                            prvsong: () {
                                              prvSong();
                                            },),


                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     // IconButton( onPressed: () {
                                      //     //
                                      //     //   if(addinginList.contains(currnetSongController.currentSongID)== false){
                                      //     //     final songData = LikedSong("${currnetSongController.currentsongName}", "${currnetSongController.currentSongID}", "${currnetSongController.currentartistName}", "${currnetSongController.currentaudioLength}","{currnetSongController.currentaudioImage}");
                                      //     //     likedSongsHive.put("${currnetSongController.currentSongID}", songData).then((value) {
                                      //     //
                                      //     //       setState(() {
                                      //     //         addinginList.add("${currnetSongController.currentSongID}");
                                      //     //       });
                                      //     //
                                      //     //       final SongId = LikedList(addinginList);
                                      //     //       likedListHive.put("likedSongs", SongId);
                                      //     //     });
                                      //     //   }
                                      //     //   if(addinginList.contains(currnetSongController.currentSongID)== true){
                                      //     //
                                      //     //     likedSongsHive.delete(currnetSongController.currentSongID).then((value) {
                                      //     //
                                      //     //       setState(() {
                                      //     //         addinginList.remove("${currnetSongController.currentSongID}");
                                      //     //       });
                                      //     //
                                      //     //       final SongId = LikedList(addinginList);
                                      //     //       likedListHive.put("likedSongs", SongId);
                                      //     //     });
                                      //     //   }
                                      //     //
                                      //     //
                                      //     // }, icon: addinginList.contains(currnetSongController.currentSongID)?RadiantGradientMask(child: Icon(Icons.favorite,color:Colors.white,),)
                                      //     //     :Icon(Icons.favorite_border,color:Color(0XFF5F7185),)
                                      //     //   ,),
                                      //     // Text("${data!['album_name']}".toUpperCase(),style :TextStyle(
                                      //     //     color: Color(0xFF5F7185),
                                      //     //     fontSize: 16,
                                      //     //     fontFamily: GoogleFonts.poppins().fontFamily,
                                      //     //     fontWeight: FontWeight.w600)),
                                      //     // IconButton( onPressed: () {
                                      //     //   const snackBar = SnackBar(
                                      //     //     // padding:EdgeInsets.only(bottom: 10),
                                      //     //
                                      //     //     content: Text('Coming soon ',style: TextStyle(color: Colors.black),),
                                      //     //     behavior: SnackBarBehavior.floating,
                                      //     //     //      elevation: 10,
                                      //     //     backgroundColor: Colors.white,
                                      //     //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                      //     //     // action: SnackBarAction(
                                      //     //     // //  label: 'Undo',
                                      //     //     //   onPressed: () {
                                      //     //     //     // Some code to undo the change.
                                      //     //     //   },
                                      //     //     // ),
                                      //     //   );
                                      //     //
                                      //     //   // Find the ScaffoldMessenger in the widget tree
                                      //     //   // and use it to show a SnackBar.
                                      //     //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      //     // }, icon: Icon(Icons.playlist_add,color:Color(0XFF5F7185),) ,),
                                      //   ],
                                      // )

                                      //  ControlButtons(_player),
                                      // Display seek bar. Using StreamBuilder, this widget rebuilds
                                      // each time the position, buffered position or duration changes.

                                    ],
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Container(
                            //   height: height,
                            //   width: width * 0.85,
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [Color(0xff3B4C77), Color(0xffD1549E)],
                            //       begin: Alignment.bottomRight,
                            //       end: Alignment.topLeft,
                            //     ),
                            //     borderRadius: BorderRadius.all(Radius.circular(14)),
                            //     // color: pictureBG,
                            //
                            //   ),
                            //   child: ContainedTabBarView(
                            //     tabBarProperties: TabBarProperties(
                            //       indicatorColor: Colors.white,
                            //     ),
                            //     initialIndex: 1,
                            //     tabs: [
                            //       Text('Next'),
                            //       Text('Lyrics'),
                            //       Text("Info")
                            //     ],
                            //     views: [
                            //       Container(
                            //         child: StreamBuilder<QuerySnapshot>(
                            //          // stream: db.collection('AllSongsList').snapshots(),
                            //           builder: (context, snapshot) {
                            //             if (!snapshot.hasData) {
                            //               return const Center(
                            //                 child: CircularProgressIndicator(),
                            //               );
                            //             } else {
                            //               return
                            //                 ListView(
                            //                   physics: NeverScrollableScrollPhysics(),
                            //                   shrinkWrap: true,
                            //                   children: snapshot.data!.docs
                            //                       .map((doc) =>
                            //                       ListTile(
                            //                         onTap: () {
                            //                           setState(() {
                            //                             songId = doc["song_id"].toString();
                            //                             init();
                            //                           });
                            //                           print(doc["song_id"].toString());
                            //                         },
                            //                         leading: Container(
                            //                           height: height * 0.06,
                            //                           width: width * 0.12,
                            //                           decoration: BoxDecoration(
                            //                             borderRadius: BorderRadius.all(
                            //                                 Radius.circular(0)),
                            //                             // color: pictureBG,
                            //                             image: DecorationImage(fit: BoxFit.fill,
                            //                                 image: AssetImage('assets/kdefult.png')
                            //                               //NetworkImage(
                            //                               //  "${Product.products[index].imageUrl}")
                            //                               // CachedNetworkImageProvider(
                            //                               //   items.body["featuredClothingItems"][index]["coverImage"]
                            //                               //       .toString(),
                            //                               // ),
                            //                             ),
                            //                           ),
                            //                           // child: CachedNetworkImage(
                            //                           //   placeholder: (context, imgUrl) => const Text("Image is loading"),
                            //                           //   imageUrl: products.body["items"][index]["coverImage"].toString(),
                            //                           // ),
                            //                         ),
                            //                         title: Text(doc["song_name"].toString(),
                            //                           style: TextStyle(color: Colors.white),),
                            //                         subtitle: Text("${doc["singer_name"]
                            //                             .toString()} • ${doc["audio_length"]
                            //                             .toString()}",
                            //                             style: TextStyle(color: Colors.white)),
                            //                         trailing: IconButton(onPressed: () {},
                            //                           icon: Icon(Icons.more_vert),
                            //                           color: Colors.white,),
                            //                       ),
                            //
                            //
                            //                   ).toList(),
                            //                 );
                            //
                            //               // ListView.builder(
                            //               //     scrollDirection: Axis.vertical,
                            //               //     shrinkWrap: true,
                            //               //     physics: ScrollPhysics(),
                            //               //     itemCount: 3,
                            //               //     itemBuilder: (BuildContext context,int index){
                            //               //
                            //               //     });
                            //             }
                            //           },
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: EdgeInsets.all(8.0),
                            //         child: SingleChildScrollView(
                            //           child: Text(
                            //             "${data["lyrics"].toString()}",
                            //             //maxLines: 10,
                            //             overflow: TextOverflow.visible,
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 10,
                            //                 fontFamily: GoogleFonts
                            //                     .poppins()
                            //                     .fontFamily,
                            //                 fontWeight: FontWeight.w500),
                            //           ),
                            //         ),
                            //       ),
                            //       Container()
                            //     ],
                            //     onChange: (index) => print(index),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                  break;
              }
            }

            return Center(child: CircularProgressIndicator());
          },
        );
  }
}

class ControlButtons extends StatefulWidget {
  final AudioPlayer player;
  final List songIdList;
  final String currentSongID;
  final VoidCallback Nextsong;
  final VoidCallback prvsong;

  const ControlButtons(this.player,
      {Key? key, required this.songIdList, required this.currentSongID, required this.Nextsong, required this.prvsong,})
      : super(key: key);

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  CurrnetSongController currnetSongController = getx.Get.put(CurrnetSongController());
  List<String> addinginList = [];

  @override
  void initState() {
    // TODO: implement initState
    addinginList = likedListHive.get("likedSongs")?.songID??[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Opens volume slider dialog
        IconButton( onPressed: () {

          if(addinginList.contains(currnetSongController.currentSongID)== false){
            final songData = LikedSong("${currnetSongController.currentsongName}", "${currnetSongController.currentSongID}", "${currnetSongController.currentartistName}", "${currnetSongController.currentaudioLength}","${currnetSongController.currentaudioImage}","${currnetSongController.currentpoetName}","${currnetSongController.currentalbumName}","${currnetSongController.currentcomposedBy}","${currnetSongController.currentaudioFileSize}","${currnetSongController.currentlyrics}","${currnetSongController.currentdomineName}");
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
          icon: Icon(Icons.fast_rewind_rounded, color: Colors.white, size: 40),
          onPressed: () {
            int currentSongIndex = widget.songIdList.indexOf(widget.currentSongID);
            //prvsong();

            // showSliderDialog(
            //   context: context,
            //   title: "Adjust volume",
            //   divisions: 10,
            //   min: 0.0,
            //   max: 1.0,
            //   value: player.volume,
            //   stream: player.volumeStream,
            //   onChanged: player.setVolume,
            // );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: widget.player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            if(processingState == ProcessingState.completed){
              widget.Nextsong();
            }

            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(color: Color(0XFFD1549E),),
              );
            } else if (playing != true) {
              return IconButton(
                icon: RadiantGradientMask(
                    child: Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 70,)),
                iconSize: 64.0,
                onPressed: widget.player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: RadiantGradientMask(child: Icon(Icons.pause_circle_filled_outlined, color: Colors.white, size: 70,)),
                iconSize: 64.0,
                onPressed: widget.player.pause,
              );
            }
            else {
              return IconButton(
                icon: RadiantGradientMask(
                    child: Icon(Icons.replay_circle_filled_rounded, color: Colors.white, size: 70,)),
                iconSize: 64.0,
                onPressed: () => widget.player.seek(Duration.zero),
              );
            }

          },
        ),
        // Opens speed slider dialog
        SizedBox(
          width: 55.0,
          child: IconButton(
            icon: Icon(Icons.fast_forward_rounded, color: Colors.white, size: 40),
            onPressed: () {
             // Nextsong();
              // showSliderDialog(
              //   context: context,
              //   title: "Adjust volume",
              //   divisions: 10,
              //   min: 0.0,
              //   max: 1.0,
              //   value: player.volume,
              //   stream: player.volumeStream,
              //   onChanged: player.setVolume,
              // );
            },
          ),
        ),
        // StreamBuilder<double>(
        //   stream: player.speedStream,
        //   builder: (context, snapshot) =>
        //       IconButton(
        //         icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
        //             style: const TextStyle(fontWeight: FontWeight.bold)),
        //         onPressed: () {
        //           showSliderDialog(
        //             context: context,
        //             title: "Adjust speed",
        //             divisions: 10,
        //             min: 0.5,
        //             max: 1.5,
        //             value: player.speed,
        //             stream: player.speedStream,
        //             onChanged: player.setSpeed,
        //           );
        //         },
        //       ),
        // ),
        SizedBox(
          height: 40.0,
          width: 55.0,
          child: IconButton(
            icon: Icon(Icons.list, color: Colors.white, size: 28),
            onPressed: () {
              // Nextsong();
              // showSliderDialog(
              //   context: context,
              //   title: "Adjust volume",
              //   divisions: 10,
              //   min: 0.0,
              //   max: 1.0,
              //   value: player.volume,
              //   stream: player.volumeStream,
              //   onChanged: player.setVolume,
              // );
            },
          ),
        ),
      ],
    );
  }
}