

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../pages/flotingAudio.dart';

class CurrnetSongController extends GetxController with StateMixin<dynamic>{

 String currentSongID = "1rMHGBUIIxHxFX43Wef7Xhx97RlU_NHQ9";
 @override
 Future<void> onInit() async {;;
   super.onInit();
   await FirebaseFirestore.instance
       .collection("AllSongsList").doc(currentSongID).get()
       .then((value) {
         ///add hive here
     change(value, status: RxStatus.success());
   },onError: (error){
     log("error while getting song data $error");
     change(null, status: RxStatus.error(error.toString()));
   }
   );
   setSong();
 }

 setSong(){
   currentSongID = "1rMHGBUIIxHxFX43Wef7Xhx97RlU_NHQ9";
   update();
   change(value, status: RxStatus.success());
 }

 updateCurrentSong(newSongID){
   log(currentSongID);
   currentSongID = newSongID;
   update();
   log(currentSongID);
   //var contx =  MiniPlayer(onTap: (){},).createState().context;
   //MiniPlayer(onTap: (){},).createState().build(contx);
   change(value, status: RxStatus.success());

 }


 getSong(songId) async {
   await FirebaseFirestore.instance
       .collection("AllSongsList").doc(songId).get()
       .then((value) {
     change(value, status: RxStatus.success());
   },onError: (error){
         log("error while getting song data $error");
     change(null, status: RxStatus.error(error.toString()));
   }
   );
 }



 AddSongsToHive()async{
   log("in add hive");
   var f = await FirebaseFirestore.instance
       .collection("AllSongsList");
   log("from add songs to hive: ${f}");



 }


 @override
 void onClose() {
   // TODO: implement onClose
   super.onClose();
 }

}

class CurrnetSongControllerBindings extends Bindings {
  @override
  void dependencies() {
    // log("hello");
    Get.lazyPut<CurrnetSongController>(() => CurrnetSongController());
  }
}