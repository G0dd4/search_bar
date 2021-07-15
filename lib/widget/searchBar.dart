import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/screens/mainPage.dart';
import 'dart:math';

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double width;
  TextEditingController textControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    textControler.addListener(() {});
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

  }

  void dispose(){
    textControler.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget changeStateSearchBare() {
    return Container(
      height: 40.0,

      ///if the rtl is true, search bar will be from right to left
      alignment: Alignment.centerRight,

      ///Using Animated container to expand and shrink the widget
      child: Stack(
        alignment: Alignment.centerRight,
        //alignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  isSearching == false ? "Livres Yannis" : "",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xFF505050),
                  ),
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40.0,
            width: (isSearching == false) ? 48.0 : this.width,
            curve: Curves.easeOut,
            decoration: BoxDecoration(

                /// can add custom color or the color will be white
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
                          textControler.text = "";
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
                    child: TextField(
                      onChanged: (value) {
                        _filterData(value);
                      },
                      controller: textControler,
                      onEditingComplete: () {
                        isSearching = false;
                      },
                      decoration: InputDecoration(
                        hintText: "Search data",
                      ),
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
                          setState(() {});

                          ///forward == expand
                          _controller.forward();
                        }
                        else {
                          ///if the search bar is expanded
                          isSearching = false;

                          ///if the autoFocus is true, the keyboard will close, automatically
                          setState(() {});

                          ///reverse == close
                          _controller.reverse();
                        }
                        streamController.add(0);
                      },
                    );
                  },
                ),
              ),
            ]),
          ),

        ],
      ),
    );
  }

  void _filterData(String value) {
    print(value);
    filteredBooks = [];
    for (int index = 0; index < preFilteredBooks.length; index++) {
      if (preFilteredBooks[index]
                  .author
                  .toLowerCase()
                  .contains(value.toLowerCase()) ==
              true ||
          preFilteredBooks[index]
                  .title
                  .toLowerCase()
                  .contains(value.toLowerCase()) ==
              true) {
        filteredBooks.add(preFilteredBooks[index]);
      }
    }
    if (filteredBooks.length == 0) {
      List<dynamic> combinedDataAuthorTitle = [];
      List<dynamic> combinedDataTitleAuthor = [];

      for (int index = 0; index < preFilteredBooks.length; index++) {
        combinedDataAuthorTitle.add(preFilteredBooks[index].author +
            " " +
            preFilteredBooks[index].title);
        combinedDataTitleAuthor.add(preFilteredBooks[index].title +
            " " +
            preFilteredBooks[index].author);

        if (combinedDataAuthorTitle[index]
                    .toLowerCase()
                    .contains(value.toLowerCase()) ==
                true ||
            combinedDataTitleAuthor[index]
                    .toLowerCase()
                    .contains(value.toLowerCase()) ==
                true) {
          filteredBooks.add(preFilteredBooks[index]);
        }
      }
    }
    streamController.add(0);
  }

  @override
  Widget build(BuildContext context) {
    this.width = MediaQuery.of(context).size.width - 60;
    print(isSearching);
    if(turnOffSearchBar == true) {
      turnOffSearchBar = false;
      isSearching = false;
    }
    return  changeStateSearchBare();
  }
}
