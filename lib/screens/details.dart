import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/services/auth.dart';
import 'package:search_bar/services/bddUsers.dart';
import 'package:search_bar/widget/books.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    required  this.book
  });

  final Book book;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Details1(book: widget.book),
      ),
    );
  }
}

class Details1 extends StatefulWidget {
  Details1({
    required  this.book
  });

  final Book book;

  @override
  _Details1State createState() => _Details1State();
}

class _Details1State extends State<Details1> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamProvider<List<Book>>.value(
      initialData: [],
      value: BddUser(uid: user!.uid).books,
      child: MaterialApp(debugShowCheckedModeBanner: false,
        home:DetailsScreenMain(book: widget.book),
      ),
    );
  }
}

class DetailsScreenMain extends StatefulWidget {
  DetailsScreenMain({
    required  this.book
  });

  final Book book;

  @override
  _DetailsScreenMainState createState() => _DetailsScreenMainState();
}

class _DetailsScreenMainState extends State<DetailsScreenMain> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final books = Provider.of<List<Book>>(context);
    double boxheight = MediaQuery.of(context).size.height - 100;
    double boxwidth = MediaQuery.of(context).size.width - 50;
    // Si l'objet livre n'a pas de résumé, message d'excuse
    String summary = '';//(widget.book.summary.length == 0)
    /*? 'Désolé on a pas de résumé disponible pour ce livre !'
        : widget.book.summary;*/
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: Center(
          child: Container(
            height: boxheight,
            width: boxwidth,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Partie haute de la page
                    Stack(
                      children: [
                        // Image
                        Container(
                          height: 150,
                          width: boxwidth,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(widget.book.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(4.0, 4.0)
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero),
                          ),
                        ),
                        // Boutons
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                              icon: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Icons.add_comment,
                              ),
                            ),
                          ],
                        ),
                        //Auteur
                        Positioned(
                          bottom: 50,
                          left: 15,
                          child: Row(
                            children: [
                              Text(
                                widget.book.author,
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Titre
                        Positioned(
                          bottom: 10,
                          left: 15,
                          child: Row(
                            children: [
                              Text(
                                widget.book.title,
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Résumé du livre
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          bottom: 10,
                          right: 30,
                          left: 30,
                        ),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              summary,
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 20.0,
                                color: Color(0xFF505050),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Bouton "Débuter la lecture"
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextButton(
                          onPressed: () => {},
                          child: new Text(
                            "    Débuter la lecture    ",
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontFamily: 'Roboto',
                              fontSize: 15.0,
                            ),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:TextButton(
                          onPressed: () async { await BddUser(uid: user!.uid).addBooks(widget.book.title, widget.book.author, widget.book.imageUrl, widget.book.genre);},
                          child: new Text(
                            "    Ajouter à sa bibliothèque    ",
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontFamily: 'Roboto',
                              fontSize: 15.0,
                            ),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            ),
                          ),
                        )
                        /*: TextButton(
                          onPressed: () {},
                          child: new Text(
                            "    Supprimer de sa bibliothèque    ",
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontFamily: 'Roboto',
                              fontSize: 15.0,
                            ),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            ),
                          ),
                        )*/
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




