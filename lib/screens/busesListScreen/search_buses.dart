import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/search_buses_arguments.dart';
import 'package:utc_flutter_app/arguments/seat_layout_boarding_arguments.dart';
import 'package:utc_flutter_app/response/search_services_response.dart';
import 'package:utc_flutter_app/screens/busesListScreen/search_buses_provider.dart';
import 'package:utc_flutter_app/utils/all_strings_class.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class SearchBuses extends StatefulWidget {
  const SearchBuses({Key? key}) : super(key: key);

  @override
  SearchBusesState createState() => SearchBusesState();
}

class SearchBusesState extends State<SearchBuses> {
  late final List<DateTime>? notSelectedDates;
  late SearchBusProvider _searchBusProvider;
  SearchServicesResponse getsearchBuses = SearchServicesResponse();
  bool isloading = true;
  late String date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isloading = true;
    Future.delayed(Duration.zero, () async {
      _searchBusProvider =
          Provider.of<SearchBusProvider>(context, listen: false);
      final args =
          ModalRoute.of(context)!.settings.arguments as SearchBusesArguments;
      date = args.date;
      //print(args.fromStation+"====>"+args.toStation);
      getSearchBuses(args.fromStation, args.toStation, args.serviceTypeId, args.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SearchBusesArguments;
    date = args.date;
    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Container(),
        body: Consumer<SearchBusProvider>(
          builder: (_, myProvider, __) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  topAppBarSearchBuses(),
                  Container(
                    height: 2,
                    color: HexColor(MyColors.primaryColor),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        busListSection(myProvider),
                        filterButton(myProvider)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget busesListBuilder(SearchBusProvider myProvider) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: myProvider.filterBusServices.length,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        // return busesListLayout(index);
        return busesListNewLayout(index, myProvider);
      },
    );
  }

  Widget buildListViewNoDataWidget() {
    return Consumer<SearchBusProvider>(builder: (_, searchBusProvider, __) {
      return Center(child: Text("No Data Available"));
    });
  }

  void notSelectedDated() {
    for (int i = 15; i == 500; i++) {
      notSelectedDates!.add(DateTime.now().add(Duration(days: 10)));
    }
  }

  void getSearchBuses(String fromservicesName, String toservicesName,
      String serviceTypeId, String date) async {
    getsearchBuses = await _searchBusProvider.getSearchBuses(
        fromservicesName, toservicesName, serviceTypeId, date,context);
    // myProvider.setloading(false);
    getsearchBuses;
    isloading = false;
  }

  Widget searchBusesAppBar() {
    return Container(
      color: HexColor(MyColors.primaryColor),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Container(
            child: InkWell(
              onTap: () => Navigator.of(context).pop(true),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppConstants.SELECTED_SOURCE +
                  " - " +
                  AppConstants.SELECTED_DESTINATION +
                  " (" +
                  AppConstants.JOURNEY_DATE +
                  " )",
              style: GoogleFonts.nunito(
                  fontSize: 16, color: HexColor(MyColors.white)),
            ),
          ))
        ],
      ),
    );
  }

  Widget selectDateLayout() {
    late DateTime dateTimeForCal;
    // DateTime selectedDate = new DateFormat("dd/MM/yyy").parse(date);
    DateTime selectedDate = new DateFormat("dd/MM/yyy").parse(date);
    // String currentDate = DateFormat('dd/MM/yyy').format(DateTime.now());
    // String selectedDate = DateFormat('dd/MM/yyy').format(tempDate);
    // //print(selectedDate);
    // //print(currentDate);
    if (DateTime.now().difference(selectedDate).inDays == 0) {
      //print(DateTime.now().difference(selectedDate).inDays);
      dateTimeForCal = DateTime.now();
    } else {
      dateTimeForCal = DateTime.now();
    }

    return Consumer<SearchBusProvider>(builder: (_, searchBusProvider, __) {
      return Container(
        // color: Colors.white,
        child: DatePicker(
          DateTime.now(),
          width: 50,
          height: 90,
          daysCount: AppConstants.ADVANCE_DAYS_BOOKING + 1,
          deactivatedColor: HexColor(MyColors.orange),
          initialSelectedDate: selectedDate,
          selectionColor: HexColor(MyColors.orange),
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            //print(AppConstants.formatter.format(date));
            AppConstants.JOURNEY_DATE = AppConstants.formatter.format(date);
            searchBusProvider.filterBusServices.clear();
            getSearchBuses(
                AppConstants.SELECTED_SOURCE,
                AppConstants.SELECTED_DESTINATION,
                AppConstants.SERVICE_TYPE_ID,
                AppConstants.formatter.format(date));
          },
        ),
      );
    });
  }

  Widget topAppBarSearchBuses() {
    return Container(
      padding: EdgeInsets.only(top: 45),
      color: HexColor(MyColors.primaryColor),
      child: Column(
        children: [
          searchBusesAppBar(),
          Container(margin: EdgeInsets.only(top: 5), child: selectDateLayout()),
        ],
      ),
    );
  }

  busListSection(SearchBusProvider myProvider) {
    return Stack(
      children: [
        Visibility(
            visible: myProvider.isloading ? false : true,
            child: busesListBuilder(myProvider)),
        Visibility(
            visible: myProvider.isloading,
            child: CommonWidgets.buildCircularProgressIndicatorWidget()),
        Visibility(
            visible: checkData(myProvider),
            child: CommonMethods.noBusFound(context)),
      ],
    );
  }

  checkData(SearchBusProvider myProvider) {
    if (myProvider.isloading && myProvider.filterBusServices.isEmpty) {
      return false;
    } else if (myProvider.isloading == false &&
        myProvider.filterBusServices.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  clickOnViewSeats(int index) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      CommonMethods.showLoadingDialog(context);
      await _searchBusProvider.authenticationMethod();
      await _searchBusProvider.busServiceTypeRequest(getsearchBuses.services![index].srtpid.toString(),context);
      Navigator.pop(context);
      if (_searchBusProvider.busServiceTypeResponse.code == "100") {
        if(!_searchBusProvider.busServiceTypeResponse.serviceTypeMaxSeat!.isEmpty){
          AppConstants.MAX_SEAT_SELECT = _searchBusProvider.busServiceTypeResponse.serviceTypeMaxSeat![0].currentseats!;
          if (_searchBusProvider.authenticationMethodResponse.code == "100") {
            AppConstants.MY_TOKEN = _searchBusProvider.authenticationMethodResponse.result![0].token.toString();
            _searchBusProvider.splitBusAmenities(getsearchBuses.services![index].amenities_url.toString(),);
            AppConstants.SERICE_TYPE_NAME = getsearchBuses.services![index].servicetypename.toString();
            AppConstants.SERICE_NAME = getsearchBuses.services![index].routename.toString();
            AppConstants.JOURNEY_TIME = getsearchBuses.services![index].depttime.toString();
            AppConstants.SERICE_TYPE_ID = getsearchBuses.services![index].srtpid.toString();
            Navigator.pushNamed(context, MyRoutes.busSeatLayout, arguments: SeatLayoutBoardingArguments(
                    getsearchBuses.services![index].dsvcid.toString(),
                    getsearchBuses.services![index].strpid.toString(),
                    getsearchBuses.services![index].tripdirection.toString(),
                    getsearchBuses.services![index].tostonid.toString(),
                    getsearchBuses.services![index].frstonid.toString(),
                    _searchBusProvider.amenitiesUrlList,
                    getsearchBuses.services![index].frstonid.toString()));
          } else {
            CommonMethods.showSnackBar(context, "Something went wrong, Please try again later");
          }
        }else {
          CommonMethods.showSnackBar(context, "Seats are not available ");
        }
        //print(busServiceTypeResponse.serviceTypeMaxSeat![0].currentseats!.toString()+"SEAT_");
      }else {
        CommonMethods.showSnackBar(context, "Something went wrong, please try again ");
      }

    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  openFilterDialogDialog() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.white,
        // Background color
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AllStringsClass.shortAndFilter),
              elevation: 1,
              backgroundColor: HexColor(MyColors.primaryColor),
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: filterBody(),
          );
        });
  }

  openFilterDrawer() {
    return Drawer(
      child: Container(),
    );
  }

  filterBody() {
    return Consumer<SearchBusProvider>(builder: (_, myProvider, __) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          "BUS SERVICE TYPE",
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: busServiceTypeList(myProvider),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "SORT BY",
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            child: Row(
                              children: [
                                Radio(
                                  value: myProvider.cheapestFirstValue,
                                  groupValue: 1,
                                  onChanged: (value) {
                                    //print(value);
                                    myProvider.setValueInRadioButton(value.toString(), "Cheap");
                                    // myProvider.cheapestFirstValue = v;
                                  },
                                ),
                                Text('Cheapest first', style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: HexColor(MyColors.black)),),
                              ],
                            ),
                          ),
                          Container(
                            height: 35,
                            child: Row(
                              children: [
                                Radio(
                                  value: myProvider.earlyDepartureValue,
                                  groupValue: 1,
                                  onChanged: (value) {
                                    //print(value);
                                    myProvider.setValueInRadioButton(
                                        value.toString(), "Early");
                                    // myProvider.cheapestFirstValue = v;
                                  },
                                ),
                                Text('Early departure', style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: HexColor(MyColors.black)),),
                              ],
                            ),
                          ),
                          Container(
                            height: 35,
                            child: Row(
                              children: [
                                Radio(
                                  value: myProvider.lateDepartureValue,
                                  groupValue: 1,
                                  onChanged: (value) {
                                    //print(value);
                                    myProvider.setValueInRadioButton(
                                        value.toString(), "Late");
                                    // myProvider.cheapestFirstValue = v;
                                  },
                                ),
                                Text('Late departure', style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: HexColor(MyColors.black)),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(MyColors.grey1),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          "Filter By (Tap to select filter)",
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          "BUS DEPARTURE TIME FROM SOURCE",
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => myProvider.selectMorningBusDeparture(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/morningsun.png',
                                  height: 30,
                                  width: 35,
                                  color: myProvider.checkColorMorningBusDeparture(),
                                ),
                                Text("06:00 Am -11.59 Am",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider.checkColorMorningBusDeparture()))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                myProvider.selectAfterNoonBusDeparture(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/fullsun.png',
                                  height: 30,
                                  width: 35,
                                  color: myProvider
                                      .checkColorAfterNoonBusDeparture(),
                                ),
                                Text("12:00 Pm -4.59 Pm",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorAfterNoonBusDeparture()))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => myProvider.selectEveningBusDeparture(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/evesun.png',
                                  height: 30,
                                  width: 35,
                                  color: myProvider
                                      .checkColorEveningBusDeparture(),
                                ),
                                Text("5:00 Pm -11.59 Pm",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorEveningBusDeparture()))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => myProvider.selectNightBusDeparture(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/night.png',
                                  height: 30,
                                  width: 30,
                                  color:
                                      myProvider.checkColorNightBusDeparture(),
                                ),
                                Text("12:00 Am -5:59 Am",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorNightBusDeparture()))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 1,
                      color: HexColor(MyColors.grey1),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          "BUS ARRIVAL TIME AT DESTINATION",
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => myProvider.selectMorningBusArrival(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/morningsun.png',
                                  height: 30,
                                  width: 35,
                                  color:
                                      myProvider.checkColorMorningBusArrival(),
                                ),
                                Text("06:00 Am -11.59 Am",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorMorningBusArrival()))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => myProvider.selectAfterNoonBusArrival(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/fullsun.png',
                                  height: 30,
                                  width: 35,
                                  color: myProvider
                                      .checkColorAfterNoonBusArrival(),
                                ),
                                Text("12:00 Pm -4.59 Pm",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorAfterNoonBusArrival()))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, left: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => myProvider.selectEveningBusArrival(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/evesun.png',
                                  height: 30,
                                  width: 35,
                                  color:
                                      myProvider.checkColorEveningBusArrival(),
                                ),
                                Text("5:00 Pm -11.59 Pm",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorEveningBusArrival()))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => myProvider.selectNightBusArrival(),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/night.png',
                                  height: 30,
                                  width: 35,
                                  color: myProvider.checkColorNightBusArrival(),
                                ),
                                Text("12:00 Am -5:59 Am",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: myProvider
                                            .checkColorNightBusArrival()))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          myProvider.clearFilter();
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: HexColor(MyColors.grey1),
                          child: Center(
                            child: Text(
                              "Clear",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: HexColor(MyColors.white)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await myProvider.applyFilter();
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: HexColor(MyColors.primaryColor),
                          child: Center(
                            child: Text(
                              "Apply",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: HexColor(MyColors.white)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  filterButton(SearchBusProvider myProvider) {
    return Visibility(
      visible: checkFilterButtonVisiblity(myProvider),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => openFilterDialogDialog(),
          child: Card(
            elevation: 10,
            color: HexColor(MyColors.green),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
              padding: EdgeInsets.all(8),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/filtericon.png",
                      color: HexColor(MyColors.white),
                    ),
                  ),
                  Text(
                    AllStringsClass.shortFilter,
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: HexColor(MyColors.white),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget busesListNewLayout(int index, SearchBusProvider myProvider) {
    //print(myProvider.filterBusServices[index].showHideItem);

    String serviceCode = myProvider.filterBusServices[index].dsvcid! +
        myProvider.filterBusServices[index].tripdirection! +
        myProvider.filterBusServices[index].strpid.toString()!;

    return Visibility(
        visible: showHideList(index, myProvider),
        child: Card(
          elevation: 2,
          child: Container(
              padding: EdgeInsets.only(left: 5),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      // color: Colors.green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, top: 5),
                                child: Text(
                                  serviceCode +
                                      " " + myProvider.filterBusServices[index].servicetypename!,
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: HexColor(MyColors.primaryColor)),
                                ),
                              )),
                          // Container(
                          //     margin: EdgeInsets.only(top: 3),
                          //     child: Text("A/C sleeper (2+2)",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.black)),)),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 10),
                            child: Text(
                              "Available seats: " +
                                  myProvider.filterBusServices[index]
                                      .seatsforbooking!,
                              style: GoogleFonts.nunito(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      // color: Colors.grey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            myProvider.filterBusServices[index].depttime!,
                            style: GoogleFonts.nunito(
                                fontSize: 18, color: HexColor(MyColors.black)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ],
                              ),
                              Text(
                                "Total " +
                                    myProvider
                                        .filterBusServices[index].totaldistance
                                        .toString() +
                                    " KM",
                                style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: HexColor(MyColors.grey1)),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Text(
                            myProvider.filterBusServices[index].arrtime!,
                            style: GoogleFonts.nunito(
                                fontSize: 18, color: HexColor(MyColors.black)),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => clickOnViewSeats(index),
                      child: Container(
                        width: 100,
                        color: HexColor(MyColors.orange),
                        padding: EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            Text(
                              "₹ " + myProvider.filterBusServices[index].totalfare.toString(),
                              style: GoogleFonts.nunito(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor(MyColors.white)),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              margin: EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                  color: HexColor(MyColors.primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ]),
                              child: Center(
                                child: Text(
                                  "View Seats",
                                  style: GoogleFonts.nunito(
                                      color: HexColor(MyColors.white),
                                      fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  busServiceTypeList(SearchBusProvider myProvider) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: myProvider.newBusTypeModelList.length,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        // return busesListLayout(index);
        return busServiceTypeLayout(index, myProvider);
      },
    );
  }

  busServiceTypeLayout(int index, SearchBusProvider myProvider) {
    return Container(
      child: Row(
        children: [

          Checkbox(
              value: myProvider.setValueInServiveTypeCheckBox(index),
              onChanged: (newValue) {
                myProvider.selectServiceType(index, newValue!);
              }
              ),
          Text(
            myProvider.newBusTypeModelList[index].serviceTypeName!,
            style: GoogleFonts.nunito(
                fontSize: 14,
                color: HexColor(MyColors.black),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  showHideList(int index, SearchBusProvider myProvider) {
    if (myProvider.filterBusServices[index].showHideItem != null &&
        myProvider.filterBusServices[index].showHideItem == true) {
      return true;
    } else {
      return false;
    }
  }

  checkFilterButtonVisiblity(SearchBusProvider myProvider) {
    if (myProvider.isloading || myProvider.filterBusServices.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
