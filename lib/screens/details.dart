import 'package:flutter/material.dart';
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
  var list = [];

  @override
  void initState(){
    print("1");
    print(list);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _set();
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() => {});
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
                              onPressed: () => Navigator.popUntil(context, (route) =>route.isFirst),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: (list.length != 0)
                                  ? () async {await BddUser().deleteBooks(widget.book.id);
                                  setState(() =>{});
                              }
                                  :() => {},
                              icon: Icon(Icons.delete),
                              disabledColor: Color(0xFF9B9B9B),
                              color : list.length != 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            IconButton(
                              onPressed: (list.length != 0)
                                  ? () => {}
                                  : () async {
                                await BddUser().addBooks(
                                    widget.book.title, widget.book.author,
                                    widget.book.imageUrl, widget.book.genre,
                                    widget.book.id);
                                setState(() => {});
                              },
                              icon: Icon((list.length != 0)
                                  ?Icons.done
                                  :Icons.library_add,
                              ),
                              color : (list.length != 0)
                                  ? Colors.blue
                                  : Colors.white,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _set() async{
    try{
      final result = await BddUser().compare(widget.book.title, widget.book.author);
      list = result;
      print('2');
      print(list);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}






