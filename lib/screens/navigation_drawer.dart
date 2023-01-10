import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/arguments/my_bookings_arguments.dart';
import 'package:utc_flutter_app/arguments/web_page_url_arguments.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/notifications_class.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  NavigationDrawerState createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {
  late NotificationApis notificationApi;

  @override
  void initState(){
    notificationApi = NotificationApis();
    notificationApi.intialize();
    super.initState();


}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // color: Colors.grey,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              color: HexColor(MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Align(
                      alignment: Alignment.topLeft,
                      child:Row(
                        children: [
                          Text(
                            "StarBus*",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            color: HexColor(MyColors.white),
                            margin: EdgeInsets.only(left: 4, right: 1),
                            width: 1,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 5),
                            child: Text(
                              "UTC Pathik",
                              style: GoogleFonts.oleoScript(
                                fontSize: 20,
                                color: HexColor(MyColors.green),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: AppConstants.USER_MOBILE_NO == "" ? false : true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: HexColor(MyColors.white),
                                size: 17,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  AppConstants.USER_NAME,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: HexColor(MyColors.white),
                                  size: 17,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    AppConstants.USER_MOBILE_NO,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            menuItems("assets/images/getonbus.png", "Active bookings"),
            menuItems("assets/images/eticket.png", "Download e-ticket"),
            menuItems("assets/images/cancelticket.png", "Cancel tickets"),
            menuItems("assets/images/refund.png", "Refund status"),
            // menuItems("assets/images/tour.png", "Tour package"),
            menuItems("assets/images/meal.png", "Meal on wheel"),
            // menuItems("assets/images/resechudle.png", "Re-schedule"),
            // menuItems("assets/images/mytransation.png", "My transaction"),
            SizedBox(
              height: 10,
            ),
            Divider(),
            menuItems(
                "assets/images/locatiooutline.png", "Track/Locate my bus"),
            // menuItems("assets/images/contactbus.png","Contact driver/conductor"),
            menuItems("assets/images/rateusicon.png", "Rate us"),
            menuItems("assets/images/registercomplaints.png", "Register complaint"),
            menuItems("assets/images/complaints.png", "Know complaints status"),
            // menuItems("assets/images/needhelp.png", "Need any help"),
            SizedBox(
              height: 10,
            ),
            Divider(),
            menuItems("assets/images/exiticon.png", "Logout/Exit"),

          ],
        ),
      ),
    );
  }

  menuItems(String imagePath, String itemsName) {
    return GestureDetector(
      onTap: () => clickOnMenuItems(itemsName),
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 10),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 25,
              width: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                itemsName,
                style: GoogleFonts.nunito(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildheader({required String name, required String email}) {
    return Container(
      child: Row(
        children: [
          Image.asset("assets/images/starbusNewLogo.png"),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white70, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildmenuitems({required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.grey;
    final hovercolor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
      hoverColor: hovercolor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 1:
        //print(index);
        Navigator.pushNamed(context, MyRoutes.viewAllOffers);
        break;
      case 2:
        //print(index);
        Navigator.pushNamed(context, MyRoutes.registerComplaintScreen);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => dept()));
        break;
      case 3:
        //print(index);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => contactus()));
        break;
      case 8:
        //print(index);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => faqs()));
        break;
      case 9:
        //print(index);
        CommonMethods.showLoadingDialog(context);
        await MemoryManagement.clearAllDataInSharedPref();
        AppConstants.HIT_FIRST_TIME = false;
        AppConstants.USER_MOBILE_NO = "";
        await MemoryManagement.prefs.clear();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, MyRoutes.getPhoneNumberScreen);
        break;
      case 10:
        //print(index);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => settings()));
        break;
    }
  }

  //amazewish
  clickOnMenuItems(String itemsName) {
    Navigator.pop(context);
    if (itemsName == "Logout/Exit") {
      logOut();
    } else if (itemsName == "My transaction") {
      Navigator.pushNamed(context, MyRoutes.myTransactionScreen);
    } else if (itemsName == "Active bookings") {
      Navigator.pushNamed(context, MyRoutes.activeBookingScreen);
    } else if (itemsName == "Download e-ticket") {
      Navigator.pushNamed(context, MyRoutes.activeBookingScreen);
    } else if (itemsName == "Cancel tickets") {
      Navigator.pushNamed(context, MyRoutes.cancelTicketListScreen);
      // Navigator.pushNamed(context, MyRoutes.allBookingHistoryScreen,arguments: MyBookingsArguments("Cancel"));
    } else if (itemsName == "Re-schedule") {
      Navigator.pushNamed(context, MyRoutes.allBookingHistoryScreen,
          arguments: MyBookingsArguments("Re-schedule"));
    } else if (itemsName == "Track/Locate my bus") {
      Navigator.pushNamed(context, MyRoutes.locateMyBusScreen);
    } else if (itemsName == "Rate us") {
      Navigator.pushNamed(context, MyRoutes.rateScreenList);
    } else if (itemsName == "Know complaints status") {
      Navigator.pushNamed(context, MyRoutes.complaintsScreen);
    } else if (itemsName == "Refund status") {
      Navigator.pushNamed(context, MyRoutes.refundStatusScreen);
    }else if (itemsName == "Register complaint") {
      Navigator.pushNamed(context, MyRoutes.registerComplaintScreen);
    }else if (itemsName == "Meal on wheel") {
      Navigator.pushNamed(context, MyRoutes.webPagesScreen,arguments: WebPageUrlArguments(AppConstants.MEAL_ON_WHEEL_URL, "Meal on wheel"));
      // notificationApi.showNotifications(0, "title", "Ashish");
    }else if (itemsName == "Tour package") {
      CommonMethods.showSnackBar(context, "Coming Soon ....");
    }else if (itemsName == "Need any help") {
      CommonMethods.showSnackBar(context, "Coming Soon ....");
    }

  }

  logOut() async {
    CommonMethods.showLoadingDialog(context);
    await MemoryManagement.clearAllDataInSharedPref();
    AppConstants.HIT_FIRST_TIME = false;
    AppConstants.USER_MOBILE_NO = "";
    await MemoryManagement.prefs.clear();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, MyRoutes.getPhoneNumberScreen);
  }

}
