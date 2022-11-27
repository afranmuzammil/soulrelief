import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../builders/gradienttext.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black87,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.black87,))
          ],
          title: GradientText(
            "Albums",
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
        ),
        body: Column(
          children: [

            StreamBuilder<QuerySnapshot>(
             // stream: db.collection('AllTaranas').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(snapshot.hasData)  {
                  return ListView(
                    physics :NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs
                        .map((doc) => ListTile(
                      leading: Container(
                        height: height*0.06,
                        width: width*0.12,
                        decoration:  BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          // color: pictureBG,
                          image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/kdefult.png')
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
                      title: Text(doc["songName"].toString()),
                      subtitle: Text("Album • ${doc["singerName"].toString()} • ${doc["audioLength"].toString()}"),
                      trailing: IconButton(onPressed: (){},icon: Icon(Icons.more_vert),),
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
                      return ListView(
                        physics :NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((doc) => ListTile(
                          leading: Container(
                            height: height*0.06,
                            width: width*0.12,
                            decoration:  BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              // color: pictureBG,
                              image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/kdefult.png')
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
                          title: Text(doc["songName"].toString()),
                          subtitle: Text("Album • ${doc["singerName"].toString()} • ${doc["audioLength"].toString()}"),
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
        ));
  }
}
