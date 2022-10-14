import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class PrintingClover extends StatefulWidget {
  const PrintingClover({Key? key}) : super(key: key);

  @override
  State<PrintingClover> createState() => _PrintingCloverState();
}

class _PrintingCloverState extends State<PrintingClover> {
  final TextEditingController orderController = TextEditingController();
  String myData = "";
  http.StreamedResponse? response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Order Id",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: orderController,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var headers = {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    'Authorization':
                        'Bearer '
                  };
                  var request = http.Request(
                      'POST',
                      Uri.parse(
                          'https://api.clover.com/v3/merchants//print_event'));
                  request.body = json.encode({
                    "orderRef": {"id": orderController.text}
                  });
                  request.headers.addAll(headers);

                  http.StreamedResponse responsed = await request.send();
                  print(responsed.statusCode);
                  response = responsed;
                  myData = await responsed.stream.bytesToString();
                  setState(() {});
                  if (responsed.statusCode == 200) {
                  } else {
                    print(responsed.reasonPhrase);
                  }
                },
                child: const Text("Printing reciept")),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Response",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            if (response != null) Text(response!.statusCode.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(myData),
            )
          ],
        ),
      ),
    );
  }
}
