import 'package:flutter/material.dart';
import 'package:search_bar/screens/mainPage.dart';

class Buttons {
  final String text;
  bool buttonPressed;
  int index;
  Color color;

  Buttons(this.text,this.color,this.buttonPressed, this.index);

  Widget buttons(){

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: TextButton(
        child: Text(this.text),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
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
                EdgeInsets.symmetric(
                    vertical: 10, horizontal: 35)),
            textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 20))),
        onPressed: () {
            this.buttonPressed = !this.buttonPressed;
          if (this.buttonPressed) {
            _preFilterData(this.text);
            turnOffSearchBar = true;
          }
          else {
            filteredBooks = initialBooks;
            preFilteredBooks = initialBooks;
          }
            streamController.add(this.index);

        },
      ),
    );
  }

  void _preFilterData(String value) {
      preFilteredBooks = [];
      for (int index = 0; index < initialBooks.length; index++) {
        if (initialBooks[index].genre.toLowerCase().contains(value.toLowerCase()) == true) {
          preFilteredBooks.add(initialBooks[index]);
        }
      }
      filteredBooks = preFilteredBooks;
  }
}