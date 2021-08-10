import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:search_bar/api/firebase_storage_api.dart';
import 'package:search_bar/model/firebase_file.dart';
import 'package:search_bar/screens/details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Book {
  static const double itemHeight = 170.0;
  static const double itemWidth = 120.0;
  static const double offset = 1.0;

  late Stream bookStream;

  late DateTime time;
  late String shortenTitle;
  late String title;
  late String author;
  late String shortenAuthor;

  late String epubDirectory;
  late String imageDirectory;

  late FirebaseFile imageStorage;
  late Future<FirebaseFile> epubStorage;

  late CachedNetworkImageProvider coverBook;

  late String genre;
  late epub.EpubBook epubFile;

  Book.map(Map data) {
    this.title = data['Title'];
    if (title.length > 13) {
      shortenTitle = title.replaceRange(13, null, '');
      shortenTitle = shortenTitle + "...";
    } else
      shortenTitle = title;

    this.author = data['Author'];
    if (author.length > 10) {
      shortenAuthor = author.replaceRange(10, null, '');
      shortenAuthor = shortenAuthor + "...";
    } else
      shortenAuthor = author;

    this.epubDirectory = data['epubFile'];
    this.imageDirectory = data['imageFile'];

    this.genre = "";

    Timestamp stamp = data['Parution'];
    this.time = stamp.toDate();

    epubStorage = FirebaseStorageApi.listSingle("Epubs", data['epubFile']);
  }

  void _importEpub(epub.EpubBook myEpub) {
    this.epubFile = myEpub;
  }

  Future<void> getURLImage(context, bool putIntoCache) async {
    this.imageStorage =
        await FirebaseStorageApi.listSingle("Images", this.imageDirectory);
    coverBook = new CachedNetworkImageProvider(imageStorage.url);
    if(putIntoCache == true){
      await precacheImage(coverBook,context);
    }
  }

  bool contain(Book myBook) {
    if (this.author == myBook.author && this.title == myBook.title) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> importIntoMap() {
    Map<String, dynamic> dataToImport = {
      'Author': this.author,
      'Title': this.title,
      'Parution': Timestamp.fromDate(this.time),
      'epubFile': this.epubDirectory,
      'imageFile': this.imageDirectory,
    };

    return dataToImport;
  }

  Widget transformIntoWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // image
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, right: offset, bottom: 5.0, left: offset),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              // Image du livre
              Container(
                height: itemHeight,
                width: itemWidth,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: coverBook,
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 5, offset: Offset(4.0, 4.0)),
                  ],
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ),

        // Auteur
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 5.0, right: offset, left: offset),
          child: Text(this.shortenAuthor,
              style: TextStyle(
                fontSize: 12.0,
                decorationColor: Color(0xFF9B9B9B),
                letterSpacing: 0.15,
              )),
        ),
        // Titre
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 5.0, right: offset, left: offset),
          child: Text(this.shortenTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                decorationColor: Color(0xFF505050),
                letterSpacing: 0.15,
              )),
        ),
      ],
    );
  }

  Widget transformIntoTilesWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Les détails s'ouvrent si on appuie sur le container
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              customPageRouteBuilder(DetailsScreen(book: this)),
            )
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 5.0, right: offset, bottom: 5.0, left: offset),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                // Image du livre
                Container(
                  height: itemHeight,
                  width: itemWidth,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: coverBook,
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 5, offset: Offset(4.0, 4.0)),
                    ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Auteur
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 5.0, right: offset, left: offset),
          child: Text(this.shortenAuthor,
              style: TextStyle(
                fontSize: 12.0,
                decorationColor: Color(0xFF9B9B9B),
                letterSpacing: 0.15,
              )),
        ),
        // Titre
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 5.0, right: offset, left: offset),
          child: Text(this.shortenTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                decorationColor: Color(0xFF505050),
                letterSpacing: 0.15,
              )),
        ),
      ],
    );
  }

  PageRouteBuilder customPageRouteBuilder(Widget pageToGo) {
    return PageRouteBuilder(
      transitionDuration: Duration(microseconds: 0),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secanimation,
        Widget child,
      ) {
        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      },
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secanimation,
      ) {
        return pageToGo;
      },
    );
  }
}
