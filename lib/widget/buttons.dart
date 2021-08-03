import 'dart:async';
import 'books.dart';
import 'package:flutter/material.dart';

class Buttons {
  final String text;
  bool buttonPressed;
  int index;
  Color color;
  StreamController<List<Book>> myBooksController;
  StreamController<int> myIndexController;
  List<Book> initialBooks;

  Buttons(this.text, this.color, this.buttonPressed, this.myIndexController,
      this.index, this.myBooksController, this.initialBooks);

  Widget buttons() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: TextButton(
        child: Text(this.text),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: this.color)),
            ),
            foregroundColor: this.buttonPressed
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(this.color),
            backgroundColor: this.buttonPressed
                ? MaterialStateProperty.all(this.color)
                : MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 10, horizontal: 35)),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
        onPressed: () {
          this.buttonPressed = !this.buttonPressed;
          if (this.buttonPressed) {
            _preFilterData(this.text);
          } else {
            myBooksController.add(this.initialBooks);
          }
          myIndexController.add(this.index);
        },
      ),
    );
  }

  void _preFilterData(String value) {
    List<Book> preFilteredBooks = [];
    for (int index = 0; index < this.initialBooks.length; index++) {
      if (this
              .initialBooks[index]
              .genre
              .toLowerCase()
              .contains(value.toLowerCase()) ==
          true) {
        preFilteredBooks.add(this.initialBooks[index]);
      }
    }
    myBooksController.add(preFilteredBooks);
  }
}
