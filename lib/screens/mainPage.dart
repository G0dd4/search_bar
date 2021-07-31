import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/bottomBar.dart';
import 'package:search_bar/widget/listBook.dart';
import '../widget/searchBar.dart';
import '../widget/buttons.dart';
import '../widget/carouselButtons.dart';
import '../widget/bottomBar.dart';
import 'package:search_bar/api/importBook.dart';
import 'package:search_bar/widget/books.dart';

StreamController<int> streamController = StreamController<int>.broadcast();
StreamController<List<Book>> searchBarData =
    StreamController<List<Book>>.broadcast();

final List<Buttons> buttons = [
  Buttons('science-fiction', Colors.red, false, 1),
  Buttons('romance', Colors.amber, false, 2),
  Buttons('mystère', Colors.teal, false, 3),
  Buttons('fantasy', Colors.green, false, 4),
  Buttons('aventure', Colors.black, false, 5),
];
bool isSearching = false;
bool turnOffSearchBar = false;

@immutable
class MainPage extends StatefulWidget {
  final Stream<int> stream;
  MainPage(this.stream);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  //BddBooks bddBooks = BddBooks(collection: "album");
  final Stream<List<Book>> streamSearchBar = searchBarData.stream;

  late StreamSubscription searchBarSubscription;
  late StreamSubscription streamSubscription;
  bool isSearching = false;
  ListBook listBook = ListBook();
  CarouselButtons carouselButtons = CarouselButtons();

  void _updateStateButton(int param) {
    setState(() {
      if (param != 0) {
        print(param);
        for (int i = 0; i < buttons.length; i++) {
          if (param - 1 != i) {
            buttons[i].buttonPressed = false;
          }
        }
        isSearching = false;
      }
    });
  }

  void _updateStateSearchBar(List<Book> param) {
    filteredBooks = param;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    filteredBooks = initialBooks;
    preFilteredBooks = initialBooks;
    streamSubscription = widget.stream.listen((param) {
      _updateStateButton(param);
    });

    searchBarSubscription = streamSearchBar.listen((param) {
      _updateStateSearchBar(param);
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    searchBarSubscription.cancel();

    super.dispose();
  }

  Widget build(BuildContext context) {
    ListBook listBook = ListBook();

    return Scaffold(
      body: SafeArea(
        /*************************************
         * Création d'un objet Column        *
         * pour placer nos différents Widget *
         *************************************/
        child: Column(
          children: [
            SearchBar(
              title: "Explorer",
              initialBooks: initialBooks,
              streamController: searchBarData,
            ),
            carouselButtons.carouselWidget(buttons),
            listBook.getWidget(filteredBooks),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        current: 1,
      ),
    );
  }
}
