import 'package:flutter/material.dart';

class Album{
  String _groupName = "";
  String _album = "";
  String _path = "";

  Album(groupName,album,path){
    _groupName = groupName;
    _album = album;
    _path = path;
  }

  String get groupName{
    return _groupName;
  }
  String get albumList{
    return _album;
  }
  String get pathAssets{
    return _path;
  }
}