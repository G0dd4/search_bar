import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:search_bar/widget/books.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _isConnected();
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
            StreamBuilder<QuerySnapshot<Object?>>(
              stream: myCollectionRealTime,
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text("Erreur"),
                    );
                  }
                  if(snapshot.hasData){
                    snapshot.data!.docs.map((e){
                      var a = e.data() as Map<String,dynamic>;
                      print(a);
                    });
                    snapshot.data!.docs.forEach((element) {
                      Map<String,dynamic> a = element.data() as Map<String,dynamic>;
                      newParution.add(Book.map(a));
                    });
                    return BookCarouselTitle(
                      books: newParution,
                      title: "Dernières parutions",
                    );


                  }
                  return Container();
                }
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomBar(current: 0),
    );
  }
}
