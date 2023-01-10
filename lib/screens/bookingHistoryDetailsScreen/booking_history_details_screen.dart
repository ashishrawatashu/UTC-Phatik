import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/screens/bookingHistoryDetailsScreen/booking_history_detail_screen_provider.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class BookingHistoryDetailsScreen extends StatefulWidget {const BookingHistoryDetailsScreen({Key? key}) : super(key: key);

  @override
  _BookingHistoryDetailsScreenState createState() => _BookingHistoryDetailsScreenState();


}

class _BookingHistoryDetailsScreenState extends State<BookingHistoryDetailsScreen> {
  late BookingHistoryDetailProvider _bookingHistoryDetailProvider;

  @override
  void initState() {
    super.initState();
    _bookingHistoryDetailProvider = Provider.of<BookingHistoryDetailProvider>(context, listen: false);

    Future.delayed(const Duration(milliseconds: 300), () async {
      final args = ModalRoute.of(context)!.settings.arguments as PaymentScreenArguments;
      //print(args.ticketNumber);
      _bookingHistoryDetailProvider.from = args.from;
      _bookingHistoryDetailProvider.setLoading(true);
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        _bookingHistoryDetailProvider.getPassengerConfirmationDetails(args.ticketNumber);
      }
      else {
      CommonMethods.showNoInternetDialog(context);
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailsProvider, __) {
      return WillPopScope(
        onWillPop: () async => bookingDetailsBack(bookingHistoryDetailsProvider),
        child: Scaffold(
          body: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      topAppBarSection(),
                      Stack(
                        children: [
                          bookingHistoryDetailsProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget():
                          Column(
                            children: [
                              ticketStatus(),
                              boardingSectioncard(),
                              fareSummaryCard()
                            ],
                          )
                        ],
                      )
                    ],
                  ),//
                ),
        ),
      );
    });
  }

  Widget topAppBarSection() {
    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailsProvider, __) {
      return Container(
        // height: 220,
        padding: EdgeInsets.only(top: 35, bottom: 10),
        color: HexColor(MyColors.primaryColor),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    bookingDetailsBack(bookingHistoryDetailsProvider);
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(Icons.arrow_back_sharp, color: Colors.white)),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Details",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        bookingHistoryDetailsProvider.isLoading?" ":bookingHistoryDetailsProvider
                            .ticketDeatils[0].source! +
                            "-" +
                            bookingHistoryDetailsProvider
                                .ticketDeatils[0].destination!,
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: HexColor(MyColors.white)),
                      ),
                      Text(
                        bookingHistoryDetailsProvider.isLoading?" ":bookingHistoryDetailsProvider
                            .ticketDeatils[0].journeydate!+" "+ bookingHistoryDetailsProvider
                            .ticketDeatils[0].departuretimea!,
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
            passengerListSection()
          ],
        ),
      ),
    );
  }

  boardingSection() {
    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailsProvider, __) {
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
                    bookingHistoryDetailsProvider.ticketDeatils[0].boarding!,
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
                      fontSize: 14,
                      color: HexColor(MyColors.grey1),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  bookingHistoryDetailsProvider
                      .ticketDeatils[0].departuretimea!,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
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
    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailsProvider, __) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingHistoryDetailsProvider.ticketDeatils[0].servicetypenameen!,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              bookingHistoryDetailsProvider
                  .ticketDeatils[0].source! +
                  "-" +
                  bookingHistoryDetailsProvider
                      .ticketDeatils[0].destination!,
              style: GoogleFonts.nunito(
                  fontSize: 14,
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Passenger",
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: HexColor(MyColors.grey1),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Seat No",
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: HexColor(MyColors.grey1),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          listOfPassengers()
        ],
      ),
    );
  }

  Widget listOfPassengers() {
    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailProvider, __) {
      return ListView.builder(
        itemCount: bookingHistoryDetailProvider.ticketDeatils.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ticketDeatilsLayout(index);
        },
      );
    });
  }

  ticketDeatilsLayout(int index) {
    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailProvider, __) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bookingHistoryDetailProvider.ticketDeatils[index].passengername!,
            style: GoogleFonts.nunito(
                fontSize: 14,
                color: HexColor(MyColors.black),
                fontWeight: FontWeight.w600),
          ),
          Text(
            bookingHistoryDetailProvider.ticketDeatils[index].seatno!
                .toString(),
            style: GoogleFonts.nunito(
                fontSize: 14,
                color: HexColor(MyColors.black),
                fontWeight: FontWeight.w600),
          ),
        ],
      );
    });
  }

  ticketStatus() {

    return Consumer<BookingHistoryDetailProvider>(
        builder: (_, bookingHistoryDetailProvider, __) {
          return Padding(
            padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Booking Status :",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  bookingHistoryDetailProvider.ticketDeatils[0].status.toString(),
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: bookingHistoryDetailProvider.checkTicketStatusColor( bookingHistoryDetailProvider.ticketDeatils[0].status.toString()),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        });
  }

  Widget fareSummaryCard() {
    return Consumer<BookingHistoryDetailProvider>(builder: (_, bookingHistoryDetailsProvider, __){
      return Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fare Summary",
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Base Fare",
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                    Text("₹ "+bookingHistoryDetailsProvider.totalAmount.toString(),
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                  ],
                ),
                greyLineContainer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Online Reservation",
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                    Text("₹ "+bookingHistoryDetailsProvider.ticketFare[0].busrescharges.toString(),
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                  ],
                ),
                greyLineContainer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Tax",
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                    Text("₹ "+bookingHistoryDetailsProvider.taxes[0].amount.toString(),
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 50, right: 50),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(bookingHistoryDetailsProvider.taxes[0].tax.toString(),
                //         style: GoogleFonts.nunito(
                //             color: HexColor(MyColors.grey1),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 14
                //         ),),
                //       Text("₹ "+bookingHistoryDetailsProvider.taxes[0].amount.toString(),
                //         style: GoogleFonts.nunito(
                //             color: HexColor(MyColors.grey1),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 14
                //         ),),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: 50, right: 50),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("SGST",
                //         style: GoogleFonts.nunito(
                //             color: HexColor(MyColors.grey1),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 16
                //         ),),
                //       Text("₹ "+bookingHistoryDetailsProvider.taxes[1].taxamt.toString(),
                //         style: GoogleFonts.nunito(
                //             color: HexColor(MyColors.grey1),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 16
                //         ),),
                //     ],
                //   ),
                // ),
                greyLineContainer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount",
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                    Text("₹ "+bookingHistoryDetailsProvider.ticketFare[0].totconsessionamt.toString(),
                      style: GoogleFonts.nunito(
                          color: HexColor(MyColors.orange),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 50, right: 50),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Coupon(WELCOME100)",
                //         style: GoogleFonts.nunito(
                //             color: HexColor(MyColors.grey1),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 14
                //         ),),
                //       Text("₹ 100.00",
                //         style: GoogleFonts.nunito(
                //             color: HexColor(MyColors.grey1),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 14
                //         ),),
                //     ],
                //   ),
                // ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 15,right: 15),
                  decoration: BoxDecoration(
                      // color: HexColor(MyColors.skyBlue),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bookingHistoryDetailsProvider.checkTicketStatus(bookingHistoryDetailsProvider.ticketDeatils[0].status.toString()),
                        style: GoogleFonts.nunito(
                            color: bookingHistoryDetailsProvider.checkTicketStatusForColor(bookingHistoryDetailsProvider.ticketDeatils[0].status.toString()),
                            fontWeight: FontWeight.w600,
                            fontSize: 22
                        ),),
                      Text("₹ "+bookingHistoryDetailsProvider.ticketFare[0].totalfareamt.toString(),
                        style: GoogleFonts.nunito(
                            color: bookingHistoryDetailsProvider.checkTicketStatusForColor(bookingHistoryDetailsProvider.ticketDeatils[0].status.toString()),
                            fontWeight: FontWeight.w600,
                            fontSize: 22
                        ),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

  }

  Widget greyLineContainer() {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: 5,bottom: 5),
      color: HexColor(MyColors.grey2),
    );

  }

  bookingDetailsBack(BookingHistoryDetailProvider bookingHistoryDetailsProvider) {
    if(bookingHistoryDetailsProvider.from=="Booking"){
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: DashboardScreen(),
        ),
      );
    }else if(bookingHistoryDetailsProvider.from=="BookingTab"){
      Navigator.pop(context);
    }
    return true;
  }

}
