import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/widget/books.dart';
import 'dart:math';

@immutable
// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  String title;
  List<Book> initialBooks;
  StreamController<List<Book>> streamController;

  SearchBar({
    required this.title,
    required this.initialBooks,
    required this.streamController,
  });

  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double width;
  bool isSearching = false;
  List<String> _suggestion = [];

  TextEditingController textControler = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    for(int i =0;i<widget.initialBooks.length;i++){
      _suggestion.add(widget.initialBooks[i].author);
      _suggestion.add(widget.initialBooks[i].title);
    }
    textControler.addListener(() {});
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    textControler.dispose();
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget changeStateSearchBare() {
    print(widget.initialBooks[0].author);
    print(_suggestion);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        height: 48.0,
        //color: Colors.blue,

        alignment: Alignment.centerRight,
        child: Stack(
          alignment: Alignment.centerRight,
          //alignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    isSearching == false ? widget.title : "",
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 48.0,
              width: (isSearching == false) ? 48.0 : this.width,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: (isSearching == true)
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]
                      : null),
              child: Stack(children: [
                /**************************************************************************
                 * Animation pour l'extensions est la création du IconButons suppressions *
                 **************************************************************************/
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: 0.0,
                  right: 7.0,
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: (isSearching == false) ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        /// can add custom color or the color will be white
                        color: Color(0xFFFCFCFC),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: AnimatedBuilder(
                        child: IconButton(
                          onPressed: () {
                            textControler.clear();
                            _filterData('');
                          },
                          icon: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                        builder: (context, widget) {
                          ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                          return Transform.rotate(
                            angle: _controller.value * 2.0 * pi,
                            child: widget,
                          );
                        },
                        animation: _controller,
                      ),
                    ),
                  ),
                ),

                /***************************
                 * Annimation du TextField *
                 ***************************/
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  left: (isSearching == false) ? 20.0 : 40.0,
                  //: Curves.easeOut,
                  top: 0.0,

                  ///Using Animated opacity to change the opacity of th textField while expanding
                  child: AnimatedOpacity(
                    opacity: (isSearching == false) ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.topCenter,
                      width: this.width / 1.7,
                      child: /*TextField(
                        focusNode: focusNode,
                        autofocus: false,
                        onChanged: (value) {
                          _filterData(value);
                        },
                        controller: textControler,
                        onEditingComplete: () {
                          unfocusKeyboard();
                          //isSearching = false;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search data",
                        ),
                      ),*/
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.length < 2) {
                            return [];
                          }

                          var list1 = _suggestion.where((suggestion) => suggestion.toLowerCase().startsWith(value.text.toLowerCase())).toList();
                          var list2 = _suggestion.where((suggestion) => suggestion.toLowerCase().contains(value.text.toLowerCase())).toList();

                          
                          return [...list1, ...list2].toSet().toList();
                        },

                        onSelected: (value) {
                            _filterData(value);
                            unfocusKeyboard();
                        },

                        fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController textControler,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted
                        ) {
                          return TextField(
                            controller: textControler,
                            focusNode: focusNode,
                            autofocus: false,
                            onEditingComplete: () {
                              unfocusKeyboard();
                              //isSearching = false;
                            },
                            onChanged: (value) {
                              _filterData(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search data",
                            ),
                          );

                        }
                      ),
                    ),
                  ),
                ),

                /*******************************
                 * Annimation bouton Recherche *
                 *******************************/
                Material(
                  /// can add custom color or the color will be white
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.circular(30.0),
                  child: IconButton(
                    splashRadius: 19.0,

                    ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                    ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                    ///prefixIcon is of type Icon
                    icon: Icon(
                      isSearching == true ? Icons.arrow_back_ios : Icons.search,
                      size: 20.0,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          ///if the search bar is closed
                          if (isSearching == false) {
                            isSearching = true;
                            setState(() {
                              FocusScope.of(context).requestFocus(focusNode);
                            });

                            ///forward == expand
                            _controller.forward();
                          } else {
                            textControler.clear();
                            _filterData(textControler.text);

                            ///if the search bar is expanded
                            isSearching = false;

                            ///if the autoFocus is true, the keyboard will close, automatically
                            setState(() {
                              unfocusKeyboard();
                            });

                            ///reverse == close
                            _controller.reverse();
                          }
                        },
                      );
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _filterData(String value) async {
    print(value);
    List<Book> filteredBooks = [];
    /*for (int index = 0; index < widget.initialBooks.length; index++) {
      if (widget.initialBooks[index].shortenAuthor
                  .toLowerCase()
                  .contains(value.toLowerCase()) ==
              true ||
          widget.initialBooks[index].shortenTitle
                  .toLowerCase()
                  .contains(value.toLowerCase()) ==
              true) {
        filteredBooks.add(widget.initialBooks[index]);
      }
    }
    if (filteredBooks.length == 0) {
      List<dynamic> combinedDataAuthorTitle = [];
      List<dynamic> combinedDataTitleAuthor = [];

      for (int index = 0; index < widget.initialBooks.length; index++) {
        combinedDataAuthorTitle.add(widget.initialBooks[index].shortenAuthor +
            " " +
            widget.initialBooks[index].shortenTitle);
        combinedDataTitleAuthor.add(widget.initialBooks[index].shortenTitle +
            " " +
            widget.initialBooks[index].shortenAuthor);

        if (combinedDataAuthorTitle[index]
                    .toLowerCase()
                    .contains(value.toLowerCase()) ==
                true ||
            combinedDataTitleAuthor[index]
                    .toLowerCase()
                    .contains(value.toLowerCase()) ==
                true) {
          filteredBooks.add(widget.initialBooks[index]);
        }
      }
    }*/
    Stream<QuerySnapshot> myCollectionByAuthor = FirebaseFirestore.instance
        .collection("Livres")
        .where("Author", isGreaterThanOrEqualTo: value)
        .snapshots();
    Stream<QuerySnapshot> myCollectionByTitle = FirebaseFirestore.instance
        .collection("Livres")
        .where("Title", isGreaterThanOrEqualTo: value)
        .snapshots();
    myCollectionByAuthor.forEach((param) {
      param.docs.forEach((element) {
        Map<String, dynamic> a = element.data() as Map<String, dynamic>;
        print(a);
        filteredBooks.add(Book.map(a));
      });
      print(filteredBooks);
    });
    myCollectionByTitle.forEach((param) async {
      param.docs.forEach((element) {
        Map<String, dynamic> a = element.data() as Map<String, dynamic>;
        filteredBooks.add(Book.map(a));
      });
      widget.streamController.add(filteredBooks);
    });
  }

  @override
  Widget build(BuildContext context) {
    this.width = MediaQuery.of(context).size.width;
    return changeStateSearchBare();
  }
}
