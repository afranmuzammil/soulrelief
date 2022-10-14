import 'package:hive/hive.dart';

import 'StorageModel.dart';


class LikedSongsHive{
  static Box<LikedSong> initLikedSongsDataHive(){
    return Hive.box<LikedSong>("LikedSong");
  }
}

class LikedListHive{
  static Box<LikedList> initLikedListDataHive(){
    return Hive.box<LikedList>("LikedList");
  }
}

class PlayListsHive{
  static Box<PlayLists> initPlayListsDataHive(){
    return Hive.box<PlayLists>("PlayLists");
  }
}

class PlayListSongIdsListHive{
  static Box<PlayListSongIdsList> initPlayListSongIdsListDataHive(){
    return Hive.box<PlayListSongIdsList>("PlayListSongIdsList");
  }
}


class PlayListSingleSongHive{
  static Box<PlayListSingleSong> initPlayListSingleSongDataHive(){
    return Hive.box<PlayListSingleSong>("PlayListSingleSong");
  }
}