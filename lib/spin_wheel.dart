import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:http/http.dart';

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortune Wheel Example',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  List myTempList = [
    "abc",
  ];
  TextEditingController _nameCont = TextEditingController(text: "bcd");
  List items = [];
  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fortune Wheel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameCont,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_nameCont.text.isNotEmpty && !isNumeric(_nameCont.text)) {
                    if (myTempList.indexWhere((element) =>
                            element.toString().toLowerCase() ==
                            _nameCont.text.toLowerCase()) ==
                        -1) {
                      myTempList.add(_nameCont.text);
                      setState(() {});
                      _nameCont.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("All name in list must be different"),
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please Enter valid name"),
                    ));
                  }
                },
                child: Text("Add Participants")),
            Table(
              children: myTempList
                  .map((e) => TableRow(children: [
                        Text(e),
                        IconButton(
                            onPressed: () {
                              // myTempList.remove(e);
                              // setState(() {});
                            },
                            icon: Icon(Icons.delete))
                      ]))
                  .toList(),
            ),
            ElevatedButton(
                onPressed: () {
                  if (myTempList.length > 1) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return TruthWheel(items: myTempList);
                    }));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Length of participants must be more than 1"),
                    ));
                  }
                },
                child: Text("Start Game")),
          ],
        ),
      ),
    );
  }

  getNotificationRequest(
      {required String token, required String title, required String body}) {
    String myKey = dotenv.get('VAR_NAME');
    post(Uri.parse("https://fcm.googleapis.com/fcm/send"), headers: {
      HttpHeaders.authorizationHeader: "key=$myKey",
      HttpHeaders.contentTypeHeader: "application/json",
    }, body: {
      "to": token,
      "data": {"body": body, "title": title}
    }).then((value) {
      print("value");
    });
  }
}

// curl -X POST \
//   https://fcm.googleapis.com/fcm/send \
//   -H 'Authorization: key=' \
//   -H 'Content-Type: application/json' \
//   -H 'Postman-Token: c8af5355-dbf2-4762-9b37-a6b89484cf07' \
//   -H 'cache-control: no-cache' \
//   -d '{
//     "to": "ey_Bl_xs-8o:APA91bERoA5mXVfkzvV6I1I8r1rDXzPjq610twte8SUpsKyCuiz3itcIBgJ7MyGRkjmymhfsceYDV9Ck-__ObFbf0Guy-P_Pa5110vS0Z6cXBH2ThnnPVCg-img4lAEDfRE5I9gd849d",
//     "data":{
//         "body":"Test Notification !!!",
//         "title":"Test Title !!!"
//     }

// }'

class TruthWheel extends StatefulWidget {
  const TruthWheel({Key? key, required this.items}) : super(key: key);
  final List items;
  @override
  State<TruthWheel> createState() => _TruthWheelState();
}

class _TruthWheelState extends State<TruthWheel> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected.add(
            Fortune.randomInt(0, widget.items.length),
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FortuneWheel(
          selected: selected.stream,
          items: [
            for (var it in widget.items) FortuneItem(child: Text(it)),
          ],
        ),
      ),
    );
  }
}
