import 'package:flutter/material.dart';


/*class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<int> _items = [];
  List<int> _fetchedItems = [0, 1, 2, 3,4];
  List<Color> _colors = [Colors.purple,Colors.red,Colors.yellow,Colors.blue,Colors.green];

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  Widget slideIt(BuildContext context, int index, animation) {
    int item = _items[index];
    TextStyle? textStyle = Theme.of(context).textTheme.headline4;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset(0, 0),
      ).animate(animation),
      child: Container(
        width: (MediaQuery.of(context).size.width)/5,
        color: _colors[item],
      ),
    );
  }

  _loadItems()  {
    for (int item in _fetchedItems) {
      // 1) Wait for one second
      //await Future.delayed(Duration(milliseconds: 500));
      // 2) Adding data to actual variable that holds the item.
      _items.add(item);
      // 3) Telling animated list to start animation
      listKey.currentState!.insertItem(_items.length - 1, duration: Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedList(
        key: listKey,
        scrollDirection: Axis.horizontal,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return slideIt(context, index, animation); // Refer step 3
        },
      ),
    );
  }
}*/


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width)/5,
          color: Colors.purple,
        ),
        Container(
          width: (MediaQuery.of(context).size.width)/5,
          color: Colors.red,
        ),
        Container(
          width: (MediaQuery.of(context).size.width)/5,
          color: Colors.yellow,
        ),
        Container(
          width: (MediaQuery.of(context).size.width)/5,
          color: Colors.blue,
        ),
        Container(
          width: (MediaQuery.of(context).size.width)/5,
          color: Colors.green,
        ),
      ],
    );
  }
}
