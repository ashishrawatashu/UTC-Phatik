import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/fill_passengers_details_arguments.dart';
import 'package:utc_flutter_app/arguments/search_buses_arguments.dart';
import 'package:utc_flutter_app/arguments/seat_layout_boarding_arguments.dart';
import 'package:utc_flutter_app/response/bus_seat_layout_response.dart';
import 'package:utc_flutter_app/response/passenger_information_pojo.dart';
import 'package:utc_flutter_app/screens/busSeatLayoutScreen/bus_seat_layout_screen_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class BusSeatLayoutScreen extends StatefulWidget {
  const BusSeatLayoutScreen({Key? key}) : super(key: key);

  @override
  _BusSeatLayoutScreenState createState() => _BusSeatLayoutScreenState();
}

class _BusSeatLayoutScreenState extends State<BusSeatLayoutScreen> {
  late BusSeatLayoutProvider _busSeatLayoutProvider;
  bool isSleeper = false;
  bool lowerUpper = true;
  bool loading = true;

  // bool upper = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    Future.delayed(Duration.zero, () async {
      _busSeatLayoutProvider = Provider.of<BusSeatLayoutProvider>(context, listen: false);
      _busSeatLayoutProvider.maxSeat = 0;
      final args = ModalRoute.of(context)!.settings.arguments as SeatLayoutBoardingArguments;
      _busSeatLayoutProvider.dsvcId = args.dsvcId;
      _busSeatLayoutProvider.strpId = args.strpId;
      _busSeatLayoutProvider.fromStationId = args.fromStationId;
      _busSeatLayoutProvider.toStationId = args.toStationId;
      _busSeatLayoutProvider.tripType = args.tripType;
      _busSeatLayoutProvider.amenitiesUrlList = args.amenitiesUrlList;

      await _busSeatLayoutProvider.getSeatLayoutBoardingResponse(args.dsvcId, AppConstants.JOURNEY_DATE, args.strpId, _busSeatLayoutProvider.toStationId,context);

    });
  }

  List<BusSeatLayoutResponse> fetchPosts(dynamic response) {
    return (response as List).map((p) => BusSeatLayoutResponse.fromJson(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    //print("busSeatLayoutList");
    return Consumer<BusSeatLayoutProvider>(
      builder: (_, busSeatLayoutProvider, __) {
        return Scaffold(body: busSeatSectionLayout(busSeatLayoutProvider));
      },
    );
  }

  Widget busSeatSectionLayout(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Container(
      color: HexColor(MyColors.grey2),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topAppBarSection(),
          Expanded(
              child: Stack(
            children: [
               Visibility(
                visible: busSeatLayoutProvider.isLoading ? false : true,
                child: Column(
                  children: [
                    bookingProcessLayout(),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                            child: Text("You can select maximun "+AppConstants.MAX_SEAT_SELECT.toString()+" seats"))),
                    Expanded(
                      child: busSeatLayoutProvider.isLoading
                          ? CommonWidgets.buildCircularProgressIndicatorWidget()
                          : Row(
                              children: [
                                Expanded(
                                    child: Container(
                                     child: isSleeper
                                      ? layoutForTabSleeper(busSeatLayoutProvider)
                                      : busSeatLayout(busSeatLayoutProvider),
                                )),
                                // Align(
                                //   alignment: Alignment.topRight,
                                //   child: Container(
                                //     margin: EdgeInsets.only(top: 100, right: 10),
                                //     child: GestureDetector(
                                //       onTap: () {
                                //         showCustomDialog(context);
                                //       },
                                //       child: Image.asset("assets/images/infoicon.png",
                                //         height: 35,
                                //         width: 35,),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                    ),
                    busSeatTypesSection(busSeatLayoutProvider),
                    bottomSection(busSeatLayoutProvider),
                  ],
                ),
              ),
              Visibility(
                  visible: busSeatLayoutProvider.isLoading ? true : false,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget())
            ],
          ))
        ],
      ),
    );
  }

  Widget topAppBarSection() {
    return Container(
      // height: 220,
      color: HexColor(MyColors.primaryColor),
      padding: EdgeInsets.only(top: 45, bottom: 10),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/topbussearchbg.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.arrow_back, color: Colors.white)),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.SERICE_TYPE_NAME,
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      AppConstants.SELECTED_SOURCE +
                          "-" +
                          AppConstants.SELECTED_DESTINATION,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          // fontWeight: FontWeight.w300,
                          color: HexColor(MyColors.white)),
                    ),
                    Text(
                      AppConstants.JOURNEY_DATE +
                          " , " +
                          AppConstants.JOURNEY_TIME,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: HexColor(MyColors.white)),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget busSeatLayout(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Visibility(
      visible: busSeatLayoutProvider.seatLayouLboardingResponse.lowerLayout!.isEmpty?false:true,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: HexColor(MyColors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: SingleChildScrollView(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: busSeatLayoutProvider
                  .seatLayouLboardingResponse.lowerLayoutRowCol![0].noofcolumns!,
              // crossAxisSpacing: 2,
              mainAxisSpacing: 5.0,
            ),
            itemCount: busSeatLayoutProvider
                    .seatLayouLboardingResponse.lowerLayoutRowCol![0].noofrows! *
                busSeatLayoutProvider.seatLayouLboardingResponse
                    .lowerLayoutRowCol![0].noofcolumns!,
            itemBuilder: (context, index) {
              return Visibility(
                  visible: busSeatLayoutProvider.getVisibilityOfSeats(index),
                  child: GestureDetector(
                    onTap: () {
                      busSeatLayoutProvider.selectDeselectSeats(index);
                      busSeatLayoutProvider.setImageOnSelectSeat(index);
                      setState(() {
                        if (busSeatLayoutProvider.maxSeat == AppConstants.MAX_SEAT_SELECT) {
                          showMaximumSeatSelected(busSeatLayoutProvider);
                        }
                      });
                    },

                    child: Container(
                        // color: setColor(index),
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                              busSeatLayoutProvider.setImageOnSelectSeat(index)),
                          fit: BoxFit.fill,
                        )),
                        child: Center(
                          child: Text(
                            busSeatLayoutProvider.lowerSeatList[index].seatno
                                .toString(),
                            style: GoogleFonts.nunito(fontSize: 10),
                          ),
                        )),
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget layoutForSleeper(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(10),
            // color: Colors.blue,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lowerUpper = true;
                      });
                    },
                    child: Container(
                        height: 8,
                        width: 100,
                        color: Colors.green,
                        child: Center(child: Text("Lower"))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lowerUpper = false;
                      });
                    },
                    child: Container(
                        height: 8,
                        width: 100,
                        color: Colors.blue,
                        child: Center(child: Text("Upper"))),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            child: lowerUpper
                ? lowerSeatLayout(busSeatLayoutProvider)
                : upperSeatLayout(busSeatLayoutProvider),
          )
        ],
      ),
    );
  }

  Widget layoutForTabSleeper(BusSeatLayoutProvider busSeatLayoutProvider) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              // color: Colors.blue,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    TabBar(
                      tabs: [
                        Container(
                          height: 50,
                          // color: Colors.blue,
                          child: Center(
                            child: Text(
                              "Lower",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          // color: Colors.blue,
                          child: Center(
                            child: Text(
                              "Upper",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[lowerSeatLayout(busSeatLayoutProvider)],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[upperSeatLayout(busSeatLayoutProvider)],
                ),
              )
            ],
          )),
    );
  }

  Widget upperSeatLayout(BusSeatLayoutProvider busSeatLayoutProvider) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
        // color: Colors.yellow,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Visibility(
              visible: busSeatLayoutProvider.setLayoutInLowerBirth(index),
              child: Container(
                // color: setColor(index),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/bedsleepr.png"),
                  fit: BoxFit.cover,
                )),
                child: Center(child: Text("")),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget lowerSeatLayout(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 50, right: 55, top: 10),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/driver.png",
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 50),
          // color: Colors.yellow,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: busSeatLayoutProvider.seatLayouLboardingResponse
                  .lowerLayoutRowCol![0].noofcolumns!,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: busSeatLayoutProvider.lowerSeatList.length,
            itemBuilder: (context, index) {
              return Visibility(
                visible: busSeatLayoutProvider.setLayoutInLowerBirth(index),
                child: Container(
                  // color: setColor(index),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/bedsleepr.png"),
                    fit: BoxFit.cover,
                  )),
                  child: Center(child: Text("")),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.asset("assets/images/seattgreen.png"),
                        Text(
                          "Selected",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.grey),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.asset("assets/images/seatblue.png"),
                        Text(
                          "Seat Type",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.grey),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.asset("assets/images/seatyellow.png"),
                        Text(
                          "Seat Type",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.grey),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.asset("assets/images/seatgrey.png"),
                        Text(
                          "Available",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.grey),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.asset("assets/images/seatpurple.png"),
                        Text(
                          "Seat Type",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              color: Colors.grey),
                        )
                      ],
                    )),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  Widget bottomSection(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Column(
      children: [
        Container(
          height: Platform.isIOS ? 70 : 60,
          padding: Platform.isIOS
              ? EdgeInsets.only(bottom: 10)
              : EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            color: HexColor(MyColors.white),
            boxShadow: [
              BoxShadow(
                // color: Colors.grey,
                offset: Offset(5.0, 0.0), //(x,y)
                blurRadius: 0.1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => showBusDetailsBottomSheet(busSeatLayoutProvider),
                child: Container(
                  color: HexColor(MyColors.primaryColor),
                  padding: EdgeInsets.only(left: 3),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "BUS\nDETAILS",
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: HexColor(MyColors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: HexColor(MyColors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        busSeatLayoutProvider.selectSeatText(),
                        style: GoogleFonts.nunito(
                            color: HexColor(MyColors.grey1), fontSize: 14),
                      ),
                      Text(
                        busSeatLayoutProvider.concatSeatsNumber(),
                        style: GoogleFonts.nunito(
                            color: HexColor(MyColors.black),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (busSeatLayoutProvider.maxSeat == 0) {
                      CommonMethods.showSnackBar(context, "Please select seat !");
                    } else {
                      // continueSeatSelected(0, busSeatLayoutProvider);
                      showBoardingPointListBottomSheet(busSeatLayoutProvider);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    margin: EdgeInsets.only(top: 8, right: 5, bottom: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: HexColor(MyColors.orange),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Continue",
                            style: GoogleFonts.nunito(
                                color: HexColor(MyColors.white),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          Image.asset(
                            "assets/images/arrowforward.png",
                            height: 10,
                            fit: BoxFit.fill,
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  showBoardingPointListBottomSheet(
      BusSeatLayoutProvider busSeatLayoutProvider) { showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Select Boarding Point",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: HexColor(MyColors.black)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.close_rounded)),
                      ),
                    ],
                  )),
              Container(
                height: 3,
                margin: EdgeInsets.only(top: 3, bottom: 2),
                color: HexColor(MyColors.primaryColor),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: busSeatLayoutProvider.boardingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () =>
                          continueSeatSelected(index, busSeatLayoutProvider),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: HexColor(MyColors.white),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    size: 15,
                                  ),
                                ),
                                Text(
                                  busSeatLayoutProvider
                                      .boardingList[index].pStname
                                      .toString(),
                                  // busSeatLayoutProvider
                                  //     .boardingList[index].pStname!,
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: HexColor(MyColors.black)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2, bottom: 2),
                            height: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  continueSeatSelected(
      int index, BusSeatLayoutProvider busSeatLayoutProvider) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      busSeatLayoutProvider.bordeingStationId = busSeatLayoutProvider.boardingList[index].pStcode.toString();
      List<PassengerInformationPojo> passengerList = [];
      passengerList.addAll(_busSeatLayoutProvider.passengerList);
      Navigator.pop(context);
      Navigator.pushNamed(context, MyRoutes.fillPassengersDetails, arguments: FillPassengersDetailsArguments(
              busSeatLayoutProvider.dsvcId,
              busSeatLayoutProvider.tripType,
              busSeatLayoutProvider.strpId,
              busSeatLayoutProvider.fromStationId,
              busSeatLayoutProvider.toStationId,
              busSeatLayoutProvider.bordeingStationId,
              passengerList));
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  busSeatTypesSection(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   height: 25,
            //   width: 25,
            //   margin: EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //       color: HexColor(MyColors.grey8),
            //       borderRadius: BorderRadius.all(
            //           Radius.circular(8.0) //
            //       ),
            //       border: Border.all(color: Colors.grey)
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset("assets/images/seatwhitee.png"),
            ),
            Text(
              "Available",
              style: GoogleFonts.nunito(fontSize: 12),
            ),
            // Container(
            //   height: 25,
            //   width: 25,
            //   margin: EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //       color: HexColor(MyColors.grey4),
            //       borderRadius: BorderRadius.all(
            //           Radius.circular(8.0) //
            //       ),
            //       border: Border.all(color: Colors.grey)
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset("assets/images/seatgray.png"),
            ),
            Text(
              "Unavailable",
              style: GoogleFonts.nunito(fontSize: 12),
            ),
            // Container(
            //   height: 25,
            //   width: 25,
            //   margin: EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //       color: HexColor(MyColors.green),
            //       borderRadius: BorderRadius.all(
            //           Radius.circular(8.0) //
            //       ),
            //       border: Border.all(color: Colors.grey)
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset("assets/images/seatbluee.png"),
            ),
            Text(
              "Selected",
              style: GoogleFonts.nunito(fontSize: 12),
            ),
            // Container(
            //   height: 25,
            //   width: 25,
            //   margin: EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //       color: HexColor(MyColors.skyBlue),
            //       borderRadius: BorderRadius.all(
            //           Radius.circular(8.0) //
            //       ),
            //       border: Border.all(color: Colors.grey)
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset("assets/images/seatgreen.png"),
            ),
            Text(
              "Male",
              style: GoogleFonts.nunito(fontSize: 12),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset("assets/images/seatpink.png"),
            ),
            Text(
              "Female",
              style: GoogleFonts.nunito(fontSize: 12),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset("assets/images/seatconductorn.png"),
            ),
            Text(
              "Conductor",
              style: GoogleFonts.nunito(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  bookingProcessLayout() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Seat Selection",
                          style: GoogleFonts.nunito(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                        child: Image.asset(
                      "assets/images/longarrow.png",
                      width: 25,
                      fit: BoxFit.fill,
                    ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  height: 3,
                  color: HexColor(MyColors.primaryColor),
                )
              ],
            ),
          ),
          Expanded(
              child: Center(
                  child: Text(
            "Passengers details",
            style: GoogleFonts.nunito(
                fontSize: 12, color: HexColor(MyColors.grey1)),
          ))),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    child: Image.asset(
                  "assets/images/longarrow.png",
                  width: 25,
                  fit: BoxFit.fill,
                )),
                Expanded(
                  child: Center(
                    child: Text(
                      "Payment",
                      style: GoogleFonts.nunito(
                          fontSize: 12, color: HexColor(MyColors.grey1)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showBusDetailsBottomSheet(BusSeatLayoutProvider busSeatLayoutProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
            color: HexColor(MyColors.white),
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 80,
                    height: 4,
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    color: HexColor(MyColors.white),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("Bus Details",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(AppConstants.SERICE_TYPE_NAME,
                              style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color: HexColor((MyColors.grey1)))),
                        ),
                        busTypeImageSlider(busSeatLayoutProvider),
                        // amenitiesSlider(busSeatLayoutProvider),
                        boardingListLayout(busSeatLayoutProvider)
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  busTypeImageSlider(BusSeatLayoutProvider busSeatLayoutProvider) {
    print(AppConstants.bus_type_url);
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 30, right: 30),
      margin: EdgeInsets.only(left: 15),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width * 0.6,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              AppConstants.bus_type_url,
              fit: BoxFit.fill,
            )),
      ),
    );
  }

  busTypeImagesSliderItems(
      BusSeatLayoutProvider busSeatLayoutProvider, int index) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.6,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            "assets/images/bus1.jpeg",
            fit: BoxFit.fill,
          )),
    );
  }

  amenitiesSlider(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: busSeatLayoutProvider.amenitiesUrlList.length,
        itemBuilder: (BuildContext context, int index) {
          return amenitiesItem(busSeatLayoutProvider.amenitiesUrlList[index], "");
        },
      ),
    );
  }

  amenitiesItem(String imagePath, String imageText) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 15, right: 5),
      child: Column(
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: Image.network(imagePath),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(3.0),
          //   child: Center(
          //       child: Text(
          //     imageText,
          //     style: GoogleFonts.nunito(fontSize: 12),
          //   )),
          // ),
        ],
      ),
    );
  }

  boardingListLayout(BusSeatLayoutProvider busSeatLayoutProvider) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: HexColor(MyColors.homegrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "Boarding Points",
                style: GoogleFonts.nunito(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: busSeatLayoutProvider.boardingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.location_on_rounded,
                              size: 15,
                            ),
                          ),
                          Text(
                            busSeatLayoutProvider.boardingList[index].pStname
                                .toString(),
                            // busSeatLayoutProvider
                            //     .boardingList[index].pStname!,
                            style: GoogleFonts.nunito(
                                fontSize: 14, color: HexColor(MyColors.black)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2, bottom: 2),
                      height: 2,
                    ),
                  ],
                );
              },
            ),
          ],
        ));
  }

  showMaximumSeatSelected(BusSeatLayoutProvider busSeatLayoutProvider) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.only(top: 15),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Max Seats Selected !",
                        style: GoogleFonts.nunito(
                            fontSize: 18, color: HexColor(MyColors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "You can select maximun "+AppConstants.MAX_SEAT_SELECT.toString()+" seats ",
                        style: GoogleFonts.nunito(
                            fontSize: 15, color: HexColor(MyColors.black)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: HexColor(MyColors.orange),
                        ),
                        child: Center(
                            child: Text(
                              "OK",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, color: HexColor(MyColors.white)),
                            )),
                      ),
                    )
                  ],
                )
              ],
            )
        );
      },
    );
  }
}
