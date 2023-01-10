

import 'package:flutter/material.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class PaymentConditionsScreen extends StatefulWidget {
  const PaymentConditionsScreen({Key? key}) : super(key: key);

  @override
  _PaymentConditionsScreenState createState() => _PaymentConditionsScreenState();
}

class _PaymentConditionsScreenState extends State<PaymentConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(MyColors.primaryColor),
        title: Text("Payment Condition"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 200),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () { },
                child: Text('Payment Success'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () { },
                child: Text('Payment Failed'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () { },
                child: Text('Payment Cancel'),
              )

            ],
          ),
        ),
      ),
    );

  }
}
