import 'package:flutter/material.dart';
import '../widget/bookCarouselTitle.dart';
import '../widget/bottomBar.dart';
import 'package:search_bar/api/importBook.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
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
              books: newParutionBooks,
            )
          ],
        )),
      ),
      bottomNavigationBar: BottomBar(current: 0),
    );
  }
}
