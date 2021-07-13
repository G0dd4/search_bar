import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/widget/listBook.dart';
import '../widget/searchBar.dart';
import '../widget/buttons.dart';
import '../widget/carouselButtons.dart';

StreamController<bool> streamController = StreamController<bool>();


final List <Book> initialBooks =[
  Book('Frank Herbert', 'Dune', 'assets/dune.jpg','science-fiction'),
  Book('Emilio Bouzamondo', 'Temps de paix...', 'assets/nouvelle.jpg','romance'),
  Book('Aldous Huxley', 'Brave new world', 'assets/brave_new_world.jpg','mystère'),
  Book('J.R.R Tolkien', 'Lord of the Rings', 'assets/Lord_of_the_rings.jpg','fantasy'),
  Book('Isaac Asimov', 'Fondation', 'assets/Fondation.jpg','aventure')
];

final List <Buttons> buttons = [
  Buttons('science-fiction',Colors.red,false),
  Buttons('romance',Colors.amber,false),
  Buttons('mystère',Colors.teal,false),
  Buttons('fantasy',Colors.green,false),
  Buttons('aventure',Colors.black,false),
];

List <Book> filteredBooks = [];
List <Book> preFilteredBooks = [];

class MainPage extends StatefulWidget {
  final Stream<bool> stream;

  MainPage(this.stream);

  @override
  _MainPage createState() => _MainPage();

}

class _MainPage extends State<MainPage> {
  bool isSearching = false;
  ListBook listBook = ListBook();
  CarouselButtons carouselButtons = CarouselButtons();

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
            carouselButtons.carouselWidget(buttons),
            listBook.getWidget(filteredBooks),
          ],
        ),
      ),
    );
  }
}
