import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/bookCarousel.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/widget/bottomBar.dart';
import 'package:search_bar/widget/loadingPage.dart';
import 'package:search_bar/widget/searchBar.dart';

StreamController<List<Book>> streamControllerSearchBarUserBook =
    StreamController<List<Book>>.broadcast();

class MyLibraryMain extends StatefulWidget {
  const MyLibraryMain({Key? key}) : super(key: key);

  @override
  _MyLibraryMainState createState() => _MyLibraryMainState();
}

class _MyLibraryMainState extends State<MyLibraryMain> {
  late StreamSubscription streamSubscriptionBook;
  late StreamSubscription streamSubscriptionRealTime;

  Stream<List<Book>> streamBook = streamControllerSearchBarUserBook.stream;
  Stream<QuerySnapshot> collectionRealTime = FirebaseFirestore.instance
      .collection("Utilisateurs/" +
          FirebaseAuth.instance.currentUser!.uid +
          "/Ma bibliothèque")
      .snapshots();

  bool isLoaded = false;

  List<Book> userBooks = [];
  List<Book> filteredBooks = [];

  void _updateUserBook(param) {
    filteredBooks = param;
    setState(() {});
  }

  void _initUserBook(param) {
    userBooks = [];
    param.docs.forEach((element) {
      Map<String, dynamic> a = element.data() as Map<String, dynamic>;
      userBooks.add(Book.map(a));
    });
    isLoaded = true;
    setState(() {
      filteredBooks = userBooks;
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscriptionRealTime.cancel();
    streamSubscriptionBook.cancel();
  }

  @override
  void initState() {
    super.initState();

    streamSubscriptionRealTime = collectionRealTime.listen((param) {
      _initUserBook(param);
    });
    streamSubscriptionBook = streamBook.listen((param) {
      _updateUserBook(param);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded == true) {
      return Scaffold(
        body: SafeArea(
          child: Column(children: <Widget>[
            SearchBar(
              title: 'Ma bibliothèque',
              initialBooks: userBooks,
              streamController: streamControllerSearchBarUserBook,
            ),
            BookCarousel(
              books: filteredBooks,
            )
          ]),
        ),
        bottomNavigationBar: BottomBar(
          current: 2,
        ),
      );
    } else {
      return LoadingPage(
        index: 2,
        title: "Ma bibliothèque",
      );
    }
  }
}
