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
  String name = "risheeta";
  List myTempList = List.filled(12, "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: name.length,
            itemBuilder: (BuildContext context, int index) {
              if (["a", "e", "i", "o", "u"].any((element) =>
                  element.toLowerCase() ==
                  name[index].toString().toLowerCase())) {
                return Text(name[index]);
              } else {
                return Container(
                    width: 40,
                    color: Colors.yellow,
                    child: TextFormField(
                      maxLength: 1,
                      decoration: InputDecoration(counter: Container()),
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
        ),
      ),
    );
  }
}
