import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/web_view_paymwnt_screen_arguments.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen.dart';
import 'package:utc_flutter_app/screens/paymentScreen/payment_screen_provider.dart';
import 'package:utc_flutter_app/screens/viewAllOffersScreen/view_all_offers_screen.dart';
import 'package:utc_flutter_app/utils/all_strings_class.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();

}

class _PaymentScreenState extends State<PaymentScreen> {

  late PaymentScreenProvider _paymentScreenProvider;
  bool agree = false;

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
    super.initState();

    _paymentScreenProvider = Provider.of<PaymentScreenProvider>(context, listen: false);
//72F1310103202317
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)!.settings.arguments as PaymentScreenArguments;
      print(args.ticketNumber);
      _paymentScreenProvider.ticketNumber = args.ticketNumber;
      _paymentScreenProvider.getPassengerConfirmationDetails(args.ticketNumber,context);
      _paymentScreenProvider.getWalletDetails(AppConstants.USER_MOBILE_NO);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Consumer<PaymentScreenProvider>(
          builder: (_, paymentScreenProvider, __) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    topAppBarSection(),
                    Expanded(
                        child: Stack(
                          children: [
                            Visibility(
                              visible:  paymentScreenProvider.isLoading?false:true,
                              child: Column(
                                children: [
                                  bookingProcessLayout(),
                                  middleSection(),
                                  bottomSection()
                                ],
                              ),
                            ),
                            Visibility(
                                visible: paymentScreenProvider.isLoading ? true : false,
                                child: CommonWidgets.buildCircularProgressIndicatorWidget())
                          ],
                        )
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget topAppBarSection() {
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
                    child: Icon(Icons.close_rounded, color: Colors.white)),
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

  Widget middleSection() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(5),
          color: HexColor(MyColors.grey9),
          child: Column(
            children: [
              passengersListCard(),
              offerSectionVisibility(),
              fareSummaryCard(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value ?? false;
                      });
                    },
                  ),
                  Text(
                    "I accept ",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: HexColor(MyColors.black)),
                  ),
                  GestureDetector(
                    onTap: () {
                      openTermsAndConditionsDialog();
                    },
                    child: Text(
                      AllStringsClass.termsAndConditions,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: HexColor(MyColors.primaryColor),
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSection() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Container(
        height: Platform.isIOS ? 70 : 60,
        padding: Platform.isIOS
            ? EdgeInsets.only(bottom: 10)
            : EdgeInsets.only(bottom: 0),
        // decoration: BoxDecoration(
        //   color: HexColor(MyColors.white),
        // ),
        child: GestureDetector(
          onTap: () {
            if(agree){
              loadPaymentGateways(paymentScreenProvider);
            }else {
              CommonMethods.showSnackBar(context, "Please accept Terms & Conditions");
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 8, right: 15,left: 15, bottom: 8),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: HexColor(MyColors.orange), borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Proceed to Pay",
                    style: GoogleFonts.nunito(
                        color: HexColor(MyColors.white),
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(width: 20,),
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
        ),
      );
    });
  }

  Widget passengersListCard() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Card(
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Passengers List",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Total Passengers: " +
                    paymentScreenProvider.ticketDeatils.length.toString(),
                style: GoogleFonts.nunito(
                    color: HexColor(MyColors.grey1), fontSize: 16),
              ),
              listOfPassengers()
            ],
          ),
        ),
      );
    });
  }

  Widget offersSectionCard() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Card(
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Offers & Discounts",
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/images/percent.png")),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          _navigateToViewAllOffersScreen(context);
                        },
                        child: Text("Select offers "),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Visibility(
                          visible:
                              paymentScreenProvider.viewOffers ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              _navigateToViewAllOffersScreen(context);
                              // Navigator.pushNamed(
                              //     context, MyRoutes.viewAllOffers);
                            },
                            child: Text(
                              "View Offers",
                              style: GoogleFonts.nunito(
                                  color: HexColor(MyColors.skyBlue),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          )),
                      Visibility(
                          visible:
                              paymentScreenProvider.viewOffers ? false : true,
                          child: GestureDetector(
                            onTap: () => applyCouponCode(),
                            child: Text(
                              "Apply",
                              style: GoogleFonts.nunito(
                                  color: HexColor(MyColors.skyBlue),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ))
                    ],
                  )
                ],
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                margin: EdgeInsets.only(top: 10, bottom: 20),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget applyedOffersSectionCard() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Card(
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Coupons & Discounts",
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/images/percent.png")),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Applied(" + paymentScreenProvider.couponCode + ")",
                        style: GoogleFonts.nunito(
                            fontSize: 18, color: HexColor(MyColors.grey1)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => removeOffer(paymentScreenProvider),
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(Icons.close_rounded)),
                  ),
                ],
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                margin: EdgeInsets.only(top: 10, bottom: 20),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget fareSummaryCard() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Card(
        elevation: 3,
        child: Container(
          // padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
          child: ExpansionTile(
            title: Container(
              height: 50,
              decoration: BoxDecoration(
                  // color: HexColor(MyColors.skyBlue),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total payable amount ",
                    style: GoogleFonts.nunito(
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    "₹ " + paymentScreenProvider.totalAmount.toString(),
                    style: GoogleFonts.nunito(
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    Text(
                      "Fare Summary",
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Base Fare",
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Text(
                          "₹ " +
                              paymentScreenProvider.ticketFare[0].totalfareamt.toString(),
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    greyLineContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Online Reservation",
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Text(
                          "₹ " +
                              paymentScreenProvider.ticketFare[0].busrescharges
                                  .toString(),
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    greyLineContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Tax",
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Text(
                          "₹ " +
                              paymentScreenProvider.ticketFare[0].totaltax
                                  .toString(),
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 50, right: 50),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "SGST",
                    //         style: GoogleFonts.nunito(
                    //             color: HexColor(MyColors.grey1),
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16),
                    //       ),
                    //       Text(
                    //         "₹ " +
                    //             paymentScreenProvider.taxes[0].amount.toString(),
                    //         style: GoogleFonts.nunito(
                    //             color: HexColor(MyColors.grey1),
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 16),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    greyLineContainer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Text(
                          "₹ " + paymentScreenProvider.totalDiscount.toString(),
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.orange),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

    });
  }

  Widget greyLineContainer() {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      color: HexColor(MyColors.grey2),
    );
  }

  Widget listOfPassengers() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return ListView.builder(
        itemCount: paymentScreenProvider.ticketDeatils.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return passengersList(index);
        },
      );
    });
  }

  Widget passengersList(int index) {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Container(
          margin: EdgeInsets.only(top: 3, bottom: 3),
          child: Row(
            children: [
              Text(
                "Seat " +
                    paymentScreenProvider.ticketDeatils[index].seatno
                        .toString() +
                    " : ",
                style: GoogleFonts.nunito(
                    color: HexColor(MyColors.grey1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Text(
                paymentScreenProvider.ticketDeatils[index].passengername
                        .toString() +
                    ", " +
                    paymentScreenProvider.ticketDeatils[index].age.toString() +
                    ", " +
                    paymentScreenProvider.ticketDeatils[index].gender
                        .toString(),
                style: GoogleFonts.nunito(
                    color: HexColor(MyColors.grey1),
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          )
          // ),
          );
    });
  }

  void updateTicketByWallet() async {
    await _paymentScreenProvider.walletTicketConfirm();
    Navigator.pop(context);
    if (_paymentScreenProvider.walletTicketConfirmResponse.code == "100") {
      CommonMethods.dialogDone(context, "Ticket is booked !");
      Navigator.pushNamed(context, MyRoutes.bookingHistoryDetailsScreen,
          arguments: PaymentScreenArguments(
              _paymentScreenProvider.ticketNumber, "Booking"));
    } else {
      CommonMethods.showSnackBar(context, "Please try again !");
    }
  }

  showPaymentDialog(PaymentScreenProvider paymentScreenProvider) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.white,
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              paymentDialogToAppBar(),
              totalAmount(),
              Container(
                color: HexColor(MyColors.grey1),
                height: 1,
              ),
              walletBalance(),
              paymentOptionSection(paymentScreenProvider),
            ],
          ),
        );
      },
    );
  }

  paymentDialogToAppBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 45, bottom: 10),
      color: HexColor(MyColors.primaryColor),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, MyRoutes.homeScreen2,arguments: mapData);
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.leftToRight,
                  //     child: DashboardScreen(),
                  //   ),
                  // );
                },
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 22,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select a payment option",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  totalAmount() {
    return Consumer<PaymentScreenProvider>(
        builder: (_, paymentScreenProvider, __) {
      return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total payable amount ",
              style: GoogleFonts.nunito(
                  fontSize: 18, color: HexColor(MyColors.black)),
            ),
            Text(
              "₹ " +
                  paymentScreenProvider.ticketFare[0].totalfareamt.toString(),
              style: GoogleFonts.nunito(
                  fontSize: 22,
                  color: HexColor(MyColors.orange),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    });
  }

  paymentOptionSection(PaymentScreenProvider paymentScreenProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
          child: Text(
            "Payment Gateway(s)",
            style: GoogleFonts.nunito(
                fontSize: 16, color: HexColor(MyColors.grey6)),
          ),
        ),
        Container(
          color: HexColor(MyColors.grey1),
          height: 1,
        ),
        payByPaymentGateWayListBuilder(paymentScreenProvider),
      ],
    );
  }

  clickOnWallet() async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (await _paymentScreenProvider.checkWalletBalance()) {
        // CommonMethods.showLoadingDialog(context);
        // updateTicketByWallet();
        walletConfirmationDialog();
      } else {
        //print(_paymentScreenProvider.checkWalletBalance());
        CommonMethods.showSnackBar(context, "Please top-up your wallet");
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  clickOnPaymentGateway(int index) {
    Navigator.pushNamed(context, MyRoutes.paymentWebViewScreen,
        arguments: WebViewPaymentScreenArguments(_paymentScreenProvider.ticketNumber,_paymentScreenProvider.paymentGatewaysList[index].gatewayid.toString(), "PaymentScreen",_paymentScreenProvider.paymentGatewaysList[index].gatewayname.toString()));
  }

  applyCouponCode() async {
    CommonMethods.showLoadingDialog(context);
    await _paymentScreenProvider.applyOffer(_paymentScreenProvider.ticketNumber, _paymentScreenProvider.couponId);
    Navigator.pop(context);
    if(_paymentScreenProvider.applyRemoveOfferResponse.code=="100"){
      if (!_paymentScreenProvider.isValidCode) {
        CommonMethods.showSnackBar(context, "Invalid coupon code !");
      } else {
        CommonMethods.dialogDone(context, "Coupon code Applied !");
      }
    }else if(_paymentScreenProvider.applyRemoveOfferResponse.code=="999"){
      CommonMethods.showTokenExpireDialog(context);
    }else if(_paymentScreenProvider.applyRemoveOfferResponse.code=="900"){
      CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
    }else{
      CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
    }
  }

  offerSectionVisibility() {
    return Visibility(
      visible: AppConstants.OFFERS,
      child: Consumer<PaymentScreenProvider>(
          builder: (_, paymentScreenProvider, __) {
        return Stack(
          children: [
            Visibility(
                visible: paymentScreenProvider.isOfferApplied ? false : true,
                child: offersSectionCard()),
            Visibility(
                visible: paymentScreenProvider.isOfferApplied ? true : false,
                child: applyedOffersSectionCard()),
          ],
        );
      }),
    );
  }

  removeOffer(PaymentScreenProvider paymentScreenProvider) async {
    CommonMethods.showLoadingDialog(context);
    await _paymentScreenProvider.removeOffer(paymentScreenProvider.ticketNumber, paymentScreenProvider.couponId);
    Navigator.pop(context);
    if(_paymentScreenProvider.applyRemoveOfferResponse.code=="100"){
      paymentScreenProvider.viewOffers = true;
      CommonMethods.dialogDone(context, "Coupon code removed !");
    }else if(_paymentScreenProvider.applyRemoveOfferResponse.code=="999"){
      CommonMethods.showTokenExpireDialog(context);
    }else if(_paymentScreenProvider.applyRemoveOfferResponse.code=="900"){
      CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
    }else{
      CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
    }

  }

  void _navigateToViewAllOffersScreen(BuildContext context) async {
    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ViewAllOffersScreen()),
    );
    //print(result);
    if (result != null) {
      _paymentScreenProvider.couponId = result.toString();
      applyCouponCode();
    }
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
                              color: HexColor(MyColors.grey1),
                              fontSize: 12),
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
              child: Center(
                  child: Text(
                    "Passengers details",
                    style: GoogleFonts.nunito(
                      color: HexColor(MyColors.grey1),
                        fontSize: 12),
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
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Payment",
                          style: GoogleFonts.nunito(
                              fontSize: 12,fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        height: 3,
                        color: HexColor(MyColors.primaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  walletBalance() {
    return GestureDetector(
      onTap: () => clickOnWallet(),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
            decoration: BoxDecoration(
                // color: HexColor(MyColors.skyBlue),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 45,
                  width: 45,
                  child: Image.asset("assets/images/walletblue.png"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Wallet",
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "My Balance ",
                      style: GoogleFonts.nunito(
                          fontSize: 16, color: HexColor(MyColors.primaryColor)),
                    ),
                    Center(
                        child: Text(
                      "₹ "+_paymentScreenProvider.amountBalance.toString(),
                      style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),
                    ))
                  ],
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      AppConstants.WALLET_BOOKING_DESE,
                      style: GoogleFonts.nunito(fontSize: 12),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: HexColor(MyColors.orange),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Proceed to pay",
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  payByPaymentGateWayPaytm() {}

  loadPaymentGateways(PaymentScreenProvider paymentScreenProvider) async {
    await paymentScreenProvider.getPaymentGateways();
    if(paymentScreenProvider.getPaymentGatewaysResponse.code=="100"){
      showPaymentDialog(paymentScreenProvider);
    }else if(paymentScreenProvider.getPaymentGatewaysResponse.code=="999"){
      CommonMethods.showTokenExpireDialog(context);
    }else if(paymentScreenProvider.getPaymentGatewaysResponse.code=="999"){
      CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
    }else{
      CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
    }
  }

  payByPaymentGateWayListBuilder(PaymentScreenProvider paymentScreenProvider) {
    return ListView.builder(
      // padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _paymentScreenProvider.paymentGatewaysList.length,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return paymentGatewaysListItems(index,paymentScreenProvider);
      },
    );
  }

  paymentGatewaysListItems(int index, PaymentScreenProvider paymentScreenProvider) {
    return GestureDetector(
      onTap: () => clickOnPaymentGateway(index),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            height: 50,
            decoration: BoxDecoration(
                // color: HexColor(MyColors.skyBlue),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 60,
                  width: 60,
                  child: Image.network(AppConstants.PG_IMAGE_URL+paymentScreenProvider.paymentGatewaysList[index].gatewayname.toString()+"_M.png",fit: BoxFit.contain,height: 150,width: MediaQuery.of(context).size.width,),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      _paymentScreenProvider
                          .paymentGatewaysList[index].gatewayname!,
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Text(
                    //   "Success ratio",
                    //   style: GoogleFonts.nunito(
                    //       fontSize: 12, color: HexColor(MyColors.primaryColor)),
                    // ),
                    // Container(
                    //   height: 45,
                    //   width: 45,
                    //   padding: EdgeInsets.all(8),
                    //   child: Stack(
                    //     children: [
                    //       CircularProgressIndicator(
                    //         value: 0.8,
                    //         backgroundColor: HexColor(MyColors.dashBg),
                    //         color: HexColor(MyColors.green),
                    //       ),
                    //       Center(
                    //           child: Text(
                    //         "80%",
                    //         style: GoogleFonts.nunito(
                    //             fontSize: 8, fontWeight: FontWeight.bold),
                    //       ))
                    //     ],
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      _paymentScreenProvider
                          .paymentGatewaysList[index].description!,
                      style: GoogleFonts.nunito(fontSize: 12),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: HexColor(MyColors.orange),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Proceed to pay",
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            color: HexColor(MyColors.grey2),
            height: 1,
          ),
        ],
      ),
    );
  }

  Future<bool> walletConfirmationDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Confirmation !',style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
        content: new Text('Please confirm your payment '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(context),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(context);
              CommonMethods.showLoadingDialog(context);
              updateTicketByWallet();
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ));
  }

  void openTermsAndConditionsDialog() {
    showDialog(
        context: context,
        builder: (builder) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Scaffold(
              appBar: AppBar(
                title: Text(AllStringsClass.termsAndConditionsHeadline),
                backgroundColor: HexColor(MyColors.primaryColor),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: WebView(
                    initialUrl:
                    AppConstants.TERSM_AND_CONDITIONS,
                    javascriptMode: JavascriptMode.unrestricted,
                  )
              ),
            ),
          );
        });
  }

}
