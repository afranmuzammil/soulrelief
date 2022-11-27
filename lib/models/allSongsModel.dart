import 'dart:convert';
/// song_id : "1DjjMb0fV0HfHql9e_w0BWmX8glp5g5ti"
/// poet_name : "unknown"
/// album_name : "Hamd"
/// singer_name : "Tajamul Hussain"
/// audio_length : "6:30"
/// song_name : "Teri zaat wahid o kibriya"
/// composed_by : "unknown"
/// audio_image : ""
/// audio_file_size : "15,251 KB"
/// lyrics : ""
/// domine_name : "Hamd"

AllSongsModel allSongsModelFromJson(String str) => AllSongsModel.fromJson(json.decode(str));
String allSongsModelToJson(AllSongsModel data) => json.encode(data.toJson());
class AllSongsModel {
  AllSongsModel({
      String? songId, 
      String? poetName, 
      String? albumName, 
      String? singerName, 
      String? audioLength, 
      String? songName, 
      String? composedBy, 
      String? audioImage, 
      String? audioFileSize, 
      String? lyrics, 
      String? domineName,
  }){
    _songId = songId;
    _poetName = poetName;
    _albumName = albumName;
    _singerName = singerName;
    _audioLength = audioLength;
    _songName = songName;
    _composedBy = composedBy;
    _audioImage = audioImage;
    _audioFileSize = audioFileSize;
    _lyrics = lyrics;
    _domineName = domineName;
}

  AllSongsModel.fromJson(dynamic json) {
    _songId = json['song_id'];
    _poetName = json['poet_name'];
    _albumName = json['album_name'];
    _singerName = json['singer_name'];
    _audioLength = json['audio_length'];
    _songName = json['song_name'];
    _composedBy = json['composed_by'];
    _audioImage = json['audio_image'];
    _audioFileSize = json['audio_file_size'];
    _lyrics = json['lyrics'];
    _domineName = json['domine_name'];
  }
  String? _songId;
  String? _poetName;
  String? _albumName;
  String? _singerName;
  String? _audioLength;
  String? _songName;
  String? _composedBy;
  String? _audioImage;
  String? _audioFileSize;
  String? _lyrics;
  String? _domineName;
AllSongsModel copyWith({  String? songId,
  String? poetName,
  String? albumName,
  String? singerName,
  String? audioLength,
  String? songName,
  String? composedBy,
  String? audioImage,
  String? audioFileSize,
  String? lyrics,
  String? domineName,
}) => AllSongsModel(  songId: songId ?? _songId,
  poetName: poetName ?? _poetName,
  albumName: albumName ?? _albumName,
  singerName: singerName ?? _singerName,
  audioLength: audioLength ?? _audioLength,
  songName: songName ?? _songName,
  composedBy: composedBy ?? _composedBy,
  audioImage: audioImage ?? _audioImage,
  audioFileSize: audioFileSize ?? _audioFileSize,
  lyrics: lyrics ?? _lyrics,
  domineName: domineName ?? _domineName,
);
  String? get songId => _songId;
  String? get poetName => _poetName;
  String? get albumName => _albumName;
  String? get singerName => _singerName;
  String? get audioLength => _audioLength;
  String? get songName => _songName;
  String? get composedBy => _composedBy;
  String? get audioImage => _audioImage;
  String? get audioFileSize => _audioFileSize;
  String? get lyrics => _lyrics;
  String? get domineName => _domineName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['song_id'] = _songId;
    map['poet_name'] = _poetName;
    map['album_name'] = _albumName;
    map['singer_name'] = _singerName;
    map['audio_length'] = _audioLength;
    map['song_name'] = _songName;
    map['composed_by'] = _composedBy;
    map['audio_image'] = _audioImage;
    map['audio_file_size'] = _audioFileSize;
    map['lyrics'] = _lyrics;
    map['domine_name'] = _domineName;
    return map;
  }

}