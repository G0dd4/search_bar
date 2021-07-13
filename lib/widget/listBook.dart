import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'books.dart';

class ListBook {

  Widget getWidget(List<Book> dataToDisplay) {
    return Expanded(
      flex: 15,
      child: Card(
        elevation: 8,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: dataToDisplay.length,
          itemBuilder: (BuildContext context, int index) {
            return dataToDisplay[index].transformIntoWidget();
          },
          separatorBuilder: (BuildContext context,
              int index) => const Divider(),
        ),
      ),
    );
  }

}