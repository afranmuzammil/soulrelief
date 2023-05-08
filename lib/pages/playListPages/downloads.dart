import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../builders/gradienttext.dart';
import '../../contollers/currentSongContoller.dart';
import '../../models/StorageModel.dart';
import '../../models/initalizeHive.dart';
import '../../models/songStorageModel.dart';
import '../home.dart';


class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {


  // static Future<File> downloadAudioFile(String audioUrl) async {
  //   var hiddenFolder = '.nomedia';
  //
  //   var directoryExternal = await getExternalStorageDirectory();
  //   final dir = Directory('${directoryExternal!.path}/$hiddenFolder');
  //   if ((await dir.exists())) {
  //   } else {
  //     dir.create();
  //   }
  //   final http.Response responseData = await http.get(Uri.parse(audioUrl));
  //   var uint8list = responseData.bodyBytes;
  //   var buffer = uint8list.buffer;
  //   ByteData byteData = ByteData.view(buffer);
  //
  //   String fileName = audioUrl.split('/').last;
  //   File file = await File('${dir.path}/.${fileName}').writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   return file;
  // }

  @override
  Widget build(BuildContext context) {
    final DownloadedSongsHive = DownloadedSongHive.initDownloadedSongDataHive();
    final DownloadedSongsListHive = DownloadedSongListHive.initDownloadedSongListDataHive();
    final CurrentSongHive = SingleSongHive.initSingleSongDataHive();
    final currentPlayListHive = CurrentPlayListHive.initCurrentPlayListDataHive();

    CurrnetSongController currnetSongController = Get.put(CurrnetSongController());
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
          "Downloads",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height*0.12,
                      width: width *0.60,
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Download \n Songs!",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Image(image: AssetImage("assets/LikePlay.png"),height: height*0.08,width: width*0.20,)
                  ],
                ),
                DownloadedSongsListHive.get("downloadSongs")!.songID.isNotEmpty?
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: DownloadedSongsListHive.get("downloadSongs")!.songID.length ,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        final singleSong = SingleSong(
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songID,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.poetName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.albumName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.artistName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioLength,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.composedBy,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songImage,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioFileSize,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.lyrics,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.domineName
                        );
                        CurrentSongHive.put("currentSong", singleSong);
                        currnetSongController.updateCurrentSong(
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songID,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.poetName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.albumName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.artistName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioLength,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songName,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.composedBy,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songImage,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioFileSize,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.lyrics,
                            DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.domineName
                        );
                        log(DownloadedSongsHive.get("${DownloadedSongsListHive.get("downloadSongs")!.songID[index]}")!.filePath);
                        final allSongs = CurrentPlayList(DownloadedSongsListHive.get("downloadSongs")!.songID);
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
                          title: DownloadedSongsHive.get("${DownloadedSongsListHive.get("downloadSongs")!.songID[index]}")!.songName,
                          subtitle: "${DownloadedSongsHive.get("${DownloadedSongsListHive.get("downloadSongs")!.songID[index]}")!.artistName} • ${DownloadedSongsHive.get("${DownloadedSongsListHive.get("downloadSongs")!.songID[index]}")!.audioLength}",
                          trailing: Container(
                            width: width * 0.5,
                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     IconButton(
                            //       onPressed: () {
                            //         if (addinginList.contains(
                            //             currnetSongController.currentSongID) ==
                            //             false) {
                            //           final songData = LikedSong(
                            //               "${currnetSongController.currentsongName}",
                            //               "${currnetSongController.currentSongID}",
                            //               "${currnetSongController.currentartistName}",
                            //               "${currnetSongController.currentaudioLength}",
                            //               "${currnetSongController.currentaudioImage}",
                            //               "${currnetSongController.currentpoetName}",
                            //               "${currnetSongController.currentalbumName}",
                            //               "${currnetSongController.currentcomposedBy}",
                            //               "${currnetSongController.currentaudioFileSize}",
                            //               "${currnetSongController.currentlyrics}",
                            //               "${currnetSongController.currentdomineName}");
                            //           DownloadedSongsHive
                            //               .put("${currnetSongController.currentSongID}",
                            //               songData)
                            //               .then((value) {
                            //             setState(() {
                            //               addinginList.add(
                            //                   "${currnetSongController.currentSongID}");
                            //             });
                            //
                            //             final SongId = LikedList(addinginList);
                            //             DownloadedSongsListHive.put("downloadSongs", SongId);
                            //           });
                            //         }
                            //         if (addinginList.contains(
                            //             currnetSongController.currentSongID) ==
                            //             true) {
                            //           DownloadedSongsHive
                            //               .delete(currnetSongController.currentSongID)
                            //               .then((value) {
                            //             setState(() {
                            //               addinginList.remove(
                            //                   "${currnetSongController.currentSongID}");
                            //             });
                            //
                            //             final SongId = LikedList(addinginList);
                            //             DownloadedSongsListHive.put("downloadSongs", SongId);
                            //           });
                            //         }
                            //       },
                            //       icon: addinginList
                            //           .contains(currnetSongController.currentSongID)
                            //           ? RadiantGradientMask(
                            //         child: Icon(
                            //           Icons.favorite,
                            //           color: Colors.white,
                            //         ),
                            //       )
                            //           : Icon(
                            //         Icons.favorite_border,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     IconButton(
                            //       icon: RadiantGradientMask(
                            //           child: Icon(
                            //             Icons.play_circle_filled_rounded,
                            //             color: Colors.white,
                            //             size: 40,
                            //           )),
                            //       iconSize: 40.0,
                            //       onPressed: () {
                            //         final singleSong = SingleSong(
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songID,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.poetName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.albumName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.artistName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioLength,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.composedBy,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songImage,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioFileSize,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.lyrics,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.domineName
                            //         );
                            //         CurrentSongHive.put("currentSong", singleSong);
                            //         currnetSongController.updateCurrentSong(
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songID,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.poetName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.albumName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.artistName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioLength,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songName,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.composedBy,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.songImage,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.audioFileSize,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.lyrics,
                            //             DownloadedSongsHive.get(DownloadedSongsListHive.get("downloadSongs")?.songID[index])!.domineName
                            //         );
                            //       },
                            //     ),
                            //     IconButton(
                            //       onPressed: () {},
                            //       icon: Icon(
                            //         Icons.list,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                    );
                  },
                ):
                Center(child:Text("Your downloaded songs will be shown here",style: TextStyle(color: Colors.grey),)),
              ]),)

            ],
          ),
        ));
  }
}
