import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/homeTab/home_tab_provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabProvider>(builder: (_, homeTabProvider, __) {
      return Scaffold(
        endDrawerEnableOpenDragGesture: true,
        endDrawer: NavigationDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: HexColor(MyColors.primaryColor),
          title: Text("Alerts"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              // itemCount: homeTabProvider.allAlerts.length,
              // itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container();
              },
            )),
      );
    });

  }

/*  Widget alertsListItems(int index) {
    return Consumer<HomeTabProvider>(builder: (_, homeTabProvider, __) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 3,
              color: HexColor(MyColors.lightOrange),
              margin: EdgeInsets.only(right: 10),
            ),
            Image.asset("assets/images/alerticon.png",height: 40,width: 40,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeTabProvider.allAlerts[index].notice_category_name!,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      homeTabProvider.allAlerts[index].description!,
                      style: GoogleFonts.nunito(fontSize: 14),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }*/
}
