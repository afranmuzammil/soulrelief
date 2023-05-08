import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/StorageModel.dart';
import '../models/initalizeHive.dart';

class AutoPlayController extends GetxController with StateMixin<dynamic>{

  @override
  Future<void> onInit() async {
    super.onInit();


  }



  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}

class AutoPlayControllerBindings extends Bindings {
  @override
  void dependencies() {
    // log("hello");
    Get.lazyPut<AutoPlayController>(() => AutoPlayController());
  }
}