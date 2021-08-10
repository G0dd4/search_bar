import 'package:flutter/material.dart';
import 'bottomBar.dart';

class LoadingPage extends StatelessWidget {
  final String title;
  final int index;

  const LoadingPage({
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: Text(
                        this.title,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Color(0xFF505050),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ]
            )
        ),
        bottomNavigationBar: BottomBar(current: this.index,),
    );
  }
}
