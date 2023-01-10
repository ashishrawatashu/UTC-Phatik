import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/cancel_ticket_deatils_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/screens/cancelTicketsScreen/cancel_tickets_provider.dart';
import 'package:utc_flutter_app/utils/all_strings_class.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CancelTicketsScreen extends StatefulWidget {
  const CancelTicketsScreen({Key? key}) : super(key: key);

  @override
  _CancelTicketsScreenState createState() => _CancelTicketsScreenState();
}

class _CancelTicketsScreenState extends State<CancelTicketsScreen> {
  late CancelTicketsProvider _cancelTicketsProvider;
  bool agree = false;

  @override
  void initState() {
    super.initState();
    _cancelTicketsProvider =
        Provider.of<CancelTicketsProvider>(context, listen: false);

    Future.delayed(Duration.zero, () async {
      final args = ModalRoute.of(context)!.settings.arguments
          as CancelTicketsScreenDetailsArguments;
      _cancelTicketsProvider.setLoading(true);
      _cancelTicketsProvider.ticketNo = args.ticketNo;
      _cancelTicketsProvider.source = args.source;
      _cancelTicketsProvider.destination = args.destination;
      _cancelTicketsProvider.boardingStation = args.boardingStation;
      _cancelTicketsProvider.journeyDate = args.journeyDate;
      _cancelTicketsProvider.serviceTypeName = args.serviceTypeName;
      _cancelTicketsProvider.departureTime = args.departureTime;
      _cancelTicketsProvider.arrivalTime = args.arrivalTime;
      _cancelTicketsProvider.getPassengerConfirmationDetails(
          args.ticketNo, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CancelTicketsProvider>(
        builder: (_, cancelTicketsProvider, __) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    topAppBarSection(),
                    Stack(
                      children: [
                        cancelTicketsProvider.isLoading
                            ? Container(
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                child: CommonWidgets
                                    .buildCircularProgressIndicatorWidget(),
                              )
                            : Column(
                                children: [
                                  // ticketStatus(),
                                  boardingSectioncard(),
                                  // fareSummaryCard()
                                ],
                              )
                      ],
                    ),
                  ],
                ),
              ),
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
                  ),
                  GestureDetector(
                    onTap: () {
                      openTermsAndConditionsDialog();
                    },
                    child: Text(
                      AllStringsClass.cancelationPolicy,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: HexColor(MyColors.primaryColor),
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: cancelTicketsProvider.isSelected
                    ? () async {
                        if (agree) {
                          cancelTicketConfirmationBottomSheetDialog(
                              cancelTicketsProvider);
                          // cancelTicketConfirmationDialog(cancelTicketsProvider);
                        } else {
                          CommonMethods.showSnackBar(
                              context, "Please accept cancellation policy");
                        }
                      }
                    : () {},
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: cancelTicketsProvider.isSelected
                          ? HexColor(MyColors.orange)
                          : HexColor(MyColors.grey1),
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Cancel Ticket",
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.white),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget topAppBarSection() {
    return Consumer<CancelTicketsProvider>(
        builder: (_, cancelTicketsProvider, __) {
      return Container(
        padding: EdgeInsets.only(top: 35, bottom: 10),
        color: HexColor(MyColors.primaryColor),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ticket Details",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        cancelTicketsProvider.isLoading
                            ? " "
                            : cancelTicketsProvider.source +
                                "-" +
                                cancelTicketsProvider.destination,
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.white)),
                      ),
                      Text(
                        cancelTicketsProvider.isLoading
                            ? " "
                            : cancelTicketsProvider.boardingStation,
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
    });
  }

  boardingSectioncard() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boardingSection(),
            greyLine(),
            serviceTypeSection(),
            greyLine(),
            passengerListSection(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                  "Est.Refund is the Estimated refund amount. This may be change, as per cancellation policy at the time cancellation processing of your request.",
              style: GoogleFonts.nunito(fontSize: 12,fontWeight: FontWeight.w600,color: HexColor(MyColors.redColor)),),
            )
          ],
        ),
      ),
    );
  }

  boardingSection() {
    return Consumer<CancelTicketsProvider>(
        builder: (_, cancelTicketsProvider, __) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Boarding Point",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    cancelTicketsProvider.boardingStation,
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Boarding Time",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: HexColor(MyColors.grey1),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "11.00 PM",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  greyLine() {
    return Container(
      color: HexColor(MyColors.lightGrey),
      height: 1,
    );
  }

  serviceTypeSection() {
    return Consumer<CancelTicketsProvider>(
        builder: (_, cancelTicketsProvider, __) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cancelTicketsProvider.serviceTypeName,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              cancelTicketsProvider.source +
                  "-" +
                  cancelTicketsProvider.destination,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: HexColor(MyColors.grey1)),
            ),
          ],
        ),
      );
    });
  }

  passengerListSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 30,),
              Expanded(
                flex: 1,
                child: Text(
                  "Name",
                  style: GoogleFonts.nunito(
                      fontSize: 13,
                      color: HexColor(MyColors.grey1),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Seat No",
                    style: GoogleFonts.nunito(
                        fontSize: 13,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Amount",
                    style: GoogleFonts.nunito(
                        fontSize: 13,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Est.Refund",
                    style: GoogleFonts.nunito(
                        fontSize: 13,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          listOfPassengers()
        ],
      ),
    );
  }

  Widget listOfPassengers() {
    return Consumer<CancelTicketsProvider>(
        builder: (_, CancelTicketsProvider, __) {
      return ListView.builder(
        itemCount: CancelTicketsProvider.ticketDetails.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return passengersListLayout(index);
        },
      );
    });
  }

  passengersListLayout(int index) {
    return Consumer<CancelTicketsProvider>(
        builder: (_, cancelTicketsProvider, __) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              child: Checkbox(
                  value: cancelTicketsProvider.setValueInCheckBox(index),
                  onChanged: (newValue) {
                    cancelTicketsProvider.selectSeat(index, newValue!);
                  }),
            ),
            Expanded(
              flex: 1,
              child: Text(
                cancelTicketsProvider.ticketDetails[index].nameofpasseneger!,
                style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: HexColor(MyColors.black),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                // color: Colors.orange,
                child: Text(
                  cancelTicketsProvider.ticketDetails[index].seatno!.toString(),
                  style: GoogleFonts.nunito(
                      fontSize: 13,
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                cancelTicketsProvider.ticketDetails[index].fare!.toString(),
                style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: HexColor(MyColors.black),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              cancelTicketsProvider.ticketDetails[index].refundAmount!.toString(),
              style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      );
    });
  }

  ticketStatus() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ticket Status :",
            style: GoogleFonts.nunito(
                fontSize: 16,
                color: HexColor(MyColors.black),
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Confirmed",
            style: GoogleFonts.nunito(
                fontSize: 16,
                color: HexColor(MyColors.green),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget greyLineContainer() {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      color: HexColor(MyColors.grey2),
    );
  }

  void cancelTicket(CancelTicketsProvider cancelTicketsProvider) async {
    CommonMethods.showLoadingDialog(context);
    await cancelTicketsProvider.cancelTickets();
    if (cancelTicketsProvider.cancelTicketsResponse.code == "100") {
      showCancellationDialog();
      // CommonMethods.showSnackBar(context, "Ticket cancelled successfully !");
      Navigator.pop(context);
      Navigator.pop(context);
      showCancellationDialog();
    } else if (cancelTicketsProvider.cancelTicketsResponse.code == "999") {
      Navigator.pop(context);
      Navigator.pop(context);
      CommonMethods.showTokenExpireDialog(context);
    } else if (cancelTicketsProvider.cancelTicketsResponse.code == "900") {
      Navigator.pop(context);
      Navigator.pop(context);
      CommonMethods.showErrorDialog(context, "Something went wrong !");
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      CommonMethods.showErrorMoveToDashBaordDialog(
          context, "Something went wrong !");
    }
  }

  showCancellationDialog() {
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
                height: 220,
                // color: HexColor(MyColors.dashBg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          "assets/images/canceltickets.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: Text(
                        "Your cancellation request for seat(s) " +
                            _cancelTicketsProvider.selectedSeats +
                            " is forwarded successfully",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // showRaiseAlarmDialog();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("OK",
                                  style:
                                      GoogleFonts.nunito(color: Colors.white)),
                            ),
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

  void openTermsAndConditionsDialog() {
    showDialog(
        context: context,
        builder: (builder) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Scaffold(
              appBar: AppBar(
                title: Text(AllStringsClass.cancelationPolicy),
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
                  //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: WebView(
                    initialUrl: AppConstants.CANCELLATION_POLICY,
                    javascriptMode: JavascriptMode.unrestricted,
                  )),
            ),
          );
        });
  }

  cancelTicketConfirmationBottomSheetDialog(
      CancelTicketsProvider cancelTicketsProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 5),
                  child: Text(
                    "Confirmation !",
                    style: GoogleFonts.nunito(
                        fontSize: 18, color: HexColor(MyColors.black)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Do you want proceed  for cancellation of seat(s) " +
                        cancelTicketsProvider.selectedSeats,
                    style: GoogleFonts.nunito(
                        fontSize: 15, color: HexColor(MyColors.black)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: HexColor(MyColors.orange)),
                          color: HexColor(MyColors.white),
                        ),
                        child: Center(
                            child: Text(
                          "No",
                          style: GoogleFonts.nunito(
                              fontSize: 15, color: HexColor(MyColors.orange)),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(context);
                        cancelTicket(cancelTicketsProvider);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: HexColor(MyColors.orange),
                        ),
                        child: Center(
                            child: Text(
                          "Yes",
                          style: GoogleFonts.nunito(
                              fontSize: 15, color: HexColor(MyColors.white)),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                )
              ],
            ));
      },
    );
  }

  Future<bool> cancelTicketConfirmationDialog(
      CancelTicketsProvider cancelTicketsProvider) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'Are your sure!',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        content: new Text('Do you want cancel your ticket ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(context),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(context);
              cancelTicket(cancelTicketsProvider);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ));
  }
}
