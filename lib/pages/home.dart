import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/letestcards.dart';
import '../widgets/recentcards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: Container(
//        background: linear-gradient(143.71deg, #668FD7 16.5%, #DF99DA 93.54%);
        height: height,
        width: width,

        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Color(0xffdf99da), Color(0xff668fd7)],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     )
        //
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                Container(
                  width: width * 0.80,
                  height: height * 0.06,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, //New
                          blurRadius: 10.0,
                          offset: Offset(0, 6))
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, top: 8.0, right: 0.0, bottom: 0.0),
                          child: Text("Search your tarana here ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontFamily: GoogleFonts.quicksand().fontFamily,
                                  fontWeight: FontWeight.w600)),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.search))
                        // Text("26 day's", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        // Text("this month",
                        //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 50.0, right: 170.0, bottom: 0.0),
                  child: Text("Listen Again",
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
                  height: 20.0,
                ),
                Container(
                  height: height,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection('AllTaranas').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          physics :NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((doc) => LatestCards(
                                    songName: doc["songName"].toString(),
                                    artistName: doc["singerName"].toString(),
                                    lyrics: doc["lyrics"].toString(),
                                  ))
                              .toList(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
