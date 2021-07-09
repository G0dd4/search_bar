import 'package:flutter/material.dart';

class Album{
  String _groupName;
  String _album;
  String _path;
  String _genre;

  Album(this._path,this._groupName,this._album,this._genre);

  String get group{
    return _groupName;
  }
  String get album{
    return _album;
  }
  String get path{
    return _path;
  }
  String get genre{
    return _genre;
  }

}