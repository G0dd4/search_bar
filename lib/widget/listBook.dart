import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:search_bar/screens/mainPage.dart';
import 'books.dart';

class ListBook {
  Widget getWidget(List<Book> dataToDisplay) {
    return Expanded(
      flex: 10,
      child: filteredBooks.length > 0
          ? Card(
              elevation: 8,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: dataToDisplay.length,
                itemBuilder: (BuildContext context, int index) {
                  return dataToDisplay[index].transformIntoWidget();
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                "Pas de livres trouvés",
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color(0xFF505050),
                ),
              ),
            ),
    );
  }
}
