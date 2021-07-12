import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/widget/listBook.dart';
import '../widget/searchBar.dart';

StreamController<bool> streamController = StreamController<bool>();


final List <Book> initialBooks =[
  Book('Frank Herbert', 'Dune', 'assets/dune.jpg'),
  Book('Emilio Bouzamondo', 'Temps de paix...', 'assets/nouvelle.jpg'),
  Book('Aldous Huxley', 'Brave new world', 'assets/brave_new_world.jpg'),
  Book('J.R.R Tolkien', 'Lord of the Rings', 'assets/Lord_of_the_rings.jpg'),
  Book('Isaac Asimov', 'Fondation', 'assets/Fondation.jpg')
];

List <Book> filteredBooks = [];

class MainPage extends StatefulWidget {
  final Stream<bool> stream;

  MainPage(this.stream);

  @override
  _MainPage createState() => _MainPage();

}

class _MainPage extends State<MainPage> {
  bool isSearching = false;
  ListBook listBook = ListBook();

  void updateState(bool param){
      setState(() {

      });
  }

  void initState(){
    filteredBooks = initialBooks;
    super.initState();
    // sets first value
    widget.stream.listen((param) {
      updateState(param);
    });
  }

  Widget build(BuildContext context) {
    SearchBar searchBar = SearchBar();
    ListBook listBook = ListBook();

    return Scaffold(
      body: SafeArea(
        /*************************************
         * Création d'un objet Column        *
         * pour placer nos différents Widget *
         *************************************/
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 30.0,
                  bottom: 10.0,
                  right: 30.0,
                ),
                child: !isSearching
                    ? Row(
                        children: [
                          searchBar.hideSearchBar(),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                isSearching = true;
                              });
                            },
                          ),
                        ],
                      )
                    : Row(children: [
                        searchBar.showSearchBar(),
                        IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              isSearching = false;
                            });
                          },
                        ),
                      ]
                )
            ),
            listBook.getWidget(filteredBooks),
          ],
        ),
      ),
    );
  }
}
