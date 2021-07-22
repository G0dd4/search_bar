import 'package:flutter/material.dart';
import 'buttons.dart';

class CarouselButtons {
  Widget carouselWidget(List<Buttons> dataToDisplay) {
    double itemHeight = 48.0;
    return Container(
      height: itemHeight,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 30.0),
        scrollDirection: Axis.horizontal,
        itemCount: dataToDisplay.length,
        itemBuilder: (BuildContext context, int index) {
          return dataToDisplay[index].buttons();
        },
      ),
    );
  }
}
