import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CrossWord extends StatefulWidget {
  const CrossWord({Key? key}) : super(key: key);

  @override
  State<CrossWord> createState() => _CrossWordState();
}

class _CrossWordState extends State<CrossWord> {
  String name = "risheetaQPQWOEURYIROOQW";
  List myTempList = List.filled(12, "a");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          if (["a", "e", "i", "o", "u"].any((element) =>
              element.toLowerCase() == name[index].toString().toLowerCase())) {
            return Text(name[index]);
          } else {
            return Container(
                color: Colors.yellow,
                width: 30,
                child: TextFormField(
                  maxLength: 1,
                  decoration: InputDecoration(counterText: ""),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == name[index]) {
                      return null;
                    } else {
                      return "Incorrect";
                    }
                  },
                ));
          }
        },
      ),
    );
  }
}
