import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utc_flutter_app/arguments/search_buses_arguments.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/homeTab/home_tab_provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/all_strings_class.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeTabProvider _homeTabProvider;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _homeTabProvider = Provider.of<HomeTabProvider>(context, listen: false);
    // getLoginTime();
    // _homeTabProvider.getRecentSearches();
    // _homeTabProvider.setLoading(true);
    Future.delayed(const Duration(milliseconds: 300), () async {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        if (AppConstants.HIT_FIRST_TIME == false) {
          _homeTabProvider.getRecentSearches();
          _homeTabProvider.getPhoneNumber();
          if(AppConstants.USER_MOBILE_NO==""){
            _homeTabProvider.getDashboardData("1000000000",context);
          }else{
            _homeTabProvider.getDashboardData(AppConstants.USER_MOBILE_NO,context);
          }
        }
      } else {
        CommonMethods.showNoInternetDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _homeTabProvider.getPhoneNumber();

    return Consumer<HomeTabProvider>(builder: (_, homeTabProvider, __) {
      return Scaffold(
        key: _key,
        endDrawerEnableOpenDragGesture: true,
        appBar: appBarSection(),
        endDrawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(

            children: [
              Stack(
                children: [
                  Visibility(
                      visible: homeTabProvider.isLoading ? false : true,
                      child: newLayout(homeTabProvider)),
                  Visibility(
                      visible: homeTabProvider.isLoading ? true : false,
                      child: shimmerLayout(homeTabProvider)),
                ],
              ),
              aboutStarBus(homeTabProvider)
            ],
          ),
        ),
        // floatingActionButton: floatingAlertButton(homeTabProvider),
      );
    });
  }

  newLayout(HomeTabProvider homeTabProvider) {
    return Container(
      color: HexColor(MyColors.homegrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // searchBusSection(homeTabProvider),
          newSearchBusSection(homeTabProvider),
          tabsInHomePage(homeTabProvider),
          recentSearchSection(homeTabProvider),
          // popularRoutesSection(homeTabProvider),
          offersSection(homeTabProvider),
          // lastTransaction(homeTabProvider),
          // aboutStarBus()
        ],
      ),
    );
  }

  newSearchBusSection(HomeTabProvider homeTabProvider) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchBusSection(homeTabProvider),
        ],
      ),
    );
  }

  appBarSection() {
    return AppBar(
      backgroundColor: HexColor(MyColors.primaryColor),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Align(
        alignment: Alignment.topLeft,
        child: Row(
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
    );
  }

  searchBusesButton() {
    return InkWell(
      onTap: () => validationForSearchBus(context),
      child: Container(
        height: 45,
        margin: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: HexColor(MyColors.orange),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  "assets/images/buslogo.png",
                  color: HexColor(MyColors.white),
                ),
              ),
              Text(
                'Search Buses',
                style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  searchBusSection(HomeTabProvider homeTabProvider) {
    return Column(
      children: [
        Card(
          shadowColor: HexColor(MyColors.lightBlack),
          elevation: 2,
          child: Column(
            children: [
              selectSourceAndDestination(homeTabProvider),
              Divider(),
              // selectDateLayout()
              newDatePickerLayout(homeTabProvider),
              searchBusesButton(),


              // selectDateSection(homeTabProvider)
            ],
          ),
        ),
        // searchBusesButton(),
      ],
    );
  }

  offersSection(HomeTabProvider homeTabProvider) {
    return Visibility(
      visible: homeTabProvider.offers.isEmpty ? false : true,
      // visible: true,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardHeadline("Offer/Discounts"),
            offerListBuilder(homeTabProvider)
          ],
        ),
      ),
    );
  }

  recentSearchSection(HomeTabProvider homeTabProvider) {
    return Visibility(
      visible: homeTabProvider.recentSearchData1.isEmpty ? false : true,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardHeadline("Recent searches"),
            recentSearchListBuilder(homeTabProvider)
          ],
        ),
      ),
    );
  }

  recentSearchListBuilder(HomeTabProvider homeTabProvider) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: homeTabProvider.recentSearchData1.length,
        itemBuilder: (BuildContext context, int index) {
          return recentSearchNewListItem(homeTabProvider, index);
        },
      ),
    );
  }

  dashboardHeadline(String text) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 15),
        child: Text(
          text,
          style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600),
        ));
  }

  dashboardHelpHeadline(String text) {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Text(
          text,
          style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w700),
        ));
  }

  aboutStarBusSection(HomeTabProvider homeTabProvider) {
    return Visibility(
      visible: false,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        color: Colors.grey,
        height: 200,
        child: Center(
          child: Text("About StarBus*"),
        ),
      ),
    );
  }

  validationForSearchBus(BuildContext context) async {
    if (_homeTabProvider.dashBoardDate == "") {
      _homeTabProvider.dashBoardDate =
          AppConstants.formatter.format(DateTime.now());
    }
    AppConstants.JOURNEY_DATE = _homeTabProvider.dashBoardDate;

    if (AppConstants.SELECTED_SOURCE == "") {
      CommonMethods.showSnackBar(context, "Please select source");
    } else if (AppConstants.SELECTED_DESTINATION == "") {
      CommonMethods.showSnackBar(context, "Please select destination");
    } else if (AppConstants.SELECTED_SOURCE ==
        AppConstants.SELECTED_DESTINATION) {
      CommonMethods.showSnackBar(
          context, "Source and destination will not same !");
    } else if (AppConstants.JOURNEY_DATE == "") {
      CommonMethods.showSnackBar(context, "Please select journey date");
    } else {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        //print(AppConstants.SELECTED_SOURCE + "====>" + AppConstants.SELECTED_DESTINATION);
        Navigator.pushNamed(context, MyRoutes.searchBuses,
            arguments: SearchBusesArguments(
                AppConstants.SELECTED_DESTINATION,
                AppConstants.SELECTED_SOURCE,
                _homeTabProvider.dashBoardDate,
                AppConstants.SERVICE_TYPE_ID));
        _homeTabProvider.setRecentSearches(
            "1",
            "2",
            "Delhi",
            "Dehradun",
            AppConstants.SELECTED_SOURCE,
            AppConstants.SELECTED_DESTINATION,
            AppConstants.JOURNEY_DATE);
      } else {
        CommonMethods.showNoInternetDialog(context);
      }
    }
  }

  recentSearchNewListItem(HomeTabProvider homeTabProvider, int index) {
    Future<void> _selectRecentDate(BuildContext context) async {
      DateTime selectedDate = DateTime.now();
      DateTime lastDate = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day + AppConstants.ADVANCE_DAYS_BOOKING);
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        lastDate: lastDate,
        confirmText: "OK",
        // to Hide it, we use this
        cancelText: "Cancel",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.from(
              // colorScheme: ColorScheme
              colorScheme: ColorScheme.light(
                  primary: HexColor(MyColors.primaryColor)), //Background color
            ),
            child: child!,
          );
        },
      );
      homeTabProvider.setDateTime(picked!, true);
      final String formattedDate = AppConstants.formatter.format(picked);
      _homeTabProvider.setDate(formattedDate);
      homeTabProvider.setSourceAndDestinationName(
          homeTabProvider.recentSearchData1[index].sourceStation,
          homeTabProvider.recentSearchData1[index].destinationStation);
      validationForSearchBus(context);
    }

    return InkWell(
      onTap: () => _selectRecentDate(context),
      child: Card(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: EdgeInsets.all(12.0),
              //   child: Image.asset("assets/images/greenbusicon.png"),
              // ),
              Padding(
                padding: EdgeInsets.only(right: 15, top: 10, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          homeTabProvider
                              .recentSearchData1[index].sourceStation,
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          " To",
                          style: GoogleFonts.nunito(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Text(
                        homeTabProvider
                            .recentSearchData1[index].destinationStation,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                        )),
                    Text(homeTabProvider.recentSearchData1[index].searchDate,
                        style: GoogleFonts.nunito(
                            fontSize: 10, color: HexColor(MyColors.grey1))),
                    Container(
                      margin: EdgeInsets.only(left: 80),
                      alignment: Alignment.topRight,
                      child: Text("Book Now",
                          style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: HexColor(MyColors.primaryColor))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  offerListBuilder(HomeTabProvider homeTabProvider) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: homeTabProvider.offers.length,
        // itemCount:! homeTabProvider.getDashboardResponse.offers!.length,
        itemBuilder: (BuildContext context, int index) { return offersListItems(homeTabProvider, index);
        },
      ),
    );
  }

  offersListItems(HomeTabProvider homeTabProvider, int index) {
    // //print(AppConstants.OFFER_IMAGE_URL + homeTabProvider.getDashboardResponse.offers![index].couponid.toString() + "_M.png");
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(
        AppConstants.OFFER_IMAGE_URL + homeTabProvider.getDashboardResponse.offers![index].couponid.toString() + "_M.png",
        fit: BoxFit.fill,
      ),
    );
  }

  aboutStarBus(HomeTabProvider homeTabProvider) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About StarBus*",
            style:
                GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(8),
              color: HexColor(MyColors.aboutBg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child:
                                Image.asset("assets/images/cleanbusicon.png"),
                          )),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Clean Buses",
                              style: GoogleFonts.nunito(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Regular cleaning & sanitization is followed. All the touch points in the bus undergo deep cleaning and sanitization.",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Regular Fare",
                              style: GoogleFonts.nunito(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Minimum fare price for every ride with StarBus* . Bus pass facility will be there soon.",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                                "assets/images/regularfareicon.png"),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child:
                                Image.asset("assets/images/superfasticon.png"),
                          )),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Super fast",
                              style: GoogleFonts.nunito(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "StarBus* provide the best routes for the destination as well as fastest service in the mountain all over the India.",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Help Desk",
                style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone,color: HexColor(MyColors.primaryColor),size: 20,),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: ()async {
                      String urlName = "tel:"+AppConstants.HELP_DESK_PHONE;
                      var url = urlName.toString();
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(AppConstants.HELP_DESK_PHONE,textAlign:TextAlign.center,style: GoogleFonts.nunito(
                        decoration: TextDecoration.underline,
                        color: HexColor(MyColors.primaryColor),
                        fontSize: 15,fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email,color: HexColor(MyColors.primaryColor),size: 20,),
                  SizedBox(width: 10,),
                  Text(AppConstants.HELP_DESK_EMAIL,textAlign:TextAlign.center,style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontSize: 15,fontWeight: FontWeight.w600),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  newDatePickerLayout(HomeTabProvider homeTabProvider) {

    Future<void> _selectDate(BuildContext context) async {
      DateTime selectedDate = DateTime.now();
      DateTime lastDate = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day + AppConstants.ADVANCE_DAYS_BOOKING);
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: homeTabProvider.setDateINCal(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: selectedDate,
        lastDate: lastDate,
        confirmText: "OK",
        // to Hide it, we use this
        cancelText: "Cancel",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.from(
              // colorScheme: ColorScheme
              colorScheme: ColorScheme.light(
                  primary: HexColor(MyColors.primaryColor)), //Background color
            ),
            child: child!,
          );
        },
      );
      homeTabProvider.setDateTime(picked!, true);
      final String formattedDate = AppConstants.formatter.format(picked);
      homeTabProvider.setDate(formattedDate);
    }

    // AppConstants.JOURNEY_DATE = AppConstants.formatter.format(DateTime.now());
    final now = DateTime.now();
    final endDate = DateTime(now.year, now.month, now.day + AppConstants.ADVANCE_DAYS_BOOKING);
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Date',
            style: GoogleFonts.nunito(
                color: HexColor(MyColors.primaryColor), fontSize: 10),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Expanded(
                  child: FlutterDatePickerTimeline(
                    startDate: DateTime.now(),
                    endDate: endDate,
                    initialSelectedDate: homeTabProvider.setDateINCal(),
                    initialFocusedDate: homeTabProvider.setDateINCal(),
                    selectedItemBackgroundColor: HexColor(MyColors.primaryColor),
                    onSelectedDateChange: (DateTime? date) {
                      homeTabProvider.dashBoardDate = AppConstants.formatter.format(date!);
                      AppConstants.JOURNEY_DATE = homeTabProvider.dashBoardDate;
                      homeTabProvider.setDateTime(date, true);
                      //print(date);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // _show();
                    _selectDate(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenDatePicker()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/calendericon.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  selectSourceAndDestination(HomeTabProvider homeTabProvider) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AllStringsClass.from,
                        style: GoogleFonts.nunito(
                            color: HexColor(MyColors.primaryColor),
                            fontSize: 10),
                      ),
                      InkWell(
                        onTap: () {
                          homeTabProvider.source(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            AppConstants.SELECTED_SOURCE.isNotEmpty
                                ? AppConstants.SELECTED_SOURCE
                                : 'Select Source',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                color: HexColor(MyColors.primaryColor),
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    height: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To',
                        style: GoogleFonts.nunito(
                            color: HexColor(MyColors.primaryColor),
                            fontSize: 10),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            homeTabProvider.destination(context);
                            // Navigator.pushNamed(context, MyRoutes.selectPlace, arguments: SearchStationArguments("T"));
                          },
                          child: Text(
                            AppConstants.SELECTED_DESTINATION.isNotEmpty
                                ? AppConstants.SELECTED_DESTINATION
                                : 'Select Destination',
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                color: HexColor(MyColors.primaryColor),
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  homeTabProvider.swap(AppConstants.SELECTED_SOURCE,
                      AppConstants.SELECTED_DESTINATION);
                },
                child: Image.asset(
                  'assets/images/arrowicon.png',
                  height: 35,
                  width: 35,
                ),
              ))
        ],
      ),
    );
  }

  tabsInHomePage(HomeTabProvider homeTabProvider) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width,
              color: HexColor(MyColors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Quick Access",
                  style: GoogleFonts.nunito(
                      fontSize: 15, color: HexColor(MyColors.black)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MyRoutes.activeBookingScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: HexColor(MyColors.white),
                      margin: EdgeInsets.all(1),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/active.png",
                            height: 25,
                            width: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Active bookings",
                              style: GoogleFonts.nunito(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.rateScreenList);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: HexColor(MyColors.white),
                      margin: EdgeInsets.all(1),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/rateusicon.png",
                            color: HexColor(MyColors.primaryColor),
                            height: 25,
                            width: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Rate us",
                              style: GoogleFonts.nunito(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MyRoutes.activeBookingScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: HexColor(MyColors.white),
                      margin: EdgeInsets.all(1),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/ticketicon.png",
                            color: HexColor(MyColors.primaryColor),
                            height: 25,
                            width: 25,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                                child: Text(
                              "Download e-ticket",
                              style: GoogleFonts.nunito(fontSize: 10),
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.all(5),
                //     color: HexColor(MyColors.white),
                //     color: HexColor(MyColors.white),
                //     margin: EdgeInsets.all(1),
                //     child: Column(
                //       children: [
                //         Image.asset(
                //           "assets/images/bellicon.png",
                //           color: HexColor(MyColors.primaryColor),
                //           height: 25,width: 25,),
                //         Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: Text("Alerts",style: GoogleFonts.nunito(fontSize: 10),),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.locateMyBusScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: HexColor(MyColors.white),
                      margin: EdgeInsets.all(1),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/location.png",
                            color: HexColor(MyColors.primaryColor),
                            height: 25,
                            width: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Track/Locate bus",
                              style: GoogleFonts.nunito(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.raiseAlarmScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: HexColor(MyColors.white),
                      margin: EdgeInsets.all(1),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/bellicon.png",
                            color: HexColor(MyColors.primaryColor),
                            height: 25,
                            width: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Raise Alarm",
                              style: GoogleFonts.nunito(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: HexColor(MyColors.white),
                          margin: EdgeInsets.all(1),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/downarrow.png",
                                color: HexColor(MyColors.primaryColor),
                                height: 25,
                                width: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "View more",
                                  style: GoogleFonts.nunito(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.all(5),
                //     color: HexColor(MyColors.white),
                //     margin: EdgeInsets.all(1),
                //     child: Column(
                //       children: [
                //         Image.asset(
                //           "assets/images/location.png",
                //           color: HexColor(MyColors.primaryColor),
                //           height: 25,width: 25,),
                //         Padding(
                //           padding: const EdgeInsets.all(3.0),
                //           child: Text("Track bus",style: GoogleFonts.nunito(fontSize: 10),),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ));
  }

  showSessionTimeOutDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          "assets/images/sessionclock.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      "Your session is expire",
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    Center(
                        child: Text(
                      "Please login again !",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // showRaiseAlarmDialog();
                        logOut();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.green),
                        ),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                "Login ",
                                style: GoogleFonts.nunito(
                                    color: HexColor((MyColors.white))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void getLoginTime() async {
    await _homeTabProvider.getLoginDateTime();
    //print(_homeTabProvider.loginDateTime);
    DateTime loginDateTime = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(_homeTabProvider.loginDateTime);
    final dateNow = DateTime.now();
    //print(loginDateTime.toString() + "=====>" + dateNow.toString());
    final difference = dateNow.difference(loginDateTime).inHours;
    //print("DIFFRENCE" + difference.toString());
    if (difference >= 24) {
      showSessionTimeOutDialog();
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

  // floatingAlertButton(HomeTabProvider homeTabProvider) {
  //   return Visibility(
  //     // visible: homeTabProvider.allAlerts.isEmpty?false:true,
  //     child: Container(
  //       height: 50,
  //       width: 50,
  //       alignment: Alignment.bottomRight,
  //       child: Stack(
  //         children: [
  //           FloatingActionButton(
  //               onPressed: () {
  //                 Navigator.pushNamed(context, MyRoutes.alertsSCreen);
  //               },
  //               backgroundColor: HexColor(MyColors.orange),
  //               child: Image.asset(
  //                 "assets/images/bellicon.gif",
  //                 height: 30,
  //                 width: 30,
  //               )),
  //           Align(
  //             alignment: Alignment.topRight,
  //             child: Container(
  //               height: 18,
  //               width: 18,
  //               decoration: BoxDecoration(
  //                   color: HexColor(MyColors.redColor),
  //                   borderRadius: BorderRadius.circular(100)),
  //               alignment: Alignment.topLeft,
  //               // child: Center(child: Text(homeTabProvider.allAlerts.length.toString(),style: GoogleFonts.nunito(fontSize: 12,color: Colors.white),)),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  shimmerLayout(HomeTabProvider homeTabProvider) {
    return Shimmer.fromColors(
        baseColor: HexColor("#dddddd"),
        highlightColor: Colors.white,
        enabled: true,
        child: Column(
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 10,right: 15,left: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: HexColor("#dddddd"),
                  border: Border.all(
                    color:HexColor("#dddddd"),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10,top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: HexColor(MyColors.white),
                            margin: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/active.png",
                                  height: 25,
                                  width: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Active bookings",
                                    style: GoogleFonts.nunito(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: HexColor(MyColors.white),
                            margin: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/rateusicon.png",
                                  color: HexColor(MyColors.primaryColor),
                                  height: 25,
                                  width: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Rate us",
                                    style: GoogleFonts.nunito(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: HexColor(MyColors.white),
                            margin: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/ticketicon.png",
                                  color: HexColor(MyColors.primaryColor),
                                  height: 25,
                                  width: 25,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Center(
                                      child: Text(
                                        "Download e-ticket",
                                        style: GoogleFonts.nunito(fontSize: 10),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: HexColor(MyColors.white),
                            margin: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/location.png",
                                  color: HexColor(MyColors.primaryColor),
                                  height: 25,
                                  width: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Track/Locate bus",
                                    style: GoogleFonts.nunito(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: HexColor(MyColors.white),
                            margin: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/bellicon.png",
                                  color: HexColor(MyColors.primaryColor),
                                  height: 25,
                                  width: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Raise Alarm",
                                    style: GoogleFonts.nunito(fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Builder(
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                color: HexColor(MyColors.white),
                                margin: EdgeInsets.all(1),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/downarrow.png",
                                      color: HexColor(MyColors.primaryColor),
                                      height: 25,
                                      width: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "View more",
                                        style: GoogleFonts.nunito(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ],
                )),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 10,right: 15,left: 15),
                    width: 200,
                    decoration: BoxDecoration(
                        color: HexColor("#dddddd"),
                        border: Border.all(
                          color:HexColor("#dddddd"),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 10,right: 15,left: 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: HexColor("#dddddd"),
                        border: Border.all(
                          color:HexColor("#dddddd"),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
