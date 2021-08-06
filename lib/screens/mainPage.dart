import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/bottomBar.dart';
import 'package:search_bar/widget/listBook.dart';
import '../widget/searchBar.dart';
import '../widget/buttons.dart';
import '../widget/carouselButtons.dart';
import '../widget/bottomBar.dart';
import 'package:search_bar/widget/books.dart';

StreamController<int> buttonIndexData = StreamController<int>.broadcast();
StreamController<List<Book>> buttonBooksData =
    StreamController<List<Book>>.broadcast();

StreamController<List<Book>> searchBarData =
    StreamController<List<Book>>.broadcast();

bool turnOffSearchBar = false;

List<Book> initialBooks = [];

@immutable
class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  Stream<QuerySnapshot> myCollectionRealTime = FirebaseFirestore.instance
      .collection("Livres")
      .snapshots();
  List<Buttons> buttons = [];

  final Stream<List<Book>> streamSearchBar = searchBarData.stream;
  final Stream<int> streamButtonIndex = buttonIndexData.stream;
  final Stream<List<Book>> streamButtonData = buttonBooksData.stream;

  late StreamSubscription searchBarSubscription;
  late StreamSubscription buttonIndexStreamSubscription;
  late StreamSubscription buttonBooksStreamSubscription;

  CarouselButtons carouselButtons = CarouselButtons();

  List<Book> initialBooks = [];
  List<Book> preFilteredBooks = [];
  List<Book> filteredBooks = [];
  List<Book> booksDisplayer = [];

  void _updateStateButton(int param) {
    setState(() {
      if (param != 0) {
        print(param);
        for (int i = 0; i < buttons.length; i++) {
          if (param - 1 != i) {
            buttons[i].buttonPressed = false;
          }
        }
      }
    });
  }

  void _updateStateSearchBar(List<Book> param) {
    filteredBooks = param;
    _verifSimularData();
    setState(() {});
  }

  void _updateStateButtonPrefilter(List<Book> param) {
    preFilteredBooks = param;
    _verifSimularData();
    setState(() {});
  }

  void _verifSimularData() {
    booksDisplayer = [];
    for (int i = 0; i < preFilteredBooks.length; i++) {
      for (int j = 0; j < filteredBooks.length; j++) {
        if (preFilteredBooks[i].contain(filteredBooks[j])) {
          booksDisplayer.add(filteredBooks[j]);
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();


    myCollectionRealTime.forEach((param) {
      param.docs.forEach((element) {
        Map<String,dynamic> a = element.data() as Map<String,dynamic>;
        initialBooks.add(Book.map(a));
      });
      booksDisplayer = initialBooks;
      preFilteredBooks = initialBooks;
      filteredBooks = initialBooks;
      buttons = [
        Buttons('science-fiction', Colors.red, false, buttonIndexData, 1,
            buttonBooksData, initialBooks),
        Buttons('romance', Colors.amber, false, buttonIndexData, 2,
            buttonBooksData, initialBooks),
        Buttons('mystère', Colors.teal, false, buttonIndexData, 3,
            buttonBooksData, initialBooks),
        Buttons('fantasy', Colors.green, false, buttonIndexData, 4,
            buttonBooksData, initialBooks),
        Buttons('aventure', Colors.black, false, buttonIndexData, 2,
            buttonBooksData, initialBooks),
      ];
      setState(() {

      });
    });
    /*
    myCollectionRealTime.listen((param) {
      _initInitialBooks(param);
    });
    */
    buttonIndexStreamSubscription = streamButtonIndex.listen((param) {
      _updateStateButton(param);
    });

    searchBarSubscription = streamSearchBar.listen((param) {
      _updateStateSearchBar(param);
    });

    buttonBooksStreamSubscription = streamButtonData.listen((param) {
      _updateStateButtonPrefilter(param);
    });
  }

  @override
  void dispose() {
    buttonIndexStreamSubscription.cancel();
    searchBarSubscription.cancel();
    buttonBooksStreamSubscription.cancel();

    super.dispose();
  }


  Widget build(BuildContext context) {
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
            ListBook(books: booksDisplayer),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        current: 1,
      ),
    );
  }
}
