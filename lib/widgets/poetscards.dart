import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/pages/poetPages.dart';

class PoetsCards extends StatelessWidget {
   PoetsCards({Key? key, required this.poetName , required this.poetImageLink}) : super(key: key);


  final String poetName;
  final String poetImageLink;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return InkWell(
      onTap: (){
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  PoetPages(poetName: poetName,)),
        );*/
      },
      child: Container(
        padding: EdgeInsets.only(left: 8.0,right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      //       Card(
      //        shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16.0),
      // ),
      //         child: SizedBox(
      //             height: height*0.14,
      //             width: width*0.28,
      //             child: Image(image: AssetImage("assets/Allama Iqbal.png"),)),
      //       ),
            Container(
              height: height*0.14,
              width: width*0.28,
              decoration:  BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(14)),
                // color: pictureBG,
                image: DecorationImage(fit: BoxFit.fill, image: AssetImage(poetImageLink)
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
            Text(poetName,
              style: TextStyle(
                  color: Color(0xFF5F7185),
                  fontSize: 10,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
