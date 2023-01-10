import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utc_flutter_app/arguments/web_page_url_arguments.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/colors_code.dart';
import '../../utils/hex_color.dart';

class WebPagesScreen extends StatefulWidget {
  const WebPagesScreen({Key? key}) : super(key: key);

  @override
  State<WebPagesScreen> createState() => _WebPagesScreenState();
}

class _WebPagesScreenState extends State<WebPagesScreen> {
  bool isLoading=true;
  String webPageUrl =  "";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as WebPageUrlArguments;
    webPageUrl = args.url;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(MyColors.primaryColor),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
            args.from
        ),
      ),
      body: webView(),
    );
  }

  webView() {

    return Stack(
      children: [
        WebView(
          initialUrl:
          webPageUrl,
          javascriptMode:
          JavascriptMode.unrestricted,
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'Print',
                onMessageReceived: (JavascriptMessage message) {
                  //This is where you receive message from
                  //javascript code and handle in Flutter/Dart
                  //like here, the message is just being printed
                  //in Run/LogCat window of android studio
                  //print(message.message);
                })
          ]),
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },

        ),
        isLoading ? Center( child: CircularProgressIndicator(),)
            : Stack(),
      ],
    );

  }
}
