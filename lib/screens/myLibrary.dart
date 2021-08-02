import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/services/bddUsers.dart';
import 'package:search_bar/widget/bookCarouselTitle.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/widget/bottomBar.dart';
import 'package:search_bar/widget/listBook.dart';
import 'package:search_bar/widget/searchBar.dart';


class MyLibrary extends StatefulWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Book>>.value(
      initialData: [],
      value: BddUser().booksToLibrary,
      child: MaterialApp(debugShowCheckedModeBanner: false,
          home:MyLibraryMain()
      ),
    );
  }
}

class MyLibraryMain extends StatefulWidget {
  const MyLibraryMain({Key? key}) : super(key: key);

  @override
  _MyLibraryMainState createState() => _MyLibraryMainState();
}

class _MyLibraryMainState extends State<MyLibraryMain> {
  ListBook listBook = ListBook();

  StreamController<int> streamController = StreamController<int>.broadcast();


  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
    List<Book> filtered = books;
    return Scaffold(
      body: SafeArea(
        child: Column(
        children: <Widget>[
          SearchBar("Ma Bibliothèque",books,filtered,streamController),
          (filtered != [])
              ? BookCarouselTitle(
            title: "",
            books: filtered ,
          )
              : Text('Aucun livre dans la bibliothèque',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Color(0xFF505050),)
              )
        ]
        ),
      ),
      bottomNavigationBar: BottomBar(
        current: 2,
      ),
    );
  }
}

