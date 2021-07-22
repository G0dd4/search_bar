import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'books.dart';

class BookCarousel extends StatefulWidget {
  final List<Book> books;

  BookCarousel({
    required this.books,
  });

  @override
  _BookCarousel createState() => _BookCarousel();
}

class _BookCarousel extends State<BookCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 240.0,
          color: Color(0xFFFCFCFC),
          child: ListView.builder(
              padding: EdgeInsets.only(left: 25.0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.books.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.books[index].transformIntoTilesWidget();
              }),
        )
      ],
    );
  }
}
