import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/web_view_paymwnt_screen_arguments.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen.dart';
import 'package:utc_flutter_app/screens/paymentWebViewScreen/payment_web_view_screen_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({Key? key}) : super(key: key);

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late PaymentWebViewScreenProvider _paymentWebViewScreenProvider;

  bool isLoading = true;
  String paymentGateWayUrl = "";

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirmation'),
            content: new Text('Please confirm your payment '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () {
                  _paymentWebViewScreenProvider.checkPaymentStatus(context);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    _paymentWebViewScreenProvider = Provider.of<PaymentWebViewScreenProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WebViewPaymentScreenArguments;
    _paymentWebViewScreenProvider.from = args.from;
    _paymentWebViewScreenProvider.paymentGatewayName = args.gatewayName;
    if (args.from == "PaymentScreen") {
      paymentGateWayUrl = AppConstants.PAYMENT_GATEWAY_URL +
          AppConstants.TOKEN +
          "&tk=" +
          args.ticketNo_OR_walletRefNo +
          "&pg=" +
          args.gatewayId +
          "&us=" +
          AppConstants.USER_MOBILE_NO +
          "&BW=B";
      _paymentWebViewScreenProvider.ticketNumber = args.ticketNo_OR_walletRefNo;
      //print(paymentGateWayUrl);
    } else if (args.from == "Wallet") {
      paymentGateWayUrl = AppConstants.PAYMENT_GATEWAY_URL +
          AppConstants.TOKEN +
          "&tk=" +
          args.ticketNo_OR_walletRefNo +
          "&pg=" +
          args.gatewayId +
          "&us=" +
          AppConstants.USER_MOBILE_NO +
          "&BW=W";
      // paymentGateWayUrl = paymentGateWayUrl+args.ticketNo_OR_walletRefNo;
      _paymentWebViewScreenProvider.wallettTxnRefrence = args.ticketNo_OR_walletRefNo;

      //print(paymentGateWayUrl);

    }

    // //print(paymentGateWayUrl);

    return Consumer<PaymentWebViewScreenProvider>(
      builder: (_, paymentWebViewScreenProvider, __) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: HexColor(MyColors.primaryColor),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    paymentWebViewScreenProvider.checkPaymentStatus(context);
                  },
                ),
                title: Text("Payment By " + _paymentWebViewScreenProvider.paymentGatewayName),
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: webView())),
        );
      },
    );
  }

  webView() {
    return Stack(
      children: [

        WebView(
          initialUrl: paymentGateWayUrl,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'Print',
                onMessageReceived: (JavascriptMessage message) {
                  //print(message.message);
                })
          ]),
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(),
      ],
    );
  }


   showDialogBox()  async {
    return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(title: new Text('Confirmation'), content: new Text('Please confirm your payment '), actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('Yes'),
        ),
      ],
    ),
    ));
  }


}
