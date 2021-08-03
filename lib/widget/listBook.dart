import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'books.dart';

class ListBook extends StatefulWidget {
  final List<Book> books;
  const ListBook({required this.books});

  @override
  _ListBook createState() => _ListBook();
}

class _ListBook extends State<ListBook> {
  @override
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: widget.books.length > 0
          ? Card(
              elevation: 8,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: widget.books.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.books[index].transformIntoWidget();
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                "Pas de livres trouvés",
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color(0xFF505050),
                ),
              ),
            ),
    );
  }
}
