import 'package:flutter/material.dart';

class Book {
  static const double itemHeight = 170.0;
  static const double itemWidth = 120.0;
  static const double offset = 1.0;

  final String title;
  final String author;
  final String imageUrl;
  final String genre;

  const Book(this.author, this.title, this.imageUrl, this.genre);

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
                    image: new AssetImage(this.imageUrl),
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
          child: Text(this.author,
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
          child: Text(this.title,
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

  Widget transformIntoTilesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Les détails s'ouvrent si on appuie sur le container
        GestureDetector(
          onTap: () => {
            /*Navigator.push(
              context,
              customPageRouteBuilder(DetailsScreen(book: this)),
            )*/
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
                      image: new AssetImage(this.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey.shade300,
                          offset: Offset(4.0, 4.0)),
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
          child: Text(this.author,
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
          child: Text(this.title,
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
}
