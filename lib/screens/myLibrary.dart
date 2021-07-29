import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/services/bddUsers.dart';
import 'package:search_bar/widget/bookCarouselTitle.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/widget/bottomBar.dart';
import 'package:search_bar/widget/listBook.dart';


class MyLibrary extends StatefulWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamProvider<List<Book>>.value(
      initialData: [],
      value: BddUser(uid: user!.uid).books,
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


  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(30.0),
          child: Column(
          children: <Widget>[
          Text(
          'Ma Bibliothèque',
          style: TextStyle(
          letterSpacing: 1.0,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Color(0xFF505050),
            ),
          ),
            (books != [])
                ? BookCarouselTitle(
              title: "",
              books: books,
            )
                : Center(
                child: Text('Aucun livre dans la bibliothèque',
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Color(0xFF505050),)
                ),
            )
          ]
        ),
      ),
      ),
      bottomNavigationBar: BottomBar(
        current: 2,
      ),
    );
  }
}

