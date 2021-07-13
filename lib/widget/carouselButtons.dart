import 'package:flutter/material.dart';
import 'buttons.dart';

class CarouselButtons{

  Widget carouselWidget(List<Buttons> dataToDisplay){
    return Expanded(
        flex: 1,
        child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.all(4),
        itemCount: dataToDisplay.length,
        itemBuilder: (BuildContext context, int index) {
          return dataToDisplay[index].buttons();
        },
        separatorBuilder: (BuildContext context,int index) => const Divider(),
    ),
    );
  }
}