import 'package:flutter/material.dart';
import 'package:search_bar/screens/mainPage.dart';

class Buttons {
  final String text;
  bool buttonPressed;
  Color color;

  Buttons(this.text,this.color,this.buttonPressed);

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
                    vertical: 10, horizontal: 50)),
            textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 30))),
        onPressed: () {
            this.buttonPressed = !this.buttonPressed;
          if (this.buttonPressed) {
            /*popPressed = false;
            metalPressed = false;
            rockPressed = false;
            isSearching = false;*/
            _preFilterData(this.text);
          } else {
            filteredBooks = initialBooks;
          }
        },
      ),
    );
    /*Expanded(
      flex: 2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: TextButton(
                  child: Text('Rap'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      foregroundColor: rapPressed
                          ? MaterialStateProperty.all(Colors.white)
                          : MaterialStateProperty.all(Colors.red),
                      backgroundColor: rapPressed
                          ? MaterialStateProperty.all(Colors.red)
                          : MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 30))),
                  onPressed: () {
                    setState(() {
                      rapPressed = !rapPressed;
                    });
                    if (rapPressed) {
                      popPressed = false;
                      metalPressed = false;
                      rockPressed = false;
                      isSearching = false;
                      _preFilterData('Rap');
                    } else {
                      filteredAlbum = dataAlbum;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: TextButton(
                  child: Text('Pop'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.amber)),
                      ),
                      foregroundColor: popPressed
                          ? MaterialStateProperty.all(Colors.white)
                          : MaterialStateProperty.all(Colors.amber),
                      backgroundColor: popPressed
                          ? MaterialStateProperty.all(Colors.amber)
                          : MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 30))),
                  onPressed: () {
                    setState(() {
                      popPressed = !popPressed;
                    });
                    if (popPressed) {
                      rapPressed = false;
                      metalPressed = false;
                      rockPressed = false;
                      isSearching = false;
                      _preFilterData('Pop');
                    } else {
                      filteredAlbum = dataAlbum;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: TextButton(
                  child: Text('Rock'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.teal)),
                      ),
                      foregroundColor: rockPressed
                          ? MaterialStateProperty.all(Colors.white)
                          : MaterialStateProperty.all(Colors.teal),
                      backgroundColor: rockPressed
                          ? MaterialStateProperty.all(Colors.teal)
                          : MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 30))),
                  onPressed: () {
                    setState(() {
                      rockPressed = !rockPressed;
                    });
                    if (rockPressed) {
                      popPressed = false;
                      metalPressed = false;
                      rapPressed = false;
                      isSearching = false;
                      _preFilterData('Rock');
                    } else {
                      filteredAlbum = dataAlbum;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: TextButton(
                  child: Text('Metal'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                      ),
                      foregroundColor: metalPressed
                          ? MaterialStateProperty.all(Colors.white)
                          : MaterialStateProperty.all(Colors.blue),
                      backgroundColor: metalPressed
                          ? MaterialStateProperty.all(Colors.blue)
                          : MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 30))),
                  onPressed: () {
                    setState(() {
                      metalPressed = !metalPressed;
                    });
                    if (metalPressed) {
                      popPressed = false;
                      rapPressed = false;
                      rockPressed = false;
                      isSearching = false;
                      _preFilterData('Metal');
                    } else {
                      filteredAlbum = dataAlbum;
                    }
                  },
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
        const Divider(),
      ),
    ),*/
  }

  void _preFilterData(String value) {
      preFilteredBooks = [];
      for (int index = 0; index < initialBooks.length; index++) {
        if (initialBooks[index].genre.toLowerCase().contains(value.toLowerCase()) == true) {
          preFilteredBooks.add(initialBooks[index]);
        }
      }
      /*filteredAlbum = preFilteredAlbum;*/
  }
}