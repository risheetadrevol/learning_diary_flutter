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
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  List myTempList = [];
  TextEditingController _nameCont = TextEditingController();
  List items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fortune Wheel'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _nameCont,
          ),
          IconButton(
              onPressed: () {
                myTempList.add(_nameCont.text);
                setState(() {});
                _nameCont.clear();
              },
              icon: Icon(Icons.add)),
          Table(
            children: myTempList
                .map((e) => TableRow(children: [
                      Text(e),
                    ]))
                .toList(),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  items = myTempList;
                });
              },
              child: Text("Get Truth")),
          if (items.isNotEmpty)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected.add(
                      Fortune.randomInt(0, items.length),
                    );
                  });
                },
                child: Column(
                  children: [
                    Expanded(
                      child: FortuneBar(
                        selected: selected.stream,
                        items: [
                          for (var it in items)
                            FortuneItem(
                                style: FortuneItemStyle(color: Colors.yellow),
                                child: Text(it)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
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
