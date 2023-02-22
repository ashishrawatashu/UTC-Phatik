import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/fill_concession_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/fill_passengers_details_arguments.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/screens/fillPassengerDeatailsScreen/fill_passengers_details_screen_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class FillPassengersDetailsScreen extends StatefulWidget {
  const FillPassengersDetailsScreen({Key? key}) : super(key: key);

  @override
  _FillPassengersDetailsScreenState createState() => _FillPassengersDetailsScreenState();
}

class _FillPassengersDetailsScreenState
    extends State<FillPassengersDetailsScreen> {
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;
  late Map<String, dynamic> data = Map();
  bool isUserLoggedIn = false;
  late FillPassengersDetailsProvider _fillPassengersDetailsProvider;
  var _formKeyForContactInformationCard = GlobalKey<FormState>();
  var _formKeyForLoginDialog = GlobalKey<FormState>();

  List<String> genderList = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    //print("initSate");
    super.initState();
    _fillPassengersDetailsProvider = Provider.of<FillPassengersDetailsProvider>(context, listen: false);
    getUserData();
    // _fillPassengersDetailsProvider.passengerList.clear();
    // _fillPassengersDetailsProvider.passengerList = AppConstants.passengerList11;
    // //print(_fillPassengersDetailsProvider.passengerList.length.toString()+"SIZE");
    // //print(AppConstants.passengerList11.length.toString()+"SIZE");

    Future.delayed(Duration.zero, () {
      // _fillPassengersDetailsProvider.passengerList.clear();
      final args = ModalRoute.of(context)!.settings.arguments as FillPassengersDetailsArguments;
      _fillPassengersDetailsProvider.passengerList = args.passengerInformationList;
      _fillPassengersDetailsProvider.depotServiceCode = args.depotServiceCode;
      _fillPassengersDetailsProvider.tripType = args.triptype;
      _fillPassengersDetailsProvider.tripId = args.tripid;
      _fillPassengersDetailsProvider.fromStationId = args.fromStationId;
      _fillPassengersDetailsProvider.toStationId = args.toStationId;
      _fillPassengersDetailsProvider.bordeingStationId = args.bordeingStationId;
      setState(() {});
      _fillPassengersDetailsProvider.getConcessionTypes(_fillPassengersDetailsProvider.depotServiceCode, _fillPassengersDetailsProvider.fromStationId , _fillPassengersDetailsProvider.toStationId,context);
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _fillPassengersDetailsProvider.passengerList.clear();


    return Consumer<FillPassengersDetailsProvider>(
      builder: (_, fillPassengersDetailsProvider, __) {
        return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topLeft,
              color: HexColor(MyColors.grey2),
              child: Column(
                children: [
                  topAppBarSection(fillPassengersDetailsProvider),
                  bookingProcessLayout(),
                  middleContentSection(fillPassengersDetailsProvider),
                  bottomSection(fillPassengersDetailsProvider)
            ],
          ),
        ));
      },
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
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
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

  //top app bar section 2
  Widget topAppBarSection(
      FillPassengersDetailsProvider fillPassengersDetailsProvider) {
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

  //middle section
  middleContentSection(
      FillPassengersDetailsProvider fillPassengersDetailsProvider) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              passengerInformationCard(fillPassengersDetailsProvider),
              contactInformationCard(),
            ],
          ),
        ),
      ),
    );
  }

  //bottom section
  Widget bottomSection(
      FillPassengersDetailsProvider fillPassengersDetailsProvider) {
    String totalSeats =
        fillPassengersDetailsProvider.passengerList.length.toString();

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
                              fillPassengersDetailsProvider.concatSeatsNumber(),
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
            onTap: () => checkMobileNumber(fillPassengersDetailsProvider),
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

  Widget contactInformationCard() {
    return Consumer<FillPassengersDetailsProvider>(
      builder: (_, fillPassengerDetailsProvider, __) {
        return Card(
          elevation: 3,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKeyForContactInformationCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your ticket details will be sent to this e-mail id & Mobile number",
                    style: GoogleFonts.nunito(color: Colors.black, fontSize: 14),
                  ),
                  TextFormField(
                    enableInteractiveSelection: false,
                    controller: fillPassengerDetailsProvider.userEmailTextEditingController,
                    cursorColor: HexColor(MyColors.primaryColor),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      // FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")),
                      LengthLimitingTextInputFormatter(50),
                    ],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Id (Optional)',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(MyColors.primaryColor))),
                    ),
                    validator: (value) {
                      fillPassengerDetailsProvider.userEmailValidation(value);
                      return fillPassengerDetailsProvider.userEmail;
                    },
                  ),
                  TextFormField(
                    enableInteractiveSelection: false,
                    controller: fillPassengerDetailsProvider
                        .userPhoneTextEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    cursorColor: HexColor(MyColors.primaryColor),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Mobile number',
                      prefixText: "+91 - ",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: HexColor(MyColors.primaryColor))),
                    ),
                    validator: (value) {
                      fillPassengerDetailsProvider.userPhoneValidation(value);
                      return fillPassengerDetailsProvider.userPhone;
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget passengerInformationCard(
      FillPassengersDetailsProvider fillPassengersDetailsProvider) {
    // //print('GENDER'+_fillPassengersDetailsProvider.passengerList[0].name.toString());
    return Card(
        elevation: 3,
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Passenger Details",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              passengerInformationList(fillPassengersDetailsProvider)
            ],
          ),
        ));
  }

  Widget passengerInformationList(
      FillPassengersDetailsProvider fillPassengersDetailsProvider) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: fillPassengersDetailsProvider.passengerList.length,
      itemBuilder: (BuildContext context, int index) {
        // return passengerInformationListLayout(index,fillPassengersDetailsProvider);
        return passengerInformationListLayout(
            index, fillPassengersDetailsProvider);
      },
    );
  }

  showLoginBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (BuildContext context) {
        return Consumer<FillPassengersDetailsProvider>(
          builder: (_, fillPassengerDetailsProvider, __) {
            return Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: EdgeInsets.only(top: 20, bottom: 30, left: 30, right: 30),
              child: Form(
                key: _formKeyForLoginDialog,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Enter the 6 Digit OTP recieved on your",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.grey6)),
                      ),
                      Text(
                        "Mobile Number - " +
                            fillPassengerDetailsProvider
                                .userPhoneTextEditingController.text
                                .substring(0, 5) +
                            "XXXXX",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.grey6)),
                      ),
                      Visibility(
                        visible: fillPassengerDetailsProvider.already_yn == "Y"
                            ? false
                            : true,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            enableInteractiveSelection: false,
                            controller: fillPassengerDetailsProvider
                                .userFullNameTextEditingController,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Image.asset(
                                      "assets/images/usernameicon.png",
                                      height: 10,
                                      width: 10,
                                    )),
                                hintText: "Full Name",
                                hintStyle: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor(MyColors.grey4)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            HexColor(MyColors.primaryColor)))),
                            validator: (value) {
                              fillPassengerDetailsProvider
                                  .userNameValidation(value);
                              return fillPassengerDetailsProvider.userName;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          controller: fillPassengerDetailsProvider
                              .userOtpTextEditingController,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Image.asset(
                                    "assets/images/lockicon.png",
                                    height: 10,
                                    width: 10,
                                  )),
                              hintText: "OTP",
                              hintStyle: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor(MyColors.grey4)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor(MyColors.primaryColor)))),
                          validator: (value) {
                            fillPassengerDetailsProvider
                                .userOtpValidation(value);
                            return fillPassengerDetailsProvider.otpLength;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => userLoginWithOtp(),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: HexColor(MyColors.orange),
                              // boxShadow: [
                              //   BoxShadow(
                              //     // color: Colors.grey,
                              //     offset: Offset(0.0, 1.0), //(x,y)
                              //     blurRadius: 0.1,
                              //   ),
                              // ],
                              borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "SUBMIT",
                                  style: GoogleFonts.roboto(
                                      color: HexColor(MyColors.white),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didnt get the OTP? ",
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: HexColor(MyColors.grey6)),
                            ),
                            GestureDetector(
                              onTap: () {
                                checkMobileNumber(
                                    _fillPassengersDetailsProvider);
                              },
                              child: Text(
                                "Resend",
                                style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor(MyColors.primaryColor)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  checkMobileNumber(FillPassengersDetailsProvider fillPassengersDetailsProvider) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (_formKeyForContactInformationCard.currentState!.validate()) {
        await fillPassengersDetailsProvider.validatePassengerList();
        if (fillPassengersDetailsProvider.passengerForm) {
          await fillPassengersDetailsProvider.checkMobileNumber(fillPassengersDetailsProvider.userPhoneTextEditingController.text);
          if (fillPassengersDetailsProvider.isUserLoggedIn == "false" || fillPassengersDetailsProvider.isUserSkipped == "true") {
            showLoginBottomSheet();
          } else {
            //print("IS CONTAIN ANY CONCESSION  "+fillPassengersDetailsProvider.isContainAnyConcession.toString());
            if(fillPassengersDetailsProvider.isContainAnyConcession==true){
              Navigator.pushNamed(context, MyRoutes.fillConcessionScreen,arguments: FillConcessionScreenArguments(
                  fillPassengersDetailsProvider.userEmailTextEditingController.text.toString(),
                  fillPassengersDetailsProvider.depotServiceCode,
                  fillPassengersDetailsProvider.tripType,
                  fillPassengersDetailsProvider.tripId,
                  fillPassengersDetailsProvider.fromStationId,
                  fillPassengersDetailsProvider.toStationId,
                  fillPassengersDetailsProvider.bordeingStationId,
                  fillPassengersDetailsProvider.passengerList));
            }else {
              fillPassengersDetailsProvider.concatPassengersListToString();
              await fillPassengersDetailsProvider.savePassengers();
              if(fillPassengersDetailsProvider.savePassengersResponse.code=="100"){
                moveToPaymentScreen(context);
              }else if(fillPassengersDetailsProvider.savePassengersResponse.code=="999"){
                CommonMethods.showTokenExpireDialog(context);
              }else if(fillPassengersDetailsProvider.savePassengersResponse.code=="900"){
                CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
              }else if(fillPassengersDetailsProvider.savePassengersResponse.code=="200"){
                CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
              }else{
                CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
              }

            }
            //print(fillPassengersDetailsProvider.passengerList.toList());
          }
        } else {
          CommonMethods.showSnackBar(context, "Please fill all passenger information !");
        }
      } else {
        //print("false");
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  userLoginWithOtp() async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (_formKeyForLoginDialog.currentState!.validate()) {
        var bytes = utf8.encode(_fillPassengersDetailsProvider
            .userOtpTextEditingController.text
            .toString());
        var digest = sha512.convert(bytes);
        _fillPassengersDetailsProvider.MyEncryptOTP =
            digest.toString().toUpperCase();
        CommonMethods.showLoadingDialog(context);
        if (await _fillPassengersDetailsProvider.matchOtp() == true) {
          await MemoryManagement.setIsLoggedIn(isLoggedIn: "true");
          await MemoryManagement.setIsSkipped(isSkipped: "false");
          _fillPassengersDetailsProvider.concatPassengersListToString();
          await _fillPassengersDetailsProvider.savePassengers();
          //print(_fillPassengersDetailsProvider.passengers);
          moveToPaymentScreen(context);
          await _fillPassengersDetailsProvider.getPhoneNumber();
          CommonMethods.dialogDone(context, "Login successfully");
        } else {
          Navigator.pop(context);
          CommonMethods.showSnackBar(context, "Invalid OTP !");
        }
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  moveToPaymentScreen(BuildContext context) {
    if (_fillPassengersDetailsProvider.ticketNumber == "EXCEPTION") {
      CommonMethods.showSnackBar(context, "Something went wrong !");
    } else {
      //print("TICKET-NO===>" + _fillPassengersDetailsProvider.ticketNumber);
      _fillPassengersDetailsProvider.passengerList.clear();

      Navigator.pushNamed(context, MyRoutes.paymentScreen,
          arguments: PaymentScreenArguments(
              _fillPassengersDetailsProvider.ticketNumber,
              "PassengersDetails"));
    }
  }

  getUserData() async {
    await _fillPassengersDetailsProvider.getIsLoggedIn();
    await _fillPassengersDetailsProvider.getIsSkipped();
    //print("getuserdata");
  }


  Widget passengerInformationListLayout(int index, FillPassengersDetailsProvider fillPassengersDetailsProvider) {
    //print(fillPassengersDetailsProvider.passengerList[index].genderName.toString() +"GENDERRRRR");
  // fillPassengersDetailsProvider.selectConsessionFromDropDown(fillPassengersDetailsProvider.concessionList[0].categoryname.toString(), index);
  return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    enableInteractiveSelection: false,
                    autofocus: true,
                    maxLength: 50,
                    controller: fillPassengersDetailsProvider.passengerList[index].passengerNameTextEditingController,
                    cursorColor: HexColor(MyColors.primaryColor),
                    onChanged: (value) {
                      fillPassengersDetailsProvider.setPassengerName(index, value.toString());
                      fillPassengersDetailsProvider.selectConsessionFromDropDown(fillPassengersDetailsProvider.concessionList[0].categoryname.toString(), index);
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Name',
                      counter: SizedBox.shrink(),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14,fontWeight: FontWeight.bold,),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor(MyColors.primaryColor))),
                    ),
                    validator: (passengerName) {
                      fillPassengersDetailsProvider.uservalidation(
                           passengerName.toString(),index);
                      return fillPassengersDetailsProvider.passengerName1;
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    enableInteractiveSelection: false,
                    maxLength: 2,
                    controller: fillPassengersDetailsProvider
                        .passengerList[index].passengerAgeTextEditingController,
                    cursorColor: HexColor(MyColors.primaryColor),
                    onTap: () {
                      //print(fillPassengersDetailsProvider.passengerList[index].passengerAgeTextEditingController.text);
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],

                    decoration: InputDecoration(
                      counter: SizedBox.shrink(),
                      hintText: 'Age',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor(MyColors.primaryColor))),
                    ),
                    onChanged: (value){
                      fillPassengersDetailsProvider.selectConsessionFromDropDown(fillPassengersDetailsProvider.concessionList[0].categoryname.toString(), index);
                    },
                    validator: (passengerAge) {
                      fillPassengersDetailsProvider.agevalidation(passengerAge.toString(),index);
                      return fillPassengersDetailsProvider.age1;
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Visibility(
                      visible: fillPassengersDetailsProvider
                          .passengerList[index].onlyMale=="N"?true:false,
                      child: DropdownButtonHideUnderline(child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Container(
                                  child: Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        items: genderList.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ))
                            .toList(),
                        value: fillPassengersDetailsProvider
                            .passengerList[index].genderName,
                        onChanged: (value) {
                          // fillPassengersDetailsProvider.checkPostionValidation(index);
                          fillPassengersDetailsProvider.selectGenderFromDropDown(value.toString(), index);
                          fillPassengersDetailsProvider.selectConsessionFromDropDown(fillPassengersDetailsProvider.concessionList[0].categoryname.toString(), index);
                        },
                        iconSize: 25,
                        iconEnabledColor: Colors.grey,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 40,
                        buttonWidth: 160,
                        // buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 150,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),),
                    Visibility(
                      visible: fillPassengersDetailsProvider
                          .passengerList[index].onlyMale=="N"?false:true,
                      child:Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                            fillPassengersDetailsProvider
                                .passengerList[index].genderName.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              child: Text(
                                'Consession',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    items: fillPassengersDetailsProvider.concessionList
                        .map((item) => DropdownMenuItem<String>(value: item.categoryname.toString(),
                      child: Text(
                        item.categoryname.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: fillPassengersDetailsProvider.passengerList[index].concessionName,
                    onChanged: (value) async {
                      await fillPassengersDetailsProvider.checkPassengerValidation(value.toString(),fillPassengersDetailsProvider.passengerList[index].age!,fillPassengersDetailsProvider.passengerList[index].gender!,index,context);
                      if(fillPassengersDetailsProvider.validation==true){
                        fillPassengersDetailsProvider.selectConsessionFromDropDown(value.toString(), index);
                      }else {
                        //print("BBBBBBB");
                      }



                      // setState(() {
                      //   // fillPassengersDetailsProvider.selectedGenderValue = value as String;
                      // });
                    },
                    iconSize: 25,
                    iconEnabledColor: Colors.grey,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 40,
                    buttonWidth: 160,
                    // buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: MediaQuery.of(context).size.width,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
