import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/stations_screen_arguments.dart';
import 'package:utc_flutter_app/response/get_stations_response.dart';
import 'package:utc_flutter_app/screens/stationsScreen/station_screen_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({Key? key}) : super(key: key);

  @override
  StationsScreenState createState() => StationsScreenState();
}

class StationsScreenState extends State<StationsScreen> {
  int sizeOfList = 20;
  bool isloading = false;

  late AllStationsProvider _allDestinationProvider;

  GetStationsResponse getAllSatation = GetStationsResponse();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allDestinationProvider = Provider.of<AllStationsProvider>(context, listen: false);
    isloading = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      final args = ModalRoute.of(context)!.settings.arguments as SearchStationArguments;
      _allDestinationProvider.flag_F_T = args.from;
      getdestination();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              children: [
                Container(
              // color: Colors.blueAccent,
              height: 50,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      onChanged: (val) {
                        //print(val);
                        if (val.length == 2) {
                          _allDestinationProvider.searchKeyword = val;
                          getdestination();
                        }
                      },
                    ),
                  ))
                ],
              ),
            ),
            Container(
              height: 2,
              color: HexColor(MyColors.primaryColor),
            ),
            Expanded(
              child: Column(
                children: [
                  Visibility(
                    visible: isloading == false ? true : false,
                    child: isloading == false &&
                            getAllSatation.station != null &&
                            getAllSatation.station!.length > 0
                        ? buildListViewWidget()
                        : CommonWidgets.buildListViewNoDataWidget(),
                  ),
                  Visibility(
                    visible: isloading,
                    child: CommonWidgets.buildCircularProgressIndicatorWidget(),
                  )
                ],
              ),
            ),
          ],
        )));
  }

  Widget buildListViewWidget() {
    return Expanded(
      child: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: getAllSatation.station!.length,
          itemBuilder: (BuildContext context, int index) {
            // var item = placesList[index];
            var _colors = Colors.primaries;
            return allDestinationList(getAllSatation, index);
          },
        ))
      ]),
    );
  }

  Widget allDestinationList(
      GetStationsResponse searchBusesResponse, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (_allDestinationProvider.flag_F_T=="F") {
              AppConstants.SELECTED_SOURCE =
                  searchBusesResponse.station![index].stonname!;
              //print("FROM" + AppConstants.SELECTED_SOURCE + "" + AppConstants.SELECTED_DESTINATION);
            } else {
              AppConstants.SELECTED_DESTINATION = searchBusesResponse.station![index].stonname!;
              //print("To" + AppConstants.SELECTED_SOURCE + "" + AppConstants.SELECTED_DESTINATION);
            }
            Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.homeRoute, (route) => false);
            // SaveSearchBusSP.setSourcePlace(sourcePlace: searchBusesResponse.station![index].);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            color: HexColor(MyColors.white),
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                searchBusesResponse.station![index].stonname!,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.grey,
          height: 1,
        ),
      ],
    );
  }

  void getdestination() async {
    getAllSatation = await _allDestinationProvider.getDestination(context);
    setState(() {
      getAllSatation;
      isloading = false;
    });
  }
}
