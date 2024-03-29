import 'package:hive/hive.dart';
import 'package:soulrelief/models/songStorageModel.dart';

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

class RecentSongHive{
  static Box<RecentSong> initRecentSongDataHive(){
    return Hive.box<RecentSong>("RecentSong");
  }
}

class RecentSongListHive{
  static Box<RecentSongList> initRecentSongListDataHive(){
    return Hive.box<RecentSongList>("RecentSongList");
  }
}

class SingleSongHive{
  static Box<SingleSong> initSingleSongDataHive(){
    return Hive.box<SingleSong>("SingleSong");
  }
}

class DownloadedSongHive{
  static Box<DownloadedSong> initDownloadedSongDataHive(){
    return Hive.box<DownloadedSong>("DownloadedSong");
  }
}

class DownloadedSongListHive{
  static Box<DownloadedSongList> initDownloadedSongListDataHive(){
    return Hive.box<DownloadedSongList>("DownloadedSongList");
  }
}

class CurrentPlayListHive{
  static Box<CurrentPlayList?> initCurrentPlayListDataHive(){
    return Hive.box<CurrentPlayList>("CurrentPlayList");
  }
}