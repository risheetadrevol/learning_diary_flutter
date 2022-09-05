import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pay/pay.dart';

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class PayMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay for Flutter Demo',
      localizationsDelegates: [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('de', ''),
      ],
      home: PaySampleApp(),
    );
  }
}

class PaySampleApp extends StatefulWidget {
  PaySampleApp({Key? key}) : super(key: key);

  @override
  _PaySampleAppState createState() => _PaySampleAppState();
}

class _PaySampleAppState extends State<PaySampleApp> {
  DateTime time = DateTime.now();
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T-shirt Shop'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    minTime: DateTime.now(),
                    theme: DatePickerTheme(
                        doneStyle: TextStyle(color: Colors.amber),
                        containerHeight: 300,
                        itemHeight: 60,
                        titleHeight: 100),
                    showTitleActions: true, onConfirm: (date) {
                  setState(() {
                    time = date;
                  });
                }, currentTime: DateTime.now());
              },
              child: Text(
                'show date time picker (English-America)',
                style: TextStyle(color: Colors.blue),
              )),
          const Text(
            'Amanda\'s Polo Shirt',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$time',
            style: TextStyle(
              color: Color(0xff777777),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'A versatile full-zip that you can wear all day long and even...',
            style: TextStyle(
              color: Color(0xff777777),
              fontSize: 15,
            ),
          ),
          // GooglePayButton(
          //   paymentConfigurationAsset:
          //       'default_payment_profile_google_pay.json',
          //   paymentItems: _paymentItems,
          //   style: GooglePayButtonStyle.black,
          //   type: GooglePayButtonType.pay,
          //   margin: const EdgeInsets.only(top: 15.0),
          //   onPaymentResult: onGooglePayResult,
          //   loadingIndicator: const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
          // ApplePayButton(
          //   paymentConfigurationAsset: 'default_payment_profile_apple_pay.json',
          //   paymentItems: _paymentItems,
          //   style: ApplePayButtonStyle.black,
          //   type: ApplePayButtonType.buy,
          //   margin: const EdgeInsets.only(top: 15.0),
          //   onPaymentResult: onApplePayResult,
          //   loadingIndicator: const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
          const SizedBox(height: 15)
        ],
      ),
      bottomSheet: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Text("Arriving in 5 mins"),
          alignment: Alignment.center,
          width: double.infinity,
          color: Color.fromARGB(255, 255, 255, 0)),
    );
  }
}
