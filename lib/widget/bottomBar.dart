import 'package:search_bar/screens/myLibrary.dart';
import 'package:search_bar/screens/profileHome.dart';
import 'package:search_bar/screens/wrapper.dart';
import '../screens/mainPage.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int current;

  BottomBar({required this.current});

  @override
  _BottomBar createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 2)
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 30.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Color(0xFF505050),
            unselectedItemColor: Color(0xFF9B9B9B),
            currentIndex: widget.current,
            iconSize: 26.0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore_rounded),
                label: 'Explorer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                activeIcon: Icon(Icons.book_rounded),
                label: 'My Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profil',
              ),
            ],
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    if (widget.current != 0)
                      Navigator.pushAndRemoveUntil(context,
                          customPageRouteBuilder(Wrapper()), (_) => false);
                    break;
                  case 1:
                    if (widget.current != 1)
                      Navigator.pushAndRemoveUntil(
                          context,
                          customPageRouteBuilder(
                              MainPage(streamController.stream)),
                          (_) => false);
                    break;
                  case 2:
                    if (widget.current != 2)
                      Navigator.pushAndRemoveUntil(
                          context, customPageRouteBuilder(
                          MyLibrary()), (_) => false);
                    break;
                  case 3:
                    if (widget.current != 3)
                      Navigator.pushAndRemoveUntil(
                          context, customPageRouteBuilder(
                          Profile()), (_) => false);
                    break;
                  default:
                }
              });
            }),
      ),
    );
  }

  PageRouteBuilder customPageRouteBuilder(Widget pageToGo) {
    return PageRouteBuilder(
      transitionDuration: Duration(microseconds: 0),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secanimation,
        Widget child,
      ) {
        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      },
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secanimation,
      ) {
        return pageToGo;
      },
    );
  }
}
