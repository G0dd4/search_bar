import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/widget/bottomBar.dart';
import 'package:search_bar/widget/listBook.dart';
import '../widget/searchBar.dart';
import '../widget/buttons.dart';
import '../widget/carouselButtons.dart';
import '../widget/bottomBar.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

final List<Book> initialBooks = [
  Book('Frank Herbert', 'Dune', 'assets/dune.jpg', 'science-fiction',''),
  Book('Emilio Bouzamondo', 'Temps de paix...', 'assets/nouvelle.jpg',
      'romance',''),
  Book('Aldous Huxley', 'Brave new world', 'assets/brave_new_world.jpg',
      'mystère',''),
  Book('J.R.R Tolkien', 'Lord of the Rings', 'assets/Lord_of_the_rings.jpg',
      'fantasy',''),
  Book('Isaac Asimov', 'Fondation', 'assets/Fondation.jpg', 'aventure',''),
  Book('Frank Herbert', 'Dune', 'assets/dune.jpg', 'aventure',''),
  Book('Emilio Bouzamondo', 'Temps de paix...', 'assets/nouvelle.jpg',
      'fantasy',''),
  Book('Aldous Huxley', 'Brave new world', 'assets/brave_new_world.jpg',
      'science-fiction',''),
  Book('J.R.R Tolkien', 'Bilbo', 'assets/Lord_of_the_rings.jpg', 'romance',''),
  Book('Isaac Asimov', 'Fondation', 'assets/Fondation.jpg', 'romance','')
];


bool isSearching = false;
bool turnOffSearchBar = false;

List<Book> filteredBooks = [];
List<Book> preFilteredBooks = [];

class MainPage extends StatefulWidget {
  final Stream<int> stream;
  late StreamSubscription streamSubscription;

  MainPage(this.stream);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  bool isSearching = false;
  ListBook listBook = ListBook();
  final List<Buttons> buttons = [
    Buttons('science-fiction', Colors.red, false, 1,initialBooks),
    Buttons('romance', Colors.amber, false, 2,initialBooks),
    Buttons('mystère', Colors.teal, false, 3,initialBooks),
    Buttons('fantasy', Colors.green, false, 4,initialBooks),
    Buttons('aventure', Colors.black, false, 5,initialBooks),
  ];
  CarouselButtons carouselButtons = CarouselButtons();

  void updateState(int param) {
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

  void initState() {
    filteredBooks = initialBooks;
    super.initState();
    preFilteredBooks = initialBooks;

    // sets first value
    widget.streamSubscription = widget.stream.listen((param) {
      updateState(param);
    });
  }

  @override
  void dispose() {
    widget.streamSubscription.cancel();
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
            SearchBar("Explorer",preFilteredBooks,filteredBooks,streamController),
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
