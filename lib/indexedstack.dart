import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class IndexedCalenderView extends StatefulWidget {
  const IndexedCalenderView({Key? key}) : super(key: key);

  @override
  State<IndexedCalenderView> createState() => _IndexedCalenderViewState();
}

class _IndexedCalenderViewState extends State<IndexedCalenderView> {
  int currentIndex = 0;
  int mylistLength = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (currentIndex != 0) {
                      currentIndex -= 1;
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.skip_previous)),
              IconButton(
                  onPressed: () {
                    if (currentIndex != mylistLength - 1) {
                      currentIndex += 1;
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.skip_next))
            ],
          ),
          IndexedStack(
            index: currentIndex,
            children: List.generate(
                mylistLength,
                (index) => Container(
                    child: Text((index + 1).toString()),
                    color: index % 2 == 0 ? Colors.amber : Colors.red)),
          ),
        ],
      ),
    );
  }
}
