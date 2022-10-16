import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? songName;
  final String? singerName;
  final String? compposedBy;
  final String? albumName;

  DataModel({this.songName, this.singerName, this.compposedBy, this.albumName, });

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return DataModel(
          songName: dataMap['songName'],
          singerName: dataMap['singerName'],
          compposedBy: dataMap['composedBy'],
          albumName: dataMap['albumName']);
    }).toList();
  }
}
