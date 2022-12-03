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
      child: Container(
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.10),
          //   )
          // ],
          // border: Border.all(
          //     color: Colors.white.withOpacity(0.1), width: 0.0),

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
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          //elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(imageLink),color:Colors.white,height: height*0.05 ,),
              Text(dominName,style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400),)
            ],
          ),
        ),
      ),
    );
  }
}
