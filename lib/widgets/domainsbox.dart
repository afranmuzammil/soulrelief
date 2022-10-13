import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulrelief/pages/dominePages.dart';

class DomainsCards extends StatelessWidget {
   DomainsCards({
    required this.imageLink,
    required this.dominName,
    Key? key
  }) : super(key: key);

  final String imageLink;
  final String dominName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DominePages(domineName: dominName,)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(imageLink),color:Color(0xFFE967AC),height: height*0.05 ,),
            Text(dominName,style: TextStyle(
                color: Color(0xFFE967AC),
                fontSize: 12,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}
