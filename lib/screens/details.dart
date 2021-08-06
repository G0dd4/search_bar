import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/model/firebase_file.dart';
import 'package:search_bar/widget/books.dart';
import 'package:search_bar/api/firebase_firestor_api.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({required this.book});

  final Book book;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool added;
  late String id;

  Future<bool> verifState() async {
    var ref = FirebaseFirestore.instance
        .collection("Utilisateurs/" +
            FirebaseAuth.instance.currentUser!.uid +
            "/Ma bibliothèque")
        .where("Author", isEqualTo: widget.book.author)
        .where("Title", isEqualTo: widget.book.title);

    var dataCollection = await ref.get();

    if (dataCollection.size == 0) {
      return false;
    } else {
      dataCollection.docs.forEach((element) {
        this.id = element.id;
      });
      print(this.id);
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() => {});
    });
    verifState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() => {});
    double boxheight = MediaQuery.of(context).size.height - 100;
    double boxwidth = MediaQuery.of(context).size.width - 50;
    String summary = '';

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
                        FutureBuilder<FirebaseFile>(
                          future: widget.book.imageStorage,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                height: 150,
                                width: boxwidth,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new NetworkImage(snapshot.data!.url),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(4.0, 4.0)),
                                  ],
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.zero,
                                      bottomRight: Radius.zero),
                                ),
                              );
                            } else {
                              return Container(
                                height: 150,
                                width: boxwidth,
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(4.0, 4.0)),
                                  ],
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.zero,
                                      bottomRight: Radius.zero),
                                ),
                              );
                            }
                          },
                        ),
                        // Boutons
                        FutureBuilder<bool>(
                            future: verifState(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                added = snapshot.data!;
                                if (added == true) {
                                  return ButtonBar(
                                    alignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () => Navigator.popUntil(
                                            context, (route) => route.isFirst),
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => {},
                                        icon: Icon(Icons.delete),
                                        disabledColor: Color(0xFF9B9B9B),
                                        color: Colors.black,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestoreApi.deleteDocument(
                                              "Utilisateurs/" +
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid +
                                                  "/Ma bibliothèque",
                                              this.id);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.check,
                                        ),
                                        color: Colors.blue,
                                      ),
                                    ],
                                  );
                                } else {
                                  return ButtonBar(
                                    alignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () => Navigator.popUntil(
                                            context, (route) => route.isFirst),
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => {},
                                        icon: Icon(Icons.add),
                                        disabledColor: Color(0xFF9B9B9B),
                                        color: Colors.black,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestoreApi.addData(
                                              "Utilisateurs/" +
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid +
                                                  "/Ma bibliothèque",
                                              widget.book.importIntoMap());
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.library_add,
                                        ),
                                        color: Colors.blue,
                                      ),
                                    ],
                                  );
                                }
                              }
                              return Container();
                            }),
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
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
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
