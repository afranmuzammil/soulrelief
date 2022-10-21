

import 'dart:developer';

import 'package:get/get.dart';

import '../pages/flotingAudio.dart';

class CurrnetSongController extends GetxController with StateMixin<dynamic>{

 String currentSongID = "";
 @override
 void onInit(){
   setSong;
 }

 setSong(){
   currentSongID = "1rMHGBUIIxHxFX43Wef7Xhx97RlU_NHQ9";
   update();
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