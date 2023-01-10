import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class SelectPaymentOptionScreen extends StatefulWidget {
  const SelectPaymentOptionScreen({Key? key}) : super(key: key);

  @override
  _SelectPaymentOptionScreenState createState() => _SelectPaymentOptionScreenState();
}

class _SelectPaymentOptionScreenState extends State<SelectPaymentOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(MyColors.primaryColor),
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Select Payment Option"
        ),
      ),
      body: Container(

      ),

    );
  }
}
