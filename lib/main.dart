import 'package:flutter/material.dart';
import 'album.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSearching = false;
  bool rapPressed = false;
  bool popPressed = false;
  bool rockPressed = false;
  bool metalPressed = false;

  List filteredAlbum = [];
  List preFilteredAlbum = [];

  final List<String> groupName = [
    "The Real McKenzies",
    "Slipknot",
    "Beartooth",
    "DropkickMurphys",
  ];

  final List<String> pathTheRealMcKenzies = [
    "assets/the_real_mckenzies/the_real_mckenzies.jpg",
    "assets/the_real_mckenzies/off_the_leash.jpg",
    "assets/the_real_mckenzies/westwinds.jpg",
    "assets/the_real_mckenzies/two_devils_will_talk.jpg",
    "assets/the_real_mckenzies/beer_and_loathing.jpg",
  ];
  final List<String> albumTheRealMcKenzies = [
    "The Real McKenzies",
    "Off The Leash",
    "Westwinds",
    "Two Devils Will Talk",
    "Beer And Loathing",
  ];

  final List<String> pathSlipknot = [
    "assets/slipknot/slipknot.jpg",
    "assets/slipknot/lowa.jpg",
    "assets/slipknot/the_gray_chapter.jpg",
    "assets/slipknot/we_are_not_your_king.jpg"
  ];
  final List<String> albumSlipknot = [
    "Slipknot",
    "Lowa",
    "The Gray Chapter",
    "We Are Not Your Kind",
  ];

  final List<String> pathBeartooth = [
    "assets/beartooth/disgusting.jpg",
    "assets/beartooth/aggressive.jpg",
    "assets/beartooth/disease.jpg",
  ];
  final List<String> albumBeartooth = [
    "Disgusting",
    "Aggressive",
    "Disease",
  ];

  final List<String> pathDropkickMurphys = [
    "assets/dropkick_murphys/the_warrior_s_code.jpg",
    "assets/dropkick_murphys/signed_and_sealed_in_blood.jpg",
  ];
  final List<String> albumDropkickMurphys = [
    "The Warrior's Code",
    "Signed And Sealed In Blood",
  ];

  final List<String> genreAlbum = ["Rap", "Pop", "Metal", "Rock"];
  int _row = 14;
  var dataAlbum = List.generate(14, (i) => List.generate(4, (j) => ""));

  @override
  Widget build(BuildContext context) {
    dataAlbum = [
      [
        pathTheRealMcKenzies[0],
        groupName[0],
        albumTheRealMcKenzies[0],
        genreAlbum[0]
      ],
      [
        pathTheRealMcKenzies[1],
        groupName[0],
        albumTheRealMcKenzies[1],
        genreAlbum[1]
      ],
      [
        pathTheRealMcKenzies[2],
        groupName[0],
        albumTheRealMcKenzies[2],
        genreAlbum[2]
      ],
      [
        pathTheRealMcKenzies[3],
        groupName[0],
        albumTheRealMcKenzies[3],
        genreAlbum[3]
      ],
      [
        pathTheRealMcKenzies[4],
        groupName[0],
        albumTheRealMcKenzies[4],
        genreAlbum[0]
      ],
      [pathSlipknot[0], groupName[1], albumSlipknot[0], genreAlbum[1]],
      [pathSlipknot[1], groupName[1], albumSlipknot[1], genreAlbum[2]],
      [pathSlipknot[2], groupName[1], albumSlipknot[2], genreAlbum[3]],
      [pathSlipknot[3], groupName[1], albumSlipknot[3], genreAlbum[0]],
      [pathBeartooth[0], groupName[2], albumBeartooth[0], genreAlbum[2]],
      [pathBeartooth[1], groupName[2], albumBeartooth[1], genreAlbum[0]],
      [pathBeartooth[2], groupName[2], albumBeartooth[2], genreAlbum[3]],
      [
        pathDropkickMurphys[0],
        groupName[3],
        albumDropkickMurphys[1],
        genreAlbum[0]
      ],
      [
        pathDropkickMurphys[1],
        groupName[3],
        albumDropkickMurphys[1],
        genreAlbum[0]
      ],
    ];

    //filteredAlbum = dataAlbum;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30.0,
                bottom: 10.0,
                right: 30.0,
              ),
              child: !isSearching
                  ? Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              'Musique Yannis',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF505050),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              this.isSearching = true;
                              filteredAlbum = dataAlbum;
                            });
                          },
                        ),
                      ],
                    )
                  : Row(children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                          ),
                          child: TextField(
                            onChanged: (value) {
                              _filterData(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search data",
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            this.isSearching = false;
                            filteredAlbum = dataAlbum;
                          });
                        },
                      ),
                    ]),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                      TextButton(
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
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: filteredAlbum.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          filteredAlbum[index][0],
                          height: 100,
                          width: 100,
                        ),
                        Text(filteredAlbum[index][1]),
                        Text(filteredAlbum[index][2]),
                        Text(filteredAlbum[index][3]),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _preFilterData(String value) {
    setState(() {
      preFilteredAlbum = [];
      for (int index = 0; index < _row; index++) {
        if (dataAlbum[index][3].toLowerCase().contains(value.toLowerCase()) == true) {
          preFilteredAlbum.add(dataAlbum[index]);
        }
      }
      filteredAlbum = preFilteredAlbum;
    });
  }

  void _filterData(String value) {
    setState(() {
      filteredAlbum = [];
      print(value);
      for (int index = 0; index < preFilteredAlbum.length; index++) {
        if (preFilteredAlbum[index][2].toLowerCase().contains(value.toLowerCase()) ==
                true ||
            preFilteredAlbum[index][1].toLowerCase().contains(value.toLowerCase()) ==
                true) {
          filteredAlbum.add(preFilteredAlbum[index]);
        }
        /*else if(dataAlbum[index][1].toLowerCase().contains(value.toLowerCase()) == true){
          filteredAlbum.add(dataAlbum[index]);
        }*/
      }
    });
  }
}
