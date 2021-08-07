import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:search_bar/widget/books.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/loadingPage.dart';
import '../widget/bookCarouselTitle.dart';
import '../widget/bottomBar.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Stream<QuerySnapshot> myCollectionRealTime = FirebaseFirestore.instance
      .collection("Livres")
      .orderBy("Parution", descending: true)
      .limitToLast(5)
      .snapshots();

  List<Book> newParution = [];

  bool isLoaded = false;

  void _isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("connected");
      }
    } on SocketException catch (_) {
      print("not connected");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("vous n'êtes pas connecté"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ],
              ));
    }
  }

  void _initNewParution(QuerySnapshot<Object?> param) {
    param.docs.forEach((element) {
      var a = element.data() as Map<String, dynamic>;
      newParution.add(Book.map(a));
      newParution[newParution.length - 1].getURLImage();
    });

    newParution[newParution.length - 1].getURLImage().whenComplete(() {
      isLoaded = true;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _isConnected();
    myCollectionRealTime.listen((event) {
      _initNewParution(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded == true)
      return Scaffold(
        body: Builder(
          builder: (context) => SafeArea(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: Text(
                    'Home',
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ),
              BookCarouselTitle(
                books: newParution,
                title: "Dernières parutions",
              ),
              BookCarouselTitle(
                books: newParution,
                title: "Dernières parutions",
              ),
            ],
          )),
        ),
        bottomNavigationBar: BottomBar(current: 0),
      );
    else {
      return LoadingPage(
        index: 0,
        title: "Home",
      );
    }
  }
}
