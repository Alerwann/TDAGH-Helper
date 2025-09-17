import 'package:flutter_application_1/data/schema/music_schema.dart';

class MusicList {

  static final List<MusicSchema> _defaultCards =[
    MusicSchema(musicPath: 'music/epic.mp3', musicTitle: 'Epic'),
    MusicSchema(musicPath: 'music/hiphopFreestyle.mp3', musicTitle: 'HipHop'),
    MusicSchema(musicPath: 'music/oldScholl.mp3', musicTitle: 'Old School'),
    MusicSchema(musicPath: 'music/phonk.mp3', musicTitle: 'Phonk'),
    MusicSchema(musicPath: 'music/zook.mp3', musicTitle: 'Zook'),
    
  ];
   static List<MusicSchema> getDefaultCards() {
    return List.from(_defaultCards);
  }
}