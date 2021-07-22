import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bookCarousel.dart';
import 'books.dart';

class BookCarouselTitle extends StatefulWidget {
  final String title;
  final List<Book> books;

  BookCarouselTitle({
    required this.title,
    required this.books,
  });

  @override
  _BookCarouselTitle createState() => _BookCarouselTitle();
}

class _BookCarouselTitle extends State<BookCarouselTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            widget.title,
            style: TextStyle(
              letterSpacing: 1.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Color(0xFF505050),
            ),
          ),
        ),
        BookCarousel(books: widget.books),
        SizedBox(height: 30.0),
      ],
    );
  }
}
