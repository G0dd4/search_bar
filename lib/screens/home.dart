import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/services/bddUsers.dart';
import 'package:search_bar/widget/books.dart';
import '../widget/bookCarouselTitle.dart';
import '../widget/bottomBar.dart';


class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Book>>.value(
      initialData: [],
      value: BddUser().books,
      child: HomeMain()
    );
  }
}

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
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
                  books: books,
                )
              ],
            )),
      ),
      bottomNavigationBar: BottomBar(current: 0),
    );
  }
}

