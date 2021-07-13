import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/screens/mainPage.dart';

class SearchBar {
  Widget showSearchBar() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
        ),
        child: TextField(
          onChanged: (value) {
            _filterData(value);
          },
          decoration: InputDecoration(
            hintText: "Search data",
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Widget hideSearchBar() {
    return Expanded(
      child: Text(
        'Livres Yannis',
        style: TextStyle(
          letterSpacing: 1.0,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Color(0xFF505050),
        ),
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
        combinedDataAuthorTitle
            .add(preFilteredBooks[index].author + " " + preFilteredBooks[index].title);
        combinedDataTitleAuthor
            .add(preFilteredBooks[index].title + " " + preFilteredBooks[index].author);

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
}
