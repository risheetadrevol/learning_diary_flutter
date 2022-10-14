import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_projects/widgets.dart';

import 'stripe_payment_link.dart';

class CheckutList extends StatefulWidget {
  const CheckutList({Key? key}) : super(key: key);

  @override
  State<CheckutList> createState() => _CheckutListState();
}

class _CheckutListState extends State<CheckutList> {
  List myData = [];
  Stream productsStream() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 3000));
      final someProduct = await getRequest(
        endpoint: "checkout/sessions",
      );
      yield someProduct["data"];
    }
  }

  @override
  void initState() {
    super.initState();

    getRequest(
      endpoint: "checkout/sessions",
    ).then((val) {
      print(val);
      myData = val["data"];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: productsStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState==ConnectionState.active){
                return  ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final mylIST = snapshot.data[index];

                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Checkout(
                          myCheckoutData: mylIST,
                        );
                      }));
                    },
                    trailing: mylIST["payment_status"].toString() == "paid"
                        ? Icon(Icons.verified, color: Colors.green)
                        : null,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.richText(
                            description: mylIST["metadata"]["order_id"] ?? '',
                            title: "Order Id"),
                        Widgets.richText(
                            description: mylIST["metadata"]["name"] ?? '',
                            title: "Customer Name"),
                        Widgets.richText(
                            description: mylIST["metadata"]["contact_no"] ?? '',
                            title: "Customer Contact"),
                      ],
                    ),
                  );
                },
              );
              }
              else{
                return CircularProgressIndicator();
              }
            }));
  }
}

class Checkout extends StatefulWidget {
  const Checkout({Key? key, required this.myCheckoutData}) : super(key: key);
  final Map myCheckoutData;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List myCheckoutMap = [];
  @override
  void initState() {
    super.initState();
    postRequest(
        endpoint: "payment_links/${widget.myCheckoutData["payment_link"]}",
        myData: {"active": false}).then((val) {
      print(val);
    });
    myCheckoutMap = widget.myCheckoutData.entries.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: myCheckoutMap.length,
        itemBuilder: (BuildContext context, int index) {
          return Wrap(
            alignment: WrapAlignment.start,
            children: [
              if (myCheckoutMap[index].value != null)
                Text(" ${myCheckoutMap[index].key} ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              if (myCheckoutMap[index].value != null)
                SelectableText(
                  myCheckoutMap[index].value.toString(),
                ),
            ],
          );
        },
      ),
    );
  }
}
