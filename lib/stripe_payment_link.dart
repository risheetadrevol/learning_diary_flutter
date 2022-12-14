import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_projects/checkout_page.dart';
import 'package:url_launcher/url_launcher.dart';

class StripePaymentLink extends StatefulWidget {
  const StripePaymentLink({Key? key}) : super(key: key);

  @override
  State<StripePaymentLink> createState() => _StripePaymentLinkState();
}

class _StripePaymentLinkState extends State<StripePaymentLink> {
  String name = "";
  String myNumber = "";
  String orderId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("JHGFJG"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80",
              height: 100,
            ),
          ),
          Icon(Icons.access_alarm),
          TextFormField(
            keyboardType: TextInputType.name,
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
            decoration: InputDecoration(hintText: "Name", labelText: "Name"),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (val) {
              setState(() {
                myNumber = val;
              });
            },
            decoration:
                InputDecoration(hintText: "Number", labelText: "Number"),
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            onChanged: (val) {
              setState(() {
                orderId = val;
              });
            },
            decoration:
                InputDecoration(hintText: "Order Id", labelText: "Order Id"),
          ),
          ElevatedButton(
              onPressed: () async {
                postRequest(endpoint: "products", myData: {
                  'name':
                      ' Name :$name Contact Number :$myNumber Order ID: $orderId '
                }).then((productData) {
                  postRequest(endpoint: "prices", myData: {
                    'product': productData["id"],
                    'unit_amount': '50',
                    'currency': 'usd'
                  }).then((priceData) {
                    postRequest(endpoint: "payment_links", myData: {
                      'line_items[0][price]': priceData["id"],
                      'line_items[0][quantity]': '1',
                      "metadata[order_id]": orderId,
                      "metadata[name]": name,
                      "metadata[contact_no]": myNumber,
                    }).then((linkData) {
                      print(linkData);
                      // launch(linkData["url"]);
                      postRequestTwillio(endpoint: "products", myData: {
                        'Body': 'Your payment link is ${linkData["url"]}',
                        'From': '+14127016182',
                        'To': myNumber
                      }).then((smsData) {});
                    });
                  });
                });
              },
              child: Text("Get Link"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CheckutList()));
        },
      ),
    );
  }
}

postRequest({required String endpoint, required Map myData}) async {
  try {
    final url = "https://api.stripe.com/v1/$endpoint";
    print(url);
    final myResponse = await Dio().postUri(Uri.parse(url),
        data: myData,
        options: Options(headers: {
          'Authorization':
              'Bearer sk_test_51LcQ9VSGa8P05XUnB0NNhmPH6PAwTyoUHCDAPzbDjIo7Tp5sPjA7e1W57RPkBU4NhyDMNkF3aySobIAxE36hzHTc002gytk0tN',
          'Content-Type': 'application/x-www-form-urlencoded'
        }));
    return myResponse.data;
  } catch (e) {
    if (e is DioError) {
      print(e.response);
      print(e.message);
    }
  }
}

getRequest({
  required String endpoint,
}) async {
  try {
    final url = "https://api.stripe.com/v1/$endpoint";
    print(url);
    final myResponse = await Dio().getUri(Uri.parse(url),
        options: Options(headers: {
          'Authorization':
              'Bearer ',
          'Content-Type': 'application/x-www-form-urlencoded'
        }));
    return myResponse.data;
  } catch (e) {
    if (e is DioError) {
      print(e.response);
      print(e.message);
    }
  }
}

postRequestTwillio({required String endpoint, required Map myData}) async {
  try {
    final url = "https://api.stripe.com/v1/$endpoint";
    print(url);
    final myResponse = await Dio().postUri(
        Uri.parse(
            'https://api.twilio.com/2010-04-01/Accounts/ACfc8c0275fe8f0588a1b6b00761d06af9/Messages.json'),
        data: myData,
        options: Options(headers: {
          'Authorization':
              'Basic QUNmYzhjMDI3NWZlOGYwNTg4YTFiNmIwMDc2MWQwNmFmOTpiMTNiNzgxYTk2MmI5MGViYjBiZWRmNmI3NTFiOTk3MQ==',
          'Content-Type': 'application/x-www-form-urlencoded'
        }));
    return myResponse.data;
  } catch (e) {
    if (e is DioError) {
      print(e.response);
      print(e.message);
    }
  }
}
