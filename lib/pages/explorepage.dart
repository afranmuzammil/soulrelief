import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/models/StorageModel.dart';
import 'package:soulrelief/models/initalizeHive.dart';
import 'dart:developer';
import '../builders/gradienticon.dart';
import '../widgets/domainsbox.dart';
import '../widgets/poetscards.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final likedListHive = LikedListHive.initLikedListDataHive();
  final likedSongsHive = LikedSongsHive.initLikedSongsDataHive();
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace:
                LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              Future.delayed(Duration(microseconds: 2000), () async {
                if (kToolbarHeight + MediaQuery.of(context).padding.top <=
                    constraints.biggest.height)
                  setState(() {
                    top = constraints.biggest.height;
                  });
              });

              return FlexibleSpaceBar(
                centerTitle: true,
                // title: Text("Tarana Portal",
                //     style: TextStyle(
                //       color: Colors.black54,
                //       fontSize: 16.0,
                //     ) //TextStyle
                // ), //Text
                background: Container(
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
              );
            }),
            // bottom: PreferredSize(
            //   preferredSize: const Size.fromHeight(30),
            //   child:
            // ),
            //FlexibleSpaceBar
            expandedHeight: height * 0.2,
            backgroundColor: Colors.white,
            leading: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Visibility(
                  visible: top == kToolbarHeight,
                  child: Image(
                    image: AssetImage(
                      "assets/tarnana.png",
                    ),
                    height: height * 0.12,
                    width: width * 0.04,
                  ),
                ),
              ),
            ),
            actions: [
              Visibility(
                  visible: top == kToolbarHeight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ))),
              Visibility(
                visible: top == kToolbarHeight,
                child: IconButton(
                    onPressed: () {
                      log("${top} - ${kToolbarHeight}");
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black87,
                    )),
              )
            ], //<Widget>[]
          ),
          SliverList(
              delegate: SliverChildListDelegate([
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
                Padding(
                  padding:
                  const EdgeInsets.only(left: 0.0, top: 0.0, right: 250.0, bottom: 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Domains",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF5F7185),
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Container(
                  height: height * 0.36,
                  //color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: [
                          DomainsCards(imageLink: "assets/hamd.png", dominName: "Hamd"),
                          DomainsCards(imageLink: "assets/quran.png", dominName: "Quran"),
                          DomainsCards(imageLink: "assets/naat.png", dominName: "Naat"),
                          DomainsCards(imageLink: "assets/tanzimi.png", dominName: "Tanzeemi"),
                          DomainsCards(imageLink: "assets/akhirath.png", dominName: "Akhirath"),
                          DomainsCards(imageLink: "assets/youth.png", dominName: "Youth"),
                        ]),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 0.0, top: 0.0, right: 190.0, bottom: 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Explore by Poets",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF5F7185),
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: height * 0.16,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return PoetsCards(
                          poetImageLink: 'assets/Allama Iqbal.png',
                          poetName: 'Allama Iqbal',
                        );
                      }),
                ),
                // PoetsCards(poetImageLink: 'assets/Allama Iqbal.png', poetName: 'Allama Iqbal',)
                Padding(
                  padding:
                  const EdgeInsets.only(left: 0.0, top: 8.0, right: 220.0, bottom: 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Latest tarane",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF5F7185),
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                      onTap: () {},
                      leading: RadiantGradientMask(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 38,
                          )),
                      title: Text(
                        "Takzeeb mitane waale hum",
                        style: TextStyle(
                            color: Color(0xFF5F7185),
                            fontSize: 13,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w300),
                      ),
                      trailing: IconButton(onPressed: () {
                        likedListHive.delete("testList");
                      }, icon: Icon(Icons.favorite))),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                      onTap: () {},
                      leading: RadiantGradientMask(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 38,
                          )),
                      title: Text(
                        "Dhadakti hai jawan seeno me",
                        style: TextStyle(
                            color: Color(0xFF5F7185),
                            fontSize: 13,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w300),
                      ),
                      trailing: IconButton(onPressed: () {
                        log("single ${likedSongsHive.get("songId")!.songID} songlist ${likedListHive.get("testList")!.songID}");
                      }, icon: Icon(Icons.favorite))),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                      onTap: () {},
                      leading: RadiantGradientMask(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 38,
                          )),
                      title: Text(
                        "Meri SIO Meri SIO",
                        style: TextStyle(
                            color: Color(0xFF5F7185),
                            fontSize: 13,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w300),
                      ),
                      trailing: IconButton(onPressed: () {
                          final songData = LikedSong("songName", "songID", "artistName", "audioLength","");
                          likedSongsHive.put("songId", songData).then((value) {

                            List<String> addinginList = likedListHive.get("testList")?.songID??[];
                            setState(() {
                              addinginList.add("songId");
                            });

                            final SongId = LikedList(addinginList);
                            likedListHive.put("testList", SongId);
                          });

                      },
                          icon: Icon(Icons.favorite))),
                ),

                SizedBox(
                  height: 10.0,
                ),
            // Container(
            //   height: height,
            //   width: width,
            //   child: Column(
            //     children: [
            //
            //     ],
            //   ),
            // ),
          ]))
        ],
      )),
    );
  }
}
