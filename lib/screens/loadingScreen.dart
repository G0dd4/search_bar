import 'package:flutter/material.dart';
import 'dart:async';


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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadItems();
    });
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

  _loadItems()  async {
    for (int item in _fetchedItems) {
      // 1) Wait for one second
      await Future.delayed(Duration(milliseconds: 500));
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


/*class LoadingScreen extends StatelessWidget {
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
}*/

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {

  late bool _isInitialValue;
  late bool _isInitialValue2;
  late bool _isInitialValue3;
  late bool _isInitialValue4;
  late bool _isInitialValue5;
  late AnimationController controller;
  late Animation translationAnimation;

  @override
  void initState() {
    setState(() {
      _isInitialValue = true;
      _isInitialValue2 = true;
      _isInitialValue3 = true;
      _isInitialValue4 = true;
      _isInitialValue5 = true;
    });
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    translationAnimation = Tween<Offset>(begin: const Offset(0, 1), end:  Offset(0, 0)).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), () {});
      setState(() => _isInitialValue = !_isInitialValue);
      print('1');
      Timer(Duration(milliseconds: 500), () {});
      setState(() => _isInitialValue2 = !_isInitialValue2);
      print('2');
      Timer(Duration(milliseconds: 500), () {});
      setState(() => _isInitialValue3 = !_isInitialValue3);
      print('3');
      Timer(Duration(milliseconds: 500), () {});
      setState(() => _isInitialValue4 = !_isInitialValue4);
      print('4');
      Timer(Duration(milliseconds: 500), () {});
      setState(() => _isInitialValue5 = !_isInitialValue5);
      print('5');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
    AnimatedContainer(
    duration: const Duration(milliseconds: 100),
    color: Colors.purple,
    width: (MediaQuery.of(context).size.width)/5,
    height: _isInitialValue ? 0 : MediaQuery.of(context).size.height,
    //alignment: _isInitialValue ? Alignment(-1.0, -3.0) : Alignment(-1.0, 0),
    child: Container(
    width: (MediaQuery.of(context).size.width)/5,
    color: Colors.purple,
    ),
    ),
    AnimatedContainer(
    duration: const Duration(milliseconds: 100),
    color: Colors.transparent,
    width: (MediaQuery.of(context).size.width)/5,
    height: _isInitialValue2 ? 0 : MediaQuery.of(context).size.height,
    //alignment: _isInitialValue2 ? Alignment(-1.0, -3.0) : Alignment(-1.0, 0),
    child: Container(
    width: (MediaQuery.of(context).size.width)/5,
    color: Colors.red,
    ),
    ),
    AnimatedContainer(
    duration: const Duration(milliseconds: 100),
    color: Colors.transparent,
    width: (MediaQuery.of(context).size.width)/5,
    height: _isInitialValue3 ? 0 : MediaQuery.of(context).size.height,
    //alignment: _isInitialValue3 ? Alignment(-1.0, -3.0) : Alignment(-1.0, 0),
    child: Container(
    width: (MediaQuery.of(context).size.width)/5,
    color: Colors.yellow,
    ),
    ),
    AnimatedContainer(
    duration: const Duration(milliseconds: 100),
    color: Colors.transparent,
    width: (MediaQuery.of(context).size.width)/5,
    height: _isInitialValue4 ? 0 : MediaQuery.of(context).size.height,
    //alignment: _isInitialValue4 ? Alignment(-1.0, -3.0) : Alignment(-1.0, 0),
    child: Container(
    width: (MediaQuery.of(context).size.width)/5,
    color: Colors.blue,
    ),
    ),
    AnimatedContainer(
    duration: const Duration(milliseconds: 100),
    color: Colors.transparent,
    width: (MediaQuery.of(context).size.width)/5,
    height: _isInitialValue5 ? 0 : MediaQuery.of(context).size.height,
    //alignment: _isInitialValue5 ? Alignment(-1.0, -3.0) : Alignment(-1.0, 0),
    child: Container(
    width: (MediaQuery.of(context).size.width)/5,
    color: Colors.green,
    ),
    ),
    ],
    );
  }
}

  /*@override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: translationAnimation.value,
      child: Container(
        color: Colors.red,
      ),
    );*//* *//*Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: translationAnimation.value,
          child: Container(
            width: (MediaQuery.of(context).size.width)/5,
            color: Colors.purple,
          ),
        ),
        Transform.translate(
          offset: translationAnimation.value,
          child: Container(
            width: (MediaQuery.of(context).size.width)/5,
            color: Colors.red,
          ),
        ),
        Transform.translate(
          offset: translationAnimation.value,
          child: Container(
            width: (MediaQuery.of(context).size.width)/5,
            color: Colors.yellow,
          ),
        ),
        Transform.translate(
        offset: translationAnimation.value,
          child: Container(
            width: (MediaQuery.of(context).size.width)/5,
            color: Colors.blue,
          ),
        ),
        Transform.translate(
          offset: translationAnimation.value,
          child: Container(
            width: (MediaQuery.of(context).size.width)/5,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  }*/




