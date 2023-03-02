import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/fill_concession_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/screens/fillconcessionInfoScreen/fill_concession_info_screen_provider.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class FillConcessionScreen extends StatefulWidget {
  const FillConcessionScreen({Key? key}) : super(key: key);

  @override
  State<FillConcessionScreen> createState() => _FillConcessionScreenState();
}

class _FillConcessionScreenState extends State<FillConcessionScreen> {
  late FillConcessionScreenProvider _fillConcessionScreenProvider;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want cancel the booking? '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: DashboardScreen(),
              ),
            ),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  void initState() {
    //print("initSate");
    super.initState();
    _fillConcessionScreenProvider =
        Provider.of<FillConcessionScreenProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      //print("futuree");
      final args = ModalRoute.of(context)!.settings.arguments as FillConcessionScreenArguments;
      _fillConcessionScreenProvider.userEmailId= args.emailId;
      _fillConcessionScreenProvider.depotServiceCode = args.depotServiceCode;
      _fillConcessionScreenProvider.tripType = args.triptype;
      _fillConcessionScreenProvider.tripId = args.tripid;
      _fillConcessionScreenProvider.fromStationId = args.fromStationId;
      _fillConcessionScreenProvider.toStationId = args.toStationId;
      _fillConcessionScreenProvider.bordeingStationId = args.bordeingStationId;
      _fillConcessionScreenProvider.passengerList = args.passengerList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Consumer<FillConcessionScreenProvider>(
        builder: (_, fillConcessionScreenProvider, __) {
          return Scaffold(
              body: Container(width: MediaQuery.of(context).size.width, alignment: Alignment.topLeft, color: HexColor(MyColors.grey2), child: Column(
              children: [
                topAppBarSection(fillConcessionScreenProvider),
                bookingProcessLayout(),
                middleContentSection(fillConcessionScreenProvider),
                bottomSection(fillConcessionScreenProvider)
              ],
            ),
          ));
        },
      ),
    );
  }

  topAppBarSection(FillConcessionScreenProvider fillConcessionScreenProvider) {
    return Container(
      color: HexColor(MyColors.primaryColor),
      padding: EdgeInsets.only(top: 45, bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _onWillPop,
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
                          fontSize: 14, color: HexColor(MyColors.white)),
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
                              fontSize: 12, color: HexColor(MyColors.grey1)),
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
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Passengers details",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700, fontSize: 12),
                )),
                Container(
                  height: 3,
                  color: HexColor(MyColors.primaryColor),
                )
              ],
            ),
          ),
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

  middleContentSection(FillConcessionScreenProvider fillConcessionScreenProvider) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                  "You have selected " +
                      fillConcessionScreenProvider.passengerList.length
                          .toString() +
                      " seats with following details ",
                  style: TextStyle(color: HexColor(MyColors.black))),
              SizedBox(
                height: 5,
              ),
              passengersList(fillConcessionScreenProvider)
            ],
          ),
        ),
      ),
    );
  }

  bottomSection(FillConcessionScreenProvider fillConcessionScreenProvider) {
    String totalSeats = fillConcessionScreenProvider.passengerList.length.toString();

    return Container(
      height: Platform.isIOS ? 70 : 60,
      padding: Platform.isIOS
          ? EdgeInsets.only(bottom: 10)
          : EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: HexColor(MyColors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Passengers: " + totalSeats,
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.grey1), fontSize: 14),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Seats No.s: ",
                              style: GoogleFonts.nunito(
                                  color: HexColor(MyColors.grey1),
                                  fontSize: 14),
                            ),
                            Text(
                              fillConcessionScreenProvider.concatSeatsNumber(),
                              style: GoogleFonts.nunito(
                                  color: HexColor(MyColors.black),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              checkConcessionVaidation(fillConcessionScreenProvider);
            },
            child: Container(
              margin: EdgeInsets.only(top: 8, right: 5, bottom: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: HexColor(MyColors.orange),
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Continue",
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.white), fontSize: 18),
                    ),
                    Image.asset(
                      "assets/images/arrowforward.png",
                      height: 15,
                      fit: BoxFit.fill,
                      width: 15,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  passengersList(FillConcessionScreenProvider fillConcessionScreenProvider) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: fillConcessionScreenProvider.passengerList.length,
      itemBuilder: (BuildContext context, int index) {
        // return passengerInformationListLayout(index,fillPassengersDetailsProvider);
        return passengerListForConcessionItems(
            index, fillConcessionScreenProvider);
      },
    );
  }

  passengerListForConcessionItems(int index, FillConcessionScreenProvider fillConcessionScreenProvider) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: HexColor(MyColors.white),
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      fillConcessionScreenProvider.passengerList[index].name
                          .toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor(MyColors.black)),
                    ),
                    Text(
                      ", ".toString(),
                      style: TextStyle(color: HexColor(MyColors.black)),
                    ),
                    Text(
                      fillConcessionScreenProvider
                          .passengerList[index].genderName
                          .toString(),
                      style: TextStyle(color: HexColor(MyColors.black)),
                    ),
                    Text(
                      ", ".toString(),
                      style: TextStyle(color: HexColor(MyColors.black)),
                    ),
                    Text(
                      fillConcessionScreenProvider.passengerList[index].age
                          .toString(),
                      style: TextStyle(color: HexColor(MyColors.black)),
                    )
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        "Seat No : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor(MyColors.black)),
                      ),
                      Text(
                        fillConcessionScreenProvider.passengerList[index].seatNo.toString(),
                        style: TextStyle(color: HexColor(MyColors.black)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  "Concession : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HexColor(MyColors.black)),
                ),
                Text(
                  fillConcessionScreenProvider
                      .passengerList[index].concessionName
                      .toString(),
                  style: TextStyle(color: HexColor(MyColors.black)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Stack(
              children: [
                Visibility(
                    visible: fillConcessionScreenProvider.checkPassVerificationVisiblility(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter pass number provided by department",
                          style: TextStyle(color: HexColor(MyColors.primaryColor)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 8,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                controller: fillConcessionScreenProvider.passengerList[index].passengerPassNoTextEditingController,
                                autofocus: true,
                                maxLength: 50,
                                cursorColor: HexColor(MyColors.primaryColor),
                                onChanged: (value) {},
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z0-9]')),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Pass number',
                                  counter: SizedBox.shrink(),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(MyColors.primaryColor))),
                                ),
                                validator: (passNo) {
                                  fillConcessionScreenProvider.busPassNovalidation(passNo.toString(),index);
                                  return fillConcessionScreenProvider.busPassNo;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  onTap: (){
                                    checkBusPass(index,fillConcessionScreenProvider);
                                  },
                                  child: Text(
                                    "Verify",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: HexColor(MyColors.primaryColor),fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Visibility(
                    visible: fillConcessionScreenProvider.checkDocumentVerification(index),
                    child: Text(
                      "Keep any one of these documents ready at the time of journey - " + fillConcessionScreenProvider
                          .passengerList[index].spdocumentverification
                              .toString(),
                      style: TextStyle(color: HexColor(MyColors.green)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void checkBusPass(int index, FillConcessionScreenProvider fillConcessionScreenProvider) async {
    if(_fillConcessionScreenProvider.passengerList[index].passengerPassNoTextEditingController.text.isEmpty){
      CommonMethods.showSnackBar(context, "Please enter pass number");
      return;
    }

      CommonMethods.showLoadingDialog(context);
      await fillConcessionScreenProvider.checkConcessionPass(index,fillConcessionScreenProvider.passengerList[index].concessionId.toString(), fillConcessionScreenProvider.passengerList[index].passengerPassNoTextEditingController.text.toString(), AppConstants.JOURNEY_DATE);
      Navigator.pop(context);
      if(fillConcessionScreenProvider.checkConcessionPassResponse.code=="100"){
        if(fillConcessionScreenProvider.passengerList[index].checkBusPassStatus=="Error"){
          CommonMethods.showSnackBar(context, "Invalid pass no !");
        }else {
          CommonMethods.dialogDone(context, "Pass is verified ");
        }
      }else if(fillConcessionScreenProvider.checkConcessionPassResponse.code=="999"){
        CommonMethods.showTokenExpireDialog(context);
      }else {
        CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
      }
  }

  void checkConcessionVaidation(FillConcessionScreenProvider fillConcessionScreenProvider) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      await fillConcessionScreenProvider.validatePassNoAndIdProof();
      if (fillConcessionScreenProvider.passengerForm==true) {
        await fillConcessionScreenProvider.concatSeatsNumber();
        await fillConcessionScreenProvider.concatPassengersListToString();
        await _fillConcessionScreenProvider.savePassengers();
        if(fillConcessionScreenProvider.savePassengersResponse.code=="100"){
          moveToPaymentScreen(context,fillConcessionScreenProvider);
        }else if(fillConcessionScreenProvider.savePassengersResponse.code=="999"){
          CommonMethods.showTokenExpireDialog(context);
        }else{
          CommonMethods.showSnackBar(context, "Something went wrong, please try again later");
        }
        moveToPaymentScreen(context,fillConcessionScreenProvider);
      } else {
        CommonMethods.showSnackBar(context, "Please check and verify the Id/Bus pass");
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  moveToPaymentScreen(BuildContext context, FillConcessionScreenProvider fillConcessionScreenProvider) {
    if (fillConcessionScreenProvider.ticketNumber == "EXCEPTION") {
      CommonMethods.showSnackBar(context, "Something went wrong !");
    } else {
      //print("TICKET-NO===>" + fillConcessionScreenProvider.ticketNumber);
      fillConcessionScreenProvider.passengerList.clear();

      Navigator.pushNamed(context, MyRoutes.paymentScreen, arguments: PaymentScreenArguments(fillConcessionScreenProvider.ticketNumber, "PassengersDetails"));
    }
  }
  
}
