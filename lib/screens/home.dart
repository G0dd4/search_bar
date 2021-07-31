import 'dart:io';
import 'package:search_bar/widget/books.dart';
import 'package:flutter/material.dart';
import '../widget/bookCarouselTitle.dart';
import '../widget/bottomBar.dart';
import 'package:search_bar/api/importBook.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<Book> newParution = [];

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

  void _getNewParution() async {
    newParution = await initNewParution();
  }

  @override
  void initState() {
    super.initState();
    _isConnected();
    _getNewParution();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              title: "nouveaux Livres",
              books: newParution,
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomBar(current: 0),
    );
  }
}
