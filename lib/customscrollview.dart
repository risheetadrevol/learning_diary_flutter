import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomScroll extends StatefulWidget {
  const CustomScroll({Key? key}) : super(key: key);

  @override
  State<CustomScroll> createState() => _CustomScrollState();
}

class _CustomScrollState extends State<CustomScroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: List.generate(
            30,
            (index) => SliverToBoxAdapter(
                  child: Container(
                      height: 300,
                      color: Color.fromARGB(
                          index + 200, index + 200, index + 200, 1)),
                )),
      ),
    );
  }
}
