import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utc_flutter_app/arguments/cancel_ticket_deatils_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/web_page_url_arguments.dart';
import 'package:utc_flutter_app/screens/bottomTabsScreens/myBookingTab/my_tickets_provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/download_save_pdf.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../../arguments/payment_screen_arguments.dart';
import '../../../utils/common_widigits.dart';
import '../../../utils/my_routes.dart';
import 'package:http/http.dart' as http;
class MyHistoryTab extends StatefulWidget {
  const MyHistoryTab({Key? key}) : super(key: key);

  @override
  MyHistoryTabState createState() => MyHistoryTabState();
}

class MyHistoryTabState extends State<MyHistoryTab> {
  late MyTicketsProvider _myTicketsProvider;

  String from = "";
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _myTicketsProvider = Provider.of<MyTicketsProvider>(context, listen: false);
    _myTicketsProvider.ticketDetails.clear();
    Future.delayed(Duration.zero, () async {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        await _myTicketsProvider.authenticationMethod();
        _myTicketsProvider.getTickets();
      } else {
        CommonMethods.showNoInternetDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _key,
          endDrawerEnableOpenDragGesture: true,
          endDrawer: NavigationDrawer(),
          appBar: AppBar(
            backgroundColor: HexColor(MyColors.primaryColor),
            automaticallyImplyLeading: false,
            title: Text("My History"),
          ),
          body: bookingHistoryListBuilder(),
        ));
  }

  bookingHistoryListBuilder() {
    return Consumer<MyTicketsProvider>(builder: (_, myTicketsProvider, __) {
      return Container(
        color: HexColor(MyColors.white),
        child: Stack(
          children: [
            Visibility(
                visible: myTicketsProvider.isLoading ? true : false, child: CommonWidgets.buildCircularProgressIndicatorWidget()),
            Visibility(
                visible: myTicketsProvider.isLoading ? false : true,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 50,
                      child: Row(
                        children: [
                          Text("Sort by: ",style: GoogleFonts.nunito(
                            fontSize: 14
                          ),),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      myTicketsProvider.allIsActive();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: myTicketsProvider.setAllBgColor(),
                                          border: Border.all(color: myTicketsProvider.setAllColor()),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            color: myTicketsProvider.setAllColor(),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      myTicketsProvider.confirmedActive();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: myTicketsProvider.setConfirmedBgColor(),
                                          border: Border.all(color: myTicketsProvider.setConfirmedColor()),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          'Confirmed',
                                          style: TextStyle(
                                            color: myTicketsProvider.setConfirmedColor(),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      myTicketsProvider.cancelledActive();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: myTicketsProvider.setCancelledBgColor(),
                                          border: Border.all(color: myTicketsProvider.setCancelledColor()),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          'Cancelled',
                                          style: TextStyle(
                                            color: myTicketsProvider.setCancelledColor(),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      myTicketsProvider.failedActive();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: myTicketsProvider.setFailedBgColor(),
                                          border: Border.all(color: myTicketsProvider.setFailedColor()),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          'Failed',
                                          style: TextStyle(
                                            color: myTicketsProvider.setFailedColor(),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: myTicketsProvider.ticketDetails.length,
                        // itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          // return bookingListItems(index);
                          return bookingNewListItems(index,myTicketsProvider);
                        },
                      ),
                    )
                  ],
                )),
            Visibility(
                visible: checkData(myTicketsProvider),
                child: CommonMethods.noDataFound(context)
            ),
          ],
        ),
      );
    });
  }


  bookingNewListItems(int index, MyTicketsProvider myTicketsProvider) {
    return Visibility(
      visible: myTicketsProvider.filterTicket(index),
      child: Card(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("PNR: "+myTicketsProvider.ticketDetails[index].ticketno!,style: GoogleFonts.nunito(fontSize: 15),),
                          Row(
                            children: [
                              Container(
                                margin : EdgeInsets.only(left: 8),
                                padding : EdgeInsets.only(right: 8),
                                child: Image.asset(
                                  'assets/images/cal.png',
                                  height: 18,
                                  color: HexColor(MyColors.orange),
                                  width: 18,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(myTicketsProvider.ticketDetails[index].journeydate!, style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: HexColor(MyColors.black),),),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 8,right: 12,left: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: HexColor(MyColors.orange))
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  width: 1,
                                  height: 2,
                                  color: HexColor(MyColors.orange),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  width: 1,
                                  height: 2,
                                  color: HexColor(MyColors.orange),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  width: 1,
                                  height: 2,
                                  color: HexColor(MyColors.orange),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  width: 1,
                                  height: 2,
                                  color: HexColor(MyColors.orange),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  width: 1,
                                  height: 2,
                                  color: HexColor(MyColors.orange),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2,bottom: 2),
                                  width: 1,
                                  height: 2,
                                  color: HexColor(MyColors.orange),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: HexColor(MyColors.orange))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            padding: EdgeInsets.only(top: 10,bottom: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(myTicketsProvider.ticketDetails[index].source!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 14,fontWeight: FontWeight.w600),),
                                Text(myTicketsProvider.ticketDetails[index].destination!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 14,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          )
                        ],
                      ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Container(
                               margin : EdgeInsets.only(left: 8,right: 8,top: 8),
                               child: Image.asset("assets/images/orangebus.png",height: 18,width: 18,color: HexColor(MyColors.orange),),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 8.0),
                               child: Text(myTicketsProvider.ticketDetails[index].busservicetypename!,style: GoogleFonts.nunito(fontSize: 14),),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Container(
                               margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                               child: Image.asset(
                                   myTicketsProvider.setIconOnStatus(index),
                                   height: 18,
                                   width: 18),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 8.0),
                               child: Text(
                                 myTicketsProvider.checkStatus(index),
                                 style: GoogleFonts.nunito(
                                     fontSize: 16,
                                     color: myTicketsProvider.checkStatusColor(index),
                                     fontWeight: FontWeight.bold),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: _myTicketsProvider.checkActiveTicket(index),
                            child: InkWell(
                              onTap: () {
                                _myTicketsProvider.resentTicket(myTicketsProvider.ticketDetails[index].ticketno.toString(),context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5,top: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor(MyColors.green),
                                ),
                                height: 35,
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Center(
                                    child: Text("Resend Ticket",
                                      style: GoogleFonts.nunito(
                                          color: HexColor((MyColors.white))),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if(myTicketsProvider.ticketDetails[index].ticketbookingstatus=="CONFIRMED"&&myTicketsProvider.ticketDetails[index].tripstatus=="A"){
                                showQrCodeDilaog(myTicketsProvider, index);
                              }else {
                                Navigator.pushNamed(
                                    context, MyRoutes.bookingHistoryDetailsScreen,
                                    arguments: PaymentScreenArguments(
                                        _myTicketsProvider
                                            .ticketDetails[index].ticketno!,
                                        "BookingTab"));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5,top: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor(MyColors.orange),
                              ),
                              height: 35,
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Center(
                                  child: Text("View Details",
                                    style: GoogleFonts.nunito(
                                        color: HexColor((MyColors.white))),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  )
              ),
            ),
          ],
        ),

      ),
    );
  }


  bookingListItems(int index) {
    return Consumer<MyTicketsProvider>(builder: (_, myTicketsProvider, __) {
      return Visibility(
        visible: myTicketsProvider.filterTicket(index),
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 3),
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PNR: " + myTicketsProvider.ticketDetails[index].ticketno!,
                          style: GoogleFonts.nunito(fontSize: 15),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              margin:
                                  EdgeInsets.only(top: 8, right: 12, left: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(
                                            color: HexColor(MyColors.orange))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    width: 1,
                                    height: 2,
                                    color: HexColor(MyColors.orange),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    width: 1,
                                    height: 2,
                                    color: HexColor(MyColors.orange),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    width: 1,
                                    height: 2,
                                    color: HexColor(MyColors.orange),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    width: 1,
                                    height: 2,
                                    color: HexColor(MyColors.orange),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    width: 1,
                                    height: 2,
                                    color: HexColor(MyColors.orange),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2, bottom: 2),
                                    width: 1,
                                    height: 2,
                                    color: HexColor(MyColors.orange),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: HexColor(MyColors.orange))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              padding: EdgeInsets.only(top: 10, bottom: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    myTicketsProvider.ticketDetails[index].source!,
                                    style: GoogleFonts.nunito(
                                        color: HexColor(MyColors.black),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    myTicketsProvider.ticketDetails[index].destination!,
                                    style: GoogleFonts.nunito(
                                        color: HexColor(MyColors.black),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                              child: Image.asset(
                                "assets/images/orangebus.png",
                                height: 18,
                                width: 18,
                                color: HexColor(MyColors.orange),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                myTicketsProvider.ticketDetails[index].busservicetypename!,
                                style: GoogleFonts.nunito(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 10),
                              padding: EdgeInsets.only(right: 8),
                              child: Image.asset(
                                'assets/images/cal.png',
                                height: 18,
                                color: HexColor(MyColors.orange),
                                width: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                myTicketsProvider
                                    .ticketDetails[index].journeydate!,
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: HexColor(MyColors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                              child: Image.asset(
                                  myTicketsProvider.setIconOnStatus(index),
                                  height: 18,
                                  width: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                myTicketsProvider.checkStatus(index),
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color:
                                        myTicketsProvider.checkStatusColor(index),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Visibility(
                          visible: false,
                          child: GestureDetector(
                            onTap: () {
                              //print("CHECK CANCEL");
                              moveToCancelTicketDetailsScreen(myTicketsProvider, index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: HexColor(MyColors.grey1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/notconfirm_status.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Visibility(
                          visible: myTicketsProvider.ticketsResponse.ticket![index].tripstatus == "A" && myTicketsProvider.ticketsResponse.ticket![index].ticketbookingstatus == "CONFIRMED"
                              ? true
                              : false,
                          child: GestureDetector(
                            onTap: () =>
                                {
                                  showQrCodeDilaog(myTicketsProvider, index)},
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: HexColor(MyColors.green),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/downloadicon.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.bookingHistoryDetailsScreen,
                                arguments: PaymentScreenArguments(
                                    _myTicketsProvider
                                        .ticketDetails[index].ticketno!,
                                    "BookingTab"));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                // color: HexColor(MyColors.orange),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/viewdeatils.png",
                                    height: 30,
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  showTicketDiloag(MyTicketsProvider myTicketsProvider, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              child: Column(
                children: [
                  TicketWidget(
                    width: MediaQuery.of(context).size.width,
                    height: 550,
                    isCornerRounded: true,
                    child: Container(
                      child: ticketData(myTicketsProvider, index),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ticketData(MyTicketsProvider myTicketsProvider, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                                myTicketsProvider
                                    .passengerConfirmDetailsResponse
                                    .ticketDeatil![0]
                                    .source
                                    .toString(),
                                style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: HexColor(MyColors.black),
                                    fontWeight: FontWeight.bold)))),
                    Image.asset("assets/images/ticketorange.png"),
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                                myTicketsProvider
                                    .passengerConfirmDetailsResponse
                                    .ticketDeatil![0]
                                    .destination
                                    .toString(),
                                style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: HexColor(MyColors.black),
                                    fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Booking Date/Time ",
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: HexColor(MyColors.black))),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          myTicketsProvider.passengerConfirmDetailsResponse
                              .ticketDeatil![0].bookingdatetime
                              .toString(),
                          style: GoogleFonts.nunito(
                              fontSize: 13,
                              color: HexColor(MyColors.black),
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Boarding Point",
                    style: GoogleFonts.nunito(
                        fontSize: 15,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    myTicketsProvider.passengerConfirmDetailsResponse
                        .ticketDeatil![0].boarding
                        .toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Journey Date ",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    myTicketsProvider.passengerConfirmDetailsResponse
                        .ticketDeatil![0].journeydate
                        .toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seat No",
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: HexColor(MyColors.grey1),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                myTicketsProvider.concatSeatsNumber(),
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: HexColor(MyColors.black),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        // passengerListSection(),
        ticketCenterLine(),
        fareSummary(myTicketsProvider, index),
        Center(
          child: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              final bytes = utf8.encode(myTicketsProvider.passengerConfirmDetailsResponse.ticketDeatil![0].ticketno.toString());
              final base64TicketNumber = base64.encode(bytes);
              //print(base64TicketNumber);
              String downloadTicketUri = AppConstants.DOWNLOAD_TICKET_URL+"?tn="+base64TicketNumber;
              // String downloadTicketUri = "http://www.africau.edu/images/default/sample.pdf";
              //print(downloadTicketUri);
              // final file = await loadPdfFromNetwork(downloadTicketUri);

              print(downloadTicketUri);
              final Uri _url = Uri.parse(downloadTicketUri);
              _launchInBrowser(_url);

              // CommonMethods.showLoadingDialog(context);
              // await saveFile(downloadTicketUri, myTicketsProvider.passengerConfirmDetailsResponse.ticketDeatil![0].ticketno.toString()+".pdf",context);
              // Navigator.pop(context);
              // CommonMethods.doneState(context, 'Successfully saved to internal storage "UTC Ticket" folder');
            },
            child: Text("Download e-ticket", style: TextStyle(
              color: HexColor(MyColors.primaryColor),
              decoration: TextDecoration.underline,
            ),),
          ),
        ),
      ],
    );
  }

  Future<File> loadPdfFromNetwork(String url) async {
    CommonMethods.showLoadingDialog(context);
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    Navigator.pop(context);
    return _myTicketsProvider.storeFile(url, bytes);
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  ticketMiddleLine() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        color: HexColor(MyColors.dashBg),
        height: 2,
        width: 30,
      ),
    );
  }




  fareSummary(MyTicketsProvider myTicketsProvider, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Base Fare",
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(
                  "₹ " +
                      myTicketsProvider.passengerConfirmDetailsResponse
                          .ticketFare![0].totalfareamt
                          .toString(),
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),
            // greyLineContainer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Online Reservation",
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(
                  "₹ " +
                      myTicketsProvider.passengerConfirmDetailsResponse
                          .ticketFare![0].busrescharges
                          .toString(),
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),
            // greyLineContainer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Tax",
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(
                  "₹ " +
                      myTicketsProvider.passengerConfirmDetailsResponse
                          .ticketFare![0].totaltax
                          .toString(),
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(
                  "₹ " +
                      myTicketsProvider.passengerConfirmDetailsResponse
                          .ticketFare![0].totconsessionamt
                          .toString(),
                  style: GoogleFonts.nunito(
                      color: HexColor(MyColors.orange),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 15, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount Paid",
                    style: GoogleFonts.nunito(
                        color: HexColor(MyColors.green),
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                  Text(
                    "₹ " +
                        myTicketsProvider.passengerConfirmDetailsResponse
                            .ticketFare![0].netfare
                            .toString(),
                    style: GoogleFonts.nunito(
                        color: HexColor(MyColors.green),
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  ticketCenterLine() {
    return Container(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 15),
        height: 150,
        child: QrImage(
          data: _myTicketsProvider.qrTextEncrypt,
          version: QrVersions.auto,
          size: 150.0,
        ),
        // child: Image.network("data:image/jpg;base64,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9Db0BqY02jCl0UZTabRhSqONptJow5RGG5dLow3TOHtBiX6UpjTauFwabZjGoTc1taObm0qjjabSaMOURhumNNowpdGG6W3oDUxptGFKo42m0mjDlEYbTaXRhimNNi6XRhumcfaCEv0oTWm0cbk02jCNQ29qakc3N5VGG02l0YYpjTZMabRhSqMN09vQG5jSaMOURhtNpdGGKY02mkqjDVMabVwujTZM4+wFJfpRmtJo43JptGEah97U1I5ubiqNNppKow1TGm2Y0mjDlEYbprehNzCl0YYpjTaaSqMNUxptNJVGG6Y02rhcGm2YxtkLSvSjNKXRxuXSaMM0Dr2pqR3d3FQabTSVRhumNNowpdGGKY02TG9Db2BKow1TGm00lUYbpjTaaCqNNkxptHG5NNowjbMXlOhHaUqjjcul0YZpHHpTUzu6uak02mgqjTZMabRhSqMNUxptmN6G3sCURhumNNpoKo02TGm00VQabZjSaONyabRhGmcvKNGP0pRGG5dLow3TOPSmpnZ0c1NptNFUGm2Y0mjDlEYbpjTaML0NvYEpjTZMabTRVBptmNJoo6k02jCl0cbl0mjDNM5eUKIfpSmNNi6XRhumcehNTe3o5qbSaKOpNNowpdGGKY02TGm0YXobegNTGm2Y0mijqTTaMKXRRlNptGFKo43LpdGGaZy9oEQ/SlMabVwujTZM49CbmtrRzU2l0UZTabRhSqMNUxptmNJow/Q29AamNNowpdFGU2m0YUqjjabSaMOURhuXS6MN0zh7QYl+lKY02rhcGm2YxqE3NbWjm5tKo42m0mjDlEYbpjTaMKXRhult6A1MabRhSqONptJow5RGG02l0YYpjTYul0YbpnH2ghL9KE1ptHG5NNowjUNvampHNzeVRhtNpdGGKY02TGm0YUqjDdPb0BuY0mjDlEYbTaXRhimNNppKow1TGm1cLo02TOPsBSX6UZrSaONyabRhGofe1NSObm4qjTaaSqMNUxptmNJow5RGG6a3oTcwpdGGKY02mkqjDVMabTSVRhumNNq4XBptmMbZC0r0ozSl0cbl0mjDNA69qakd3dxUGm00lUYbpjTaMKXRhimNNkxvQ29gSqMNUxptNJVGG6Y02mgqjTZMabRxuTTaMI2zF5ToR2lKo43LpdGGaRx6U1M7urmpNNpoKo02TGm0YUqjDVMabZje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pdHGWp8aZy94HP3RmNJow5RGG021o5vX896G3mA9L4021vqrpdHGWp9Kow1TGm2s9alx9oLH0R+NKY02TGm00VQ7unk9723oDdbz0mhjrb9aGm2s9ak02jCl0cZanxpnLyjRj9KURhtNpdGGqR3dvJ43t9E3byqNNi7Xjm42pdGGKY02TGm0YWpHNzeVRhumdnSzKY02TGm0YWpHN5vG2QtK9KM0pdFGU2m0YWpHN6/nzW30zZtKo43LtaObTWm0YUqjDVMabZja0c1NpdGGqR3dbEqjDVMabZja0c2mcfaCEv0oTWm00VQabZja0c3reXMbffOm0mjjcu3oZlMabZjSaMOURhumdnRzU2m0YWpHN5vSaMOURhumdnSzaZy9oEQ/SlMabTSVRhumdnTzet7cRt+8qTTauFw7utmURhumNNowpdGGqR3d3FQabZja0c2mNNowpdGGqR3dbBpnLyjRj9KURhtNpdGGqR3dvJ43t9E3byqNNi7Xjm42pdGGKY02TGm0YWpHNzeVRhumdnSzKY02TGm0YWpHN5vG2QtK9KM0pdFGU2m0YWpHN6/nzW30zZtKo43LtaObTWm0YUqjDVMabZja0c1NpdGGqR3dbEqjDVMabZja0c2mcfaCEv0oTWm00VQabZja0c3reXMbffOm0mjjcu3oZlMabZjSaMOURhumdnRzU2m0YWpHN5vSaMOURhumdnSzaZy9oEQ/SlMabTSVRhumdnTzet7cRt+8qTTauFw7utmURhumNNowpdGGqR3d3FQabZja0c2mNNowpdGGqR3dbBpnLyjRj9KURhtNpdGGqR3dvJ43t9E3byqNNi7Xjm42pdGGKY02TGm0YWpHNzeVRhumdnSzKY02TGm0YWpHN5vG2QtK9KM0pdFGU2m0YWpHN6/nzW30zZtKo43LtaObTWm0YUqjDVMabZja0c1NpdGGqR3dbEqjDVMabZja0c2mcfaCEv0oTWm00VQabZja0c3reXMbffOm0mjjcu3oZlMabZjSaMOURhumdnRzU2m0YWpHN5vSaMOURhumdnSzaZy9oEQ/SlMabTSVRhumdnTzet7cRt+8qTTauFw7utmURhumNNowpdGGqR3d3FQabZja0c2mNNowpdGGqR3dbBpnLyjRj9KURhtNpdGGqR3dvJ43t9E3byqNNi7Xjm42pdGGKY02TGm0YWpHNzeVRhumdnSzKY02TGm0YWpHN5vG2QtK9KM0pdFGU2m0YWpHN6/nzW30zZtKo43LtaObTWm0YUqjDVMabZja0c1NpdGGqR3dbEqjDVMabZja0c2mcfaCEv0oTWm00VQabZja0c3reXMbffOm0mjjcu3oZlMabZjSaMOURhumdnRzU2m0YWpHN5vSaMOURhumdnSzaZy9oEQ/SlMabTSVRhumdnTzet7cRt+8qTTauFw7utmURhumNNowpdGGqR3d3FQabZja0c2mNNowpdGGqR3dbBpnLyjRj9KURhtNpdGGqR3dvJ43t9E3byqNNi7Xjm42pdGGKY02TGm0YWpHNzeVRhumdnSzKY02TGm0YWpHN5vG2QtK9KM0pdFGU2m0YWpHN6/nzW30zZtKo43LtaObTWm0YUqjDVMabZja0c1NpdGGqR3dbEqjDVMabZja0c2mcfaCEv0oTWm00VQabZja0c3reXMbffOm0mjjcu3oZlMabZjSaMOURhumdnRzU2m0YWpHN5vSaMOURhumdnSzaZy9oEQ/SlMabTSVRhumdnTzet7cRt+8qTTauFw7utmURhumNNowpdGGqR3d3FQabZja0c2mNNowpdGGqR3dbBpnL1iGfuSmNNpYz0ujjaba0c1NtaObm0qjDdM49KamNNowzW30zdf6VBptXC6NNppKow3TOHvBMvQjN6XRxnpeGm001Y5ubqod3dxUGm2YxqE3NaXRhmluo2++1qfSaONyabTRVBptmMbZC5ahH7kpjTbW89Joo6l2dHNT7ejmptJowzQOvakpjTZMcxt987U+lUYbl0ujjabSaMM0zl6wDP3ITWm0sZ6XRhtNtaObm2pHNzeVRhumcehNTWm0YZrb6Juv9ak02rhcGm00lUYbpnH2gmXoR25Ko431vDTaaKod3dxUO7q5qTTaMI1Db2pKow3T3EbffK1PpdHG5dJoo6k02jCNsxcsQz9yUxptrOel0UZT7ejmptrRzU2l0YZpHHpTUxptmOY2+uZrfSqNNi6XRhtNpdGGaZy9YBn6kZvSaGM9L402mmpHNzfVjm5uKo02TOPQm5rSaMM0t9E3X+tTabRxuTTaaCqNNkzj7AXL0I/clEYb63lptNFUO7q5qXZ0c1NptGEah97UlEYbprmNvvlan0qjjcul0UZTabRhGmcvWIZ+5KY02ljPS6ONptrRzU21o5ubSqMN0zj0pqY02jDNbfTN1/pUGm1cLo02mkqjDdM4e8Ey9CM3pdHGel4abTTVjm5uqh3d3FQabZjGoTc1pdGGaW6jb77Wp9Jo43JptNFUGm2YxtkLlqEfuSmNNtbz0mijqXZ0c1Pt6Oam0mjDNA69qSmNNkxzG33ztT6VRhuXS6ONptJowzTOXrAM/chNabSxnpdGG021o5ubakc3N5VGG6Zx6E1NabRhmtvom6/1qTTauFwabTSVRhumcfaCZehHbkqjjfW8NNpoqh3d3FQ7urmpNNowjUNvakqjDdPcRt98rU+l0cbl0mijqTTaMI2zFyxDP3JTGm2s56XRRlPt6Oam2tHNTaXRhmkcelNTGm2Y5jb65mt9Ko02LpdGG02l0YZpnL1gGfqRm9JoYz0vjTaaakc3N9WObm4qjTZM49CbmtJowzS30Tdf61NptHG5NNpoKo02TOPsBcvQj9yURhvreWm00VQ7urmpdnRzU2m0YRqH3tSURhumuY2++VqfSqONy6XRRlNptGEaZy9Yhn7kpjTaWM9Lo42m2tHNTbWjm5tKow3TOPSmpjTaMM1t9M3X+lQabVwujTaaSqMN0zh7wTL0Izel0cZ6XhptNNWObm6qHd3cVBptmMahNzWl0YZpbqNvvtan0mjjcmm00VQabZjG2QuWoR+5KY021vPSaKOpdnRzU+3o5qbSaMM0Dr2pKY02THMbffO1PpVGG5dLo42m0mjDNM5esAz9yE1ptLGel0YbTbWjm5tqRzc3lUYbpnHoTU1ptGGa2+ibr/WpNNq4XBptNJVGG6Zx9oJl6EfeVBptmNrRzaY02rhcO7rZ1I5uvlwabZja0c3re6XRxuXSaMP0NvQGl0ujDdPb0Btcbpy9YBn6kTeVRhumdnSzKY02LteObja1o5svl0YbpnZ08/peabRxuTTaML0NvcHl0mjD9Db0BpcbZy9Yhn7kTaXRhqkd3WxKo43LtaObTe3o5sul0YapHd28vlcabVwujTZMb0NvcLk02jC9Db3B5cbZC5ahH3lTabRhakc3m9Jo43Lt6GZTO7r5cmm0YWpHN6/vlUYbl0ujDdPb0BtcLo02TG9Db3C5cfaCZehH3lQabZja0c2mNNq4XDu62dSObr5cGm2Y2tHN63ul0cbl0mjD9Db0BpdLow3T29AbXG6cvWAZ+pE3lUYbpnZ0symNNi7Xjm42taObL5dGG6Z2dPP6Xmm0cbk02jC9Db3B5dJow/Q29AaXG2cvWIZ+5E2l0YapHd1sSqONy7Wjm03t6ObLpdGGqR3dvL5XGm1cLo02TG9Db3C5NNowvQ29weXG2QuWoR95U2m0YWpHN5vSaONy7ehmUzu6+XJptGFqRzev75VGG5dLow3T29AbXC6NNkxvQ29wuXH2gmXoR95UGm2Y2tHNpjTauFw7utnUjm6+XBptmNrRzet7pdHG5dJow/Q29AaXS6MN09vQG1xunL1gGfqRN5VGG6Z2dLMpjTYu145uNrWjmy+XRhumdnTz+l5ptHG5NNowvQ29weXSaMP0NvQGlxtnL1iGfuRNpdGGqR3dbEqjjcu1o5tN7ejmy6XRhqkd3by+VxptXC6NNkxvQ29wuTTaML0NvcHlxtkLlqEfeVNptGFqRzeb0mjjcu3oZlM7uvlyabRhakc3r++VRhuXS6MN09vQG1wujTZMb0NvcLlx9oJl6EfeVBptmNrRzaY02rhcO7rZ1I5uvlwabZja0c3re6XRxuXSaMP0NvQGl0ujDdPb0Btcbpy9YBn6kTeVRhumdnSzKY02LteObja1o5svl0YbpnZ08/peabRxuTTaML0NvcHl0mjD9Db0BpcbZy9Yhn7kTaXRhqkd3WxKo43LtaObTe3o5sul0YapHd28vlcabVwujTZMb0NvcLk02jC9Db3B5cbZC5ahH3lTabRhakc3m9Jo43Lt6GZTO7r5cmm0YWpHN6/vlUYbl0ujDdPb0BtcLo02TG9Db3C5cfaCZehH3lQabZja0c2mNNq4XDu62dSObr5cGm2Y2tHN63ul0cbl0mjD9Db0BpdLow3T29AbXG6cvWAZ+pE3lUYbpnZ0symNNi7Xjm42taObL5dGG6Z2dPP6Xmm0cbk02jC9Db3B5dJow/Q29AaXG2cvWIZ+5E2l0YapHd1sSqONy7Wjm03t6ObLpdGGqR3dvL5XGm1cLo02TG9Db3C5NNowvQ29weXG2QuWoR95U2m0YWpHN5vSaONy7ehmUzu6+XJptGFqRzev75VGG5dLow3T29AbXC6NNkxvQ29wuXH2ghL9KJtKo411pzTaMKXRhult6A2aakc3r/WpmZ+g39B6XhptrPWpdnSzaZy9oEQ/yqbSaGPdKY02TGm0YXobeoOm2tHNa31q5ifoN7Sel0Yba32qHd1sGmcvKNGPsqk02lh3SqMNUxptmN6G3qCpdnTzWp+a+Qn6Da3npdHGWp9qRzebxtkLSvSjbCqNNtad0mjDlEYbprehN2iqHd281qdmfoJ+Q+t5abSx1qfa0c2mcfaCEv0om0qjjXWnNNowpdGG6W3oDZpqRzev9amZn6Df0HpeGm2s9al2dLNpnL2gRD/KptJoY90pjTZMabRheht6g6ba0c1rfWrmJ+g3tJ6XRhtrfaod3WwaZy8o0Y+yqTTaWHdKow1TGm2Y3obeoKl2dPNan5r5CfoNreel0cZan2pHN5vG2QtK9KNsKo021p3SaMOURhumt6E3aKod3bzWp2Z+gn5D63lptLHWp9rRzaZx9oIS/SibSqONdac02jCl0YbpbegNmmpHN6/1qZmfoN/Qel4abaz1qXZ0s2mcvaBEP8qm0mhj3SmNNkxptGF6G3qDptrRzWt9auYn6De0npdGG2t9qh3dbBpnLyjRj7KpNNpYd0qjDVMabZjeht6gqXZ081qfmvkJ+g2t56XRxlqfakc3m8bZC0r0o2wqjTbWndJow5RGG6a3oTdoqh3dvNanZn6CfkPreWm0sdan2tHNpnH2ghL9KJtKo411pzTaMKXRhult6A2aakc3r/WpmZ+g39B6XhptrPWpdnSzaZy9oEQ/yqbSaGPdKY02TGm0YXobeoOm2tHNa31q5ifoN7Sel0Yba32qHd1sGmcvKNGPsqk02lh3SqMNUxptmN6G3qCpdnTzWp+a+Qn6Da3npdHGWp9qRzebxtkLSvSjbCqNNtad0mjDlEYbprehN2iqHd281qdmfoJ+Q+t5abSx1qfa0c2mcfaCEv0om0qjjXWnNNowpdGG6W3oDZpqRzev9amZn6Df0HpeGm2s9al2dLNpnL2gRD/KptJoY90pjTZMabRheht6g6ba0c1rfWrmJ+g3tJ6XRhtrfaod3WwaZy8o0Y+yqTTaWHdKow1TGm2Y3obeoKl2dPNan5r5CfoNreel0cZan2pHN5vG2QtK9KNsKo021p3SaMOURhumt6E3aKod3bzWp2Z+gn5D63lptLHWp9rRzaZx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLzI/RH2NTb0Bs01Y5ubiqNNi7Xjm42pdGG6W3oDdb3SqONptJow5RGG6Z2dLPpbegNTGm0cblx9oLH0R/N5dJow5RGG02l0YYpjTZMabTRVBptNJVGG02l0YYpjTbW+tTb0Bus75VGG6Y02jC1o5tN02Vf5Dj6I7xcGm2Y0mijqTTaMKXRhimNNppKo42m0mijqTTaMKXRxlqfeht6g/W90mjDlEYbpnZ0s2m67IscR3+El0ujDVMabTSVRhumNNowpdFGU2m00VQabTSVRhumNNpY61NvQ2+wvlcabZjSaMPUjm42TZd9kePoj/ByabRhSqONptJow5RGG6Y02mgqjTaaSqONptJow5RGG2t96m3oDdb3SqMNUxptmNrRzabpsi9yHP0RXi6NNkxptNFUGm2Y0mjDlEYbTaXRRlNptNFUGm2Y0mhjrU+9Db3B+l5ptGFKow1TO7rZNF32RY6jP8LLpdGGKY02mkqjDVMabZjSaKOpNNpoKo02mkqjDVMabaz1qbehN1jfK402TGm0YWpHN5umy77IcfRHeLk02jCl0UZTabRhSqMNUxptNJVGG02l0UZTabRhSqONtT71NvQG63ul0YYpjTZM7ehm03TZFzmO/ggvl0YbpjTaaCqNNkxptGFKo42m0mijqTTaaCqNNkxptLHWp96G3mB9rzTaMKXRhqkd3WyaLvsix9Ef4eXSaMOURhtNpdGGKY02TGm00VQabTSVRhtNpdGGKY021vrU29AbrO+VRhumNNowtaObTdNlX+Q4+iO8XBptmNJoo6k02jCl0YYpjTaaSqONptJoo6k02jCl0cZan3obeoP1vdJow5RGG6Z2dLNpuuyLHEd/hJdLow1TGm00lUYbpjTaMKXRRlNptNFUGm00lUYbpjTaWOtTb0NvsL5XGm2Y0mjD1I5uNk2XfZHj6I/wcmm0YUqjjabSaMOURhumNNpoKo02mkqjjabSaMOURhtrfept6A3W90qjDVMabZja0c2m6bIvchz9EV4ujTZMabTRVBptmNJow5RGG02l0UZTabTRVBptmNJoY61PvQ29wfpeabRhSqMNUzu62TRd9kWOoz/Cy6XRhimNNppKow1TGm2Y0mijqTTaaCqNNppKow1TGm2s9am3oTdY3yuNNkxptGFqRzebpsu+yHH0R3i5NNowpdFGU2m0YUqjDVMabTSVRhtNpdFGU2m0YUqjjbU+9Tb0But7pdGGKY02TO3oZtN02Rc5jv4IL5dGG6Y02mgqjTZMabRhSqONptJoo6k02mgqjTZMabSx1qfeht5gfa802jCl0YapHd1smi77IsfRH+Hl0mjDlEYbTaXRhimNNkxptNFUGm00lUYbTaXRhimNNtb61NvQG6zvlUYbpjTaMLWjm03TZV/kOPojvFwabZjSaKOpNNowpdGGKY02mkqjjabSaKOpNNowpdHGWp96G3qD9b3SaMOURhumdnSzabrsixxHf4SXS6MNUxptNJVGG6Y02jCl0UZTabTRVBptNJVGG6Y02ljrU29Db7C+VxptmNJow9SObjZNl32R4+iP8HJptGFKo42m0mjDlEYbpjTaaCqNNppKo42m0mjDlEYba33qbegN1vdKow1TGm2Y2tHNpumyLzI/Qn/UTb0NvYEpjTZM49CbNvU29AamNNowvQ29QVNptNFUO7rZ1I5uNqXRhimNNkxvQ29gakc3NzXOXnB+hP4Im3obegNTGm2YxqE3bept6A1MabRheht6g6bSaKOpdnSzqR3dbEqjDVMabZjeht7A1I5ubmqcveD8CP0RNvU29AamNNowjUNv2tTb0BuY0mjD9Db0Bk2l0UZT7ehmUzu62ZRGG6Y02jC9Db2BqR3d3NQ4e8H5EfojbOpt6A1MabRhGofetKm3oTcwpdGG6W3oDZpKo42m2tHNpnZ0symNNkxptGF6G3oDUzu6ualx9oLzI/RH2NTb0BuY0mjDNA69aVNvQ29gSqMN09vQGzSVRhtNtaObTe3oZlMabZjSaMP0NvQGpnZ0c1Pj7AXnR+iPsKm3oTcwpdGGaRx606beht7AlEYbprehN2gqjTaaakc3m9rRzaY02jCl0YbpbegNTO3o5qbG2QvOj9AfYVNvQ29gSqMN0zj0pk29Db2BKY02TG9Db9BUGm001Y5uNrWjm01ptGFKow3T29AbmNrRzU2NsxecH6E/wqbeht7AlEYbpnHoTZt6G3oDUxptmN6G3qCpNNpoqh3dbGpHN5vSaMOURhumt6E3MLWjm5saZy84P0J/hE29Db2BKY02TOPQmzb1NvQGpjTaML0NvUFTabTRVDu62dSObjal0YYpjTZMb0NvYGpHNzc1zl5wfoT+CJt6G3oDUxptmMahN23qbegNTGm0YXobeoOm0mijqXZ0s6kd3WxKow1TGm2Y3obewNSObm5qnL3g/Aj9ETb1NvQGpjTaMI1Db9rU29AbmNJow/Q29AZNpdFGU+3oZlM7utmURhumNNowvQ29gakd3dzUOHvB+RH6I2zqbegNTGm0YRqH3rSpt6E3MKXRhult6A2aSqONptrRzaZ2dLMpjTZMabRheht6A1M7urmpcfaC8yP0R9jU29AbmNJowzQOvWlTb0NvYEqjDdPb0Bs0lUYbTbWjm03t6GZTGm2Y0mjD9Db0BqZ2dHNT4+wF50foj7Cpt6E3MKXRhmkcetOm3obewJRGG6a3oTdoKo02mmpHN5va0c2mNNowpdGG6W3oDUzt6OamxtkLzo/QH2FTb0NvYEqjDdM49KZNvQ29gSmNNkxvQ2/QVBptNNWObja1o5tNabRhSqMN09vQG5ja0c1NjbMXnB+hP8Km3obewJRGG6Zx6E2beht6A1MabZjeht6gqTTaaKod3WxqRzeb0mjDlEYbprehNzC1o5ubGmcvOD9Cf4RNvQ29gSmNNkzj0Js29Tb0BqY02jC9Db1BU2m00VQ7utnUjm42pdGGKY02TG9Db2BqRzc3Nc5ecH6E/gibeht6A1MabZjGoTdt6m3oDUxptGF6G3qDptJoo6l2dLOpHd1sSqMNUxptmN6G3sDUjm5uapy94PwI/RE29Tb0BqY02jCNQ2/a1NvQG5jSaMP0NvQGTaXRRlPt6GZTO7rZlEYbpjTaML0NvYGpHd3c1Dh7wfkR+iNs6m3oDUxptGEah960qbehNzCl0YbpbegNmkqjjaba0c2mdnSzKY02TGm0YXobegNTO7q5qXH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2ghL9KE3t6OZ1pzTaMKXRhimNNkzt6Oam3obeYK1PpdFGU2m0YUqjjbXWv6kd3WwaZy8o0Y/S1I5uXndKow1TGm2Y0mjD1I5ubupt6A3W+lQabTSVRhumNNpYa/2b2tHNpnH2gjO/iP4jZnobegNTO7p5PW+60DcypdFGU2m0YWpHN5vSaMOURhumt6E3MI1Db7q+1zh7wZlfRP8RM70NvYGpHd28njdd6BuZ0mijqTTaMLWjm01ptGFKow3T29AbmMahN13fa5y94Mwvov+Imd6G3sDUjm5ez5su9I1MabTRVBptmNrRzaY02jCl0YbpbegNTOPQm67vNc5ecOYX0X/ETG9Db2BqRzev500X+kamNNpoKo02TO3oZlMabZjSaMP0NvQGpnHoTdf3GmcvOPOL6D9iprehNzC1o5vX86YLfSNTGm00lUYbpnZ0symNNkxptGF6G3oD0zj0put7jbMXnPlF9B8x09vQG5ja0c3redOFvpEpjTaaSqMNUzu62ZRGG6Y02jC9Db2BaRx60/W9xtkLzvwi+o+Y6W3oDUzt6Ob1vOlC38iURhtNpdGGqR3dbEqjDVMabZjeht7ANA696fpe4+wFZ34R/UfM9Db0BqZ2dPN63nShb2RKo42m0mjD1I5uNqXRhimNNkxvQ29gGofedH2vcfaCM7+I/iNmeht6A1M7unk9b7rQNzKl0UZTabRhakc3m9Jow5RGG6a3oTcwjUNvur7XOHvBmV9E/xEzvQ29gakd3byeN13oG5nSaKOpNNowtaObTWm0YUqjDdPb0BuYxqE3Xd9rnL3gzC+i/4iZ3obewNSObl7Pmy70jUxptNFUGm2Y2tHNpjTaMKXRhult6A1M49Cbru81zl5w5hfRf8RMb0NvYGpHN6/nTRf6RqY02mgqjTZM7ehmUxptmNJow/Q29AamcehN1/caZy8484voP2Kmt6E3MLWjm9fzpgt9I1MabTSVRhumdnSzKY02TGm0YXobegPTOPSm63uNsxec+UX0HzHT29AbmNrRzet504W+kSmNNppKow1TO7rZlEYbpjTaML0NvYFpHHrT9b3G2QvO/CL6j5jpbegNTO3o5vW86ULfyJRGG02l0YapHd1sSqMNUxptmN6G3sA0Dr3p+l7j7AVnfhH9R8z0NvQGpnZ083redKFvZEqjjabSaMPUjm42pdGGKY02TG9Db2Aah950fa9x9oIzv4j+I2Z6G3oDUzu6eT1vutA3MqXRRlNptGFqRzeb0mjDlEYbprehNzCNQ2+6vtc4e8GZX0T/ETO9Db2BqR3dvJ43XegbmdJoo6k02jC1o5tNabRhSqMN09vQG5jGoTdd32ucveDML6L/iJneht7A1I5uXs+bLvSNTGm00VQabZja0c2mNNowpdGG6W3oDUzj0Juu7zXOXnDmF9F/xExvQ29gakc3r+dNF/pGpjTaaCqNNkzt6GZTGm2Y0mjD9Db0BqZx6E3X9xpnL3gc/dFcLo02LpdGG5dLow1TGm1cLo021vd6G3qDy6XRhqkd3bzu9Db0Bk2l0UZT4+wFj6M/msul0cbl0mjjcmm0YUqjjcul0cb6Xm9Db3C5NNowtaOb153eht6gqTTaaGqcveBx9EdzuTTauFwabVwujTZMabRxuTTaWN/rbegNLpdGG6Z2dPO609vQGzSVRhtNjbMXPI7+aC6XRhuXS6ONy6XRhimNNi6XRhvre70NvcHl0mjD1I5uXnd6G3qDptJoo6lx9oLH0R/N5dJo43JptHG5NNowpdHG5dJoY32vt6E3uFwabZja0c3rTm9Db9BUGm00Nc5e8Dj6o7lcGm1cLo02LpdGG6Y02rhcGm2s7/U29AaXS6MNUzu6ed3pbegNmkqjjabG2QseR380l0ujjcul0cbl0mjDlEYbl0ujjfW93obe4HJptGFqRzevO70NvUFTabTR1Dh7wePoj+ZyabRxuTTauFwabZjSaONyabSxvtfb0BtcLo02TO3o5nWnt6E3aCqNNpoaZy94HP3RXC6NNi6XRhuXS6MNUxptXC6NNtb3eht6g8ul0YapHd287vQ29AZNpdFGU+PsBY+jP5rLpdHG5dJo43JptGFKo43LpdHG+l5vQ29wuTTaMLWjm9ed3obeoKk02mhqnL3gcfRHc7k02rhcGm1cLo02TGm0cbk02ljf623oDS6XRhumdnTzutPb0Bs0lUYbTY2zFzyO/mgul0Ybl0ujjcul0YYpjTYul0Yb63u9Db3B5dJow9SObl53eht6g6bSaKOpcfaCx9EfzeXSaONyabRxuTTaMKXRxuXSaGN9r7ehN7hcGm2Y2tHN605vQ2/QVBptNDXOXvA4+qO5XBptXC6NNi6XRhumNNq4XBptrO/1NvQGl0ujDVM7unnd6W3oDZpKo42mxtkLHkd/NJdLo43LpdHG5dJow5RGG5dLo431vd6G3uByabRhakc3rzu9Db1BU2m00dQ4e8Hj6I/mcmm0cbk02rhcGm2Y0mjjcmm0sb7X29AbXC6NNkzt6OZ1p7ehN2gqjTaaGmcveBz90VwujTYul0Ybl0ujDVMabVwujTbW93obeoPLpdGGqR3dvO70NvQGTaXRRlPj7AWPoz+ay6XRxuXSaONyabRhSqONy6XRxvpeb0NvcLk02jC1o5vXnd6G3qCpNNpoapy94HH0R3O5NNq4XBptXC6NNkxptHG5NNpY3+tt6A0ul0YbpnZ087rT29AbNJVGG02Nsxc8jv5oLpdGG5dLo43LpdGGKY02LpdGG+t7vQ29weXSaMPUjm5ed3obeoOm0mijqXH2gsfRH83l2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCx9Ef9eXa0c3rTmm0YUqjDVMabVxuutA3Mr0NvYEpjTYul0YbTbWjm01ptHG5NNowzW37wsfRH/Xl2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCx9Ef9eXa0c3rTmm0YUqjDVMabVxuutA3Mr0NvYEpjTYul0YbTbWjm01ptHG5NNowzW37wsfRH/Xl2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCx9Ef9eXa0c3rTmm0YUqjDVMabVxuutA3Mr0NvYEpjTYul0YbTbWjm01ptHG5NNowzW37wsfRH/Xl2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCx9Ef9eXa0c3rTmm0YUqjDVMabVxuutA3Mr0NvYEpjTYul0YbTbWjm01ptHG5NNowzW37wsfRH/Xl2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCx9Ef9eXa0c3rTmm0YUqjDVMabVxuutA3Mr0NvYEpjTYul0YbTbWjm01ptHG5NNowzW37wsfRH/Xl2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCx9Ef9eXa0c3rTmm0YUqjDVMabVxuutA3Mr0NvYEpjTYul0YbTbWjm01ptHG5NNowzW37wsfRH/Xl2tHN605ptGFKow1TGm1cbrrQNzK9Db2BKY02LpdGG021o5tNabRxuTTaMM1t+8LH0R/15drRzetOabRhSqMNUxptXG660DcyvQ29gSmNNi6XRhtNtaObTWm0cbk02jDNbfvCZeiPsKl2dHNTabRhSqMNUxptNJVGG6Z2dPPl2tHNpjTaML0NvcF6XhptXC6NNtad3obeoKlx9oJl6EfeVDu6uak02jCl0YYpjTaaSqMNUzu6+XLt6GZTGm2Y3obeYD0vjTYul0Yb605vQ2/Q1Dh7wTL0I2+qHd3cVBptmNJow5RGG02l0YapHd18uXZ0symNNkxvQ2+wnpdGG5dLo411p7ehN2hqnL1gGfqRN9WObm4qjTZMabRhSqONptJow9SObr5cO7rZlEYbprehN1jPS6ONy6XRxrrT29AbNDXOXrAM/cibakc3N5VGG6Y02jCl0UZTabRhakc3X64d3WxKow3T29AbrOel0cbl0mhj3elt6A2aGmcvWIZ+5E21o5ubSqMNUxptmNJoo6k02jC1o5sv145uNqXRhult6A3W89Jo43JptLHu9Db0Bk2NsxcsQz/yptrRzU2l0YYpjTZMabTRVBptmNrRzZdrRzeb0mjD9Db0But5abRxuTTaWHd6G3qDpsbZC5ahH3lT7ejmptJow5RGG6Y02mgqjTZM7ejmy7Wjm01ptGF6G3qD9bw02rhcGm2sO70NvUFT4+wFy9CPvKl2dHNTabRhSqMNUxptNJVGG6Z2dPPl2tHNpjTaML0NvcF6XhptXC6NNtad3obeoKlx9oJl6EfeVDu6uak02jCl0YYpjTaaSqMNUzu6+XLt6GZTGm2Y3obeYD0vjTYul0Yb605vQ2/Q1Dh7wTL0I2+qHd3cVBptmNJow5RGG02l0YapHd18uXZ0symNNkxvQ2+wnpdGG5dLo411p7ehN2hqnL1gGfqRN9WObm4qjTZMabRhSqONptJow9SObr5cO7rZlEYbprehN1jPS6ONy6XRxrrT29AbNDXOXrAM/cibakc3N5VGG6Y02jCl0UZTabRhakc3X64d3WxKow3T29AbrOel0cbl0mhj3elt6A2aGmcvWIZ+5E21o5ubSqMNUxptmNJoo6k02jC1o5sv145uNqXRhult6A3W89Jo43JptLHu9Db0Bk2NsxcsQz/yptrRzU2l0YYpjTZMabTRVBptmNrRzZdrRzeb0mjD9Db0But5abRxuTTaWHd6G3qDpsbZC5ahH3lT7ejmptJow5RGG6Y02mgqjTZM7ejmy7Wjm01ptGF6G3qD9bw02rhcGm2sO70NvUFT4+wFy9CPvKl2dHNTabRhSqMNUxptNJVGG6Z2dPPl2tHNpjTaML0NvcF6XhptXC6NNtad3obeoKlx9oJl6EfeVDu6uak02jCl0YYpjTaaSqMNUzu6+XLt6GZTGm2Y3obeYD0vjTYul0Yb605vQ2/Q1Dh7wTL0I2+qHd3cVBptmNJow5RGG02l0YapHd18uXZ0symNNkxvQ2+wnpdGG5dLo411p7ehN2hqnL1gGfqRN9WObm4qjTZMabRhSqONptJow9SObr5cO7rZlEYbprehN1jPS6ONy6XRxrrT29AbNDXOXlCiH2VTabTRVDu6+XLt6GZTO7rZ1I5ubqod3Wx6G3oD09vQG1zubegNTGm00VQ7utnUjm42taObTePsBSX6UTaVRhtNtaObL9eObja1o5tN7ejmptrRzaa3oTcwvQ29weXeht7AlEYbTbWjm03t6GZTO7rZNM5eUKIfZVNptNFUO7r5cu3oZlM7utnUjm5uqh3dbHobegPT29AbXO5t6A1MabTRVDu62dSObja1o5tN4+wFJfpRNpVGG021o5sv145uNrWjm03t6Oam2tHNprehNzC9Db3B5d6G3sCURhtNtaObTe3oZlM7utk0zl5Qoh9lU2m00VQ7uvly7ehmUzu62dSObm6qHd1seht6A9Pb0Btc7m3oDUxptNFUO7rZ1I5uNrWjm03j7AUl+lE2lUYbTbWjmy/Xjm42taObTe3o5qba0c2mt6E3ML0NvcHl3obewJRGG021o5tN7ehmUzu62TTOXlCiH2VTabTRVDu6+XLt6GZTO7rZ1I5ubqod3Wx6G3oD09vQG1zubegNTGm00VQ7utnUjm42taObTePsBSX6UTaVRhtNtaObL9eObja1o5tN7ejmptrRzaa3oTcwvQ29weXeht7AlEYbTbWjm03t6GZTO7rZNM5eUKIfZVNptNFUO7r5cu3oZlM7utnUjm5uqh3dbHobegPT29AbXO5t6A1MabTRVDu62dSObja1o5tN4+wFJfpRNpVGG021o5sv145uNrWjm03t6Oam2tHNprehNzC9Db3B5d6G3sCURhtNtaObTe3oZlM7utk0zl5Qoh9lU2m00VQ7uvly7ehmUzu62dSObm6qHd1seht6A9Pb0Btc7m3oDUxptNFUO7rZ1I5uNrWjm03j7AUl+lE2lUYbTbWjmy/Xjm42taObTe3o5qba0c2mt6E3ML0NvcHl3obewJRGG021o5tN7ehmUzu62TTOXlCiH2VTabTRVDu6+XLt6GZTO7rZ1I5ubqod3Wx6G3oD09vQG1zubegNTGm00VQ7utnUjm42taObTePsBSX6UTaVRhtNtaObL9eObja1o5tN7ejmptrRzaa3oTcwvQ29weXeht7AlEYbTbWjm03t6GZTO7rZNM5eUKIfZVNptNFUO7r5cu3oZlM7utnUjm5uqh3dbHobegPT29AbXO5t6A1MabTRVDu62dSObja1o5tN4+wFJfpRNpVGG021o5sv145uNrWjm03t6Oam2tHNprehNzC9Db3B5d6G3sCURhtNtaObTe3oZlM7utk0zl5Qoh9lU2m00VQ7uvly7ehmUzu62dSObm6qHd1seht6A9Pb0Btc7m3oDUxptNFUO7rZ1I5uNrWjm03j7AUl+lE2lUYbTbWjmy/Xjm42taObTe3o5qba0c2mt6E3ML0NvcHl3obewJRGG021o5tN7ehmUzu62TTOXlCiH2VTabTRVDu6+XLt6GZTO7rZ1I5ubqod3Wx6G3oD09vQG1zubegNTGm00VQ7utnUjm42taObTePsBSX6UTaVRhtNtaObL9eObja1o5tN7ejmptrRzaa3oTcwvQ29weXeht7AlEYbTbWjm03t6GZTO7rZNM5esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/chN7ejm9bx2dLOpHd1sSqMNUxptmNrRzaZx6E2beht6A1MabZjSaKOpNNowpdHG+l5ptLGeN85esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/chN7ejm9bx2dLOpHd1sSqMNUxptmNrRzaZx6E2beht6A1MabZjSaKOpNNowpdHG+l5ptLGeN85esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/chN7ejm9bx2dLOpHd1sSqMNUxptmNrRzaZx6E2beht6A1MabZjSaKOpNNowpdHG+l5ptLGeN85esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/chN7ejm9bx2dLOpHd1sSqMNUxptmNrRzaZx6E2beht6A1MabZjSaKOpNNowpdHG+l5ptLGeN85esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/chN7ejm9bx2dLOpHd1sSqMNUxptmNrRzaZx6E2beht6A1MabZjSaKOpNNowpdHG+l5ptLGeN85esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/chN7ejm9bx2dLOpHd1sSqMNUxptmNrRzaZx6E2beht6A1MabZjSaKOpNNowpdHG+l5ptLGeN85esAz9yE3t6Ob1vHZ0s6kd3WxKow1TGm2Y2tHNpnHoTZt6G3oDUxptmNJoo6k02jCl0cb6Xmm0sZ43zl6wDP3ITe3o5vW8dnSzqR3dbEqjDVMabZja0c2mcehNm3obegNTGm2Y0mijqTTaMKXRxvpeabSxnjfOXrAM/cibakc3m96G3qCpNNpoqh3dbHobegPTdKFvZHobegNTO7q5qbehN2gqjTbW92pHN5vG2QuWoR95U+3oZtPb0Bs0lUYbTbWjm01vQ29gmi70jUxvQ29gakc3N/U29AZNpdHG+l7t6GbTOHvBMvQjb6od3Wx6G3qDptJoo6l2dLPpbegNTNOFvpHpbegNTO3o5qbeht6gqTTaWN+rHd1sGmcvWIZ+5E21o5tNb0Nv0FQabTTVjm42vQ29gWm60DcyvQ29gakd3dzU29AbNJVGG+t7taObTePsBcvQj7ypdnSz6W3oDZpKo42m2tHNprehNzBNF/pGprehNzC1o5ubeht6g6bSaGN9r3Z0s2mcvWAZ+pE31Y5uNr0NvUFTabTRVDu62fQ29Aam6ULfyPQ29AamdnRzU29Db9BUGm2s79WObjaNsxcsQz/yptrRzaa3oTdoKo02mmpHN5veht7ANF3oG5neht7A1I5ubupt6A2aSqON9b3a0c2mcfaCZehH3lQ7utn0NvQGTaXRRlPt6GbT29AbmKYLfSPT29AbmNrRzU29Db1BU2m0sb5XO7rZNM5esAz9yJtqRzeb3obeoKk02miqHd1seht6A9N0oW9keht6A1M7urmpt6E3aCqNNtb3akc3m8bZC5ahH3lT7ehm09vQGzSVRhtNtaObTW9Db2CaLvSNTG9Db2BqRzc39Tb0Bk2l0cb6Xu3oZtM4e8Ey9CNvqh3dbHobeoOm0mijqXZ0s+lt6A1M04W+kelt6A1M7ejmpt6G3qCpNNpY36sd3WwaZy9Yhn7kTbWjm01vQ2/QVBptNNWObja9Db2BabrQNzK9Db2BqR3d3NTb0Bs0lUYb63u1o5tN4+wFy9CPvKl2dLPpbegNmkqjjaba0c2mt6E3ME0X+kamt6E3MLWjm5t6G3qDptJoY32vdnSzaZy9YBn6kTfVjm42vQ29QVNptNFUO7rZ9Db0BqbpQt/I9Db0BqZ2dHNTb0Nv0FQabazv1Y5uNo2zFyxDP/Km2tHNprehN2gqjTaaakc3m96G3sA0Xegbmd6G3sDUjm5u6m3oDZpKo431vdrRzaZx9oJl6EfeVDu62fQ29AZNpdFGU+3oZtPb0BuYpgt9I9Pb0BuY2tHNTb0NvUFTabSxvlc7utk0zl6wDP3Im2pHN5veht6gqTTaaKod3Wx6G3oD03Shb2R6G3oDUzu6uam3oTdoKo021vdqRzebxtkLlqEfeVPt6GbT29AbNJVGG021o5tNb0NvYJou9I1Mb0NvYGpHNzf1NvQGTaXRxvpe7ehm0zh7wTL0I2+qHd1seht6g6bSaKOpdnSz6W3oDUzThb6R6W3oDUzt6Oam3obeoKk02ljfqx3dbBpnL1iGfuRNtaObTW9Db9BUGm001Y5uNr0NvYFputA3Mr0NvYGpHd3c1NvQGzSVRhvre7Wjm03j7AXL0I+8qbehNzC1o5tNabSxvlcabZjSaGN9r3Z0symNNkzt6GZTGm00NV3oG5nSaMM0XegbmcbZC5ahH3lTb0NvYGpHN5vSaGN9rzTaMKXRxvpe7ehmUxptmNrRzaY02mhqutA3MqXRhmm60DcyjbMXLEM/8qbeht7A1I5uNqXRxvpeabRhSqON9b3a0c2mNNowtaObTWm00dR0oW9kSqMN03Shb2QaZy9Yhn7kTb0NvYGpHd1sSqON9b3SaMOURhvre7Wjm01ptGFqRzeb0mijqelC38iURhum6ULfyDTOXrAM/cibeht6A1M7utmURhvre6XRhimNNtb3akc3m9Jow9SObjal0UZT04W+kSmNNkzThb6RaZy9YBn6kTf1NvQGpnZ0symNNtb3SqMNUxptrO/Vjm42pdGGqR3dbEqjjaamC30jUxptmKYLfSPTOHvBMvQjb+pt6A1M7ehmUxptrO+VRhumNNpY36sd3WxKow1TO7rZlEYbTU0X+kamNNowTRf6RqZx9oJl6Efe1NvQG5ja0c2mNNpY3yuNNkxptLG+Vzu62ZRGG6Z2dLMpjTaami70jUxptGGaLvSNTOPsBcvQj7ypt6E3MLWjm01ptLG+VxptmNJoY32vdnSzKY02TO3oZlMabTQ1XegbmdJowzRd6BuZxtkLlqEfeVNvQ29gakc3m9JoY32vNNowpdHG+l7t6GZTGm2Y2tHNpjTaaGq60DcypdGGabrQNzKNsxcsQz/ypt6G3sDUjm42pdHG+l5ptGFKo431vdrRzaY02jC1o5tNabTR1HShb2RKow3TdKFvZBpnL1iGfuRNvQ29gakd3WxKo431vdJow5RGG+t7taObTWm0YWpHN5vSaKOp6ULfyJRGG6bpQt/INM5esAz9yJt6G3oDUzu62ZRGG+t7pdGGKY021vdqRzeb0mjD1I5uNqXRRlPThb6RKY02TNOFvpFpnL1gGfqRN/U29AamdnSzKY021vdKow1TGm2s79WObjal0YapHd1sSqONpqYLfSNTGm2Ypgt9I9M4e8Ey9CNv6m3oDUzt6GZTGm2s75VGG6Y02ljfqx3dbEqjDVM7utmURhtNTRf6RqY02jBNF/pGpnH2gmXoR97U29AbmNrRzaY02ljfK402TGm0sb5XO7rZlEYbpnZ0symNNpqaLvSNTGm0YZou9I1M4+wFy9CPvKm3oTcwtaObTWm0sb5XGm2Y0mhjfa92dLMpjTZM7ehmUxptNDVd6BuZ0mjDNF3oG5nG2QuWoR95U29Db2BqRzeb0mhjfa802jCl0cb6Xu3oZlMabZja0c2mNNpoarrQNzKl0YZputA3Mo2zFyxDP/Km3obewNSObjal0cb6Xmm0YUqjjfW92tHNpjTaMLWjm01ptNHUdKFvZEqjDdN0oW9kGmcvWIZ+5E29Db2BqR3dbEqjjfW90mjDlEYb63u1o5tNabRhakc3m9Joo6npQt/IlEYbpulC38g0zl6wDP3ILzcOvWlTabTRVBptNJVGG6Y02jCl0YYpjTZMabRhakc3r++VRhumNNpo6m3oDZpKow1TGm2Y5rZ94TL0R3i5cehNm0qjjabSaKOpNNowpdGGKY02TGm0YUqjDVM7unl9rzTaMKXRRlNvQ2/QVBptmNJowzS37QuXoT/Cy41Db9pUGm00lUYbTaXRhimNNkxptGFKow1TGm2Y2tHN63ul0YYpjTaaeht6g6bSaOP/27GDFcmSJQmi///VM4u3lYQoVOnQMJcDslbH4lY3ZFIbbSTpNn/hMfSP8HLK0E2XaqONpdpoY6k22khqo42kNtpIaqONpDbaSFpHb7bv1UYbSW20sdRr6AZLtdFGUhttJOk2f+Ex9I/wcsrQTZdqo42l2mhjqTbaSGqjjaQ22khqo42kNtpIWkdvtu/VRhtJbbSx1GvoBku10UZSG20k6TZ/4TH0j/ByytBNl2qjjaXaaGOpNtpIaqONpDbaSGqjjaQ22khaR2+279VGG0lttLHUa+gGS7XRRlIbbSTpNn/hMfSP8HLK0E2XaqONpdpoY6k22khqo42kNtpIaqONpDbaSFpHb7bv1UYbSW20sdRr6AZLtdFGUhttJOk2f+Ex9I/wcsrQTZdqo42l2mhjqTbaSGqjjaQ22khqo42kNtpIWkdvtu/VRhtJbbSx1GvoBku10UZSG20k6TZ/4TH0j/ByytBNl2qjjaXaaGOpNtpIaqONpDbaSGqjjaQ22khaR2+279VGG0lttLHUa+gGS7XRRlIbbSTpNn/hMfSP8HLK0E2XaqONpdpoY6k22khqo42kNtpIaqONpDbaSFpHb7bv1UYbSW20sdRr6AZLtdFGUhttJOk2f+Ex9I/wcsrQTZdqo42l2mhjqTbaSGqjjaQ22khqo42kNtpIWkdvtu/VRhtJbbSx1GvoBku10UZSG20k6TZ/4TH0j/ByytBNl2qjjaXaaGOpNtpIaqONpDbaSGqjjaQ22khaR2+279VGG0lttLHUa+gGS7XRRlIbbSTpNn/hMfSP8HLK0E2XaqONpdpoY6k22khqo42kNtpIaqONpDbaSFpHb7bv1UYbSW20sdRr6AZLtdFGUhttJOk2f+Ex9I/wcsrQTZdqo42l2mhjqTbaSGqjjaQ22khqo42kNtpIWkdvtu/VRhtJbbSx1GvoBku10UZSG20k6TZ/4TH0j/ByytBNl2qjjaXaaGOpNtpIaqONpDbaSGqjjaQ22khaR2+279VGG0lttLHUa+gGS7XRRlIbbSTpNn/hMfSP8HLK0E2XaqONpdpoY6k22khqo42kNtpIaqONpDbaSFpHb7bv1UYbSW20sdRr6AZLtdFGUhttJOk2f+Ex9I/wcsrQTZdqo42l2mhjqTbaSGqjjaQ22khqo42kNtpIWkdvtu/VRhtJbbSx1GvoBku10UZSG20k6TZ/4TH0j/ByytBNl2qjjaXaaGOpNtpIaqONpDbaSGqjjaQ22khaR2+279VGG0lttLHUa+gGS7XRRlIbbSTpNn/hMfSP8HLK0E2XaqONpdpoY6k22khqo42kNtpIaqONpDbaSFpHb7bv1UYbSW20sdRr6AZLtdFGUhttJOk2f+Ex9I/wcsrQTZdqo42l2mhjqTbaSGqjjaQ22khqo42kNtpIWkdvtu/VRhtJbbSx1GvoBku10UZSG20k6TZ/4RD9o0nSFvqNLtdGG5drow37vNfQDZLaaCNpHb3ZvlcbbSS10UZSG20s1UYbl2ujDfte2uIvEqKPPElb6De6XBttXK6NNuzzXkM3SGqjjaR19Gb7Xm20kdRGG0lttLFUG21cro027Htpi79IiD7yJG2h3+hybbRxuTbasM97Dd0gqY02ktbRm+17tdFGUhttJLXRxlJttHG5Ntqw76Ut/iIh+siTtIV+o8u10cbl2mjDPu81dIOkNtpIWkdvtu/VRhtJbbSR1EYbS7XRxuXaaMO+l7b4i4ToI0/SFvqNLtdGG5drow37vNfQDZLaaCNpHb3ZvlcbbSS10UZSG20s1UYbl2ujDfte2uIvEqKPPElb6De6XBttXK6NNuzzXkM3SGqjjaR19Gb7Xm20kdRGG0lttLFUG21cro027Htpi79IiD7yJG2h3+hybbRxuTbasM97Dd0gqY02ktbRm+17tdFGUhttJLXRxlJttHG5Ntqw76Ut/iIh+siTtIV+o8u10cbl2mjDPu81dIOkNtpIWkdvtu/VRhtJbbSR1EYbS7XRxuXaaMO+l7b4i4ToI0/SFvqNLtdGG5drow37vNfQDZLaaCNpHb3ZvlcbbSS10UZSG20s1UYbl2ujDfte2uIvEqKPPElb6De6XBttXK6NNuzzXkM3SGqjjaR19Gb7Xm20kdRGG0lttLFUG21cro027Htpi79IiD7yJG2h3+hybbRxuTbasM97Dd0gqY02ktbRm+17tdFGUhttJLXRxlJttHG5Ntqw76Ut/iIh+siTtIV+o8u10cbl2mjDPu81dIOkNtpIWkdvtu/VRhtJbbSR1EYbS7XRxuXaaMO+l7b4i4ToI0/SFvqNLtdGG5drow37vNfQDZLaaCNpHb3ZvlcbbSS10UZSG20s1UYbl2ujDfte2uIvEqKPPElb6De6XBttXK6NNuzzXkM3SGqjjaR19Gb7Xm20kdRGG0lttLFUG21cro027Htpi79IiD7yJG2h3+hybbRxuTbasM97Dd0gqY02ktbRm+17tdFGUhttJLXRxlJttHG5Ntqw76Ut/iIh+siTtIV+o8u10cbl2mjDPu81dIOkNtpIWkdvtu/VRhtJbbSR1EYbS7XRxuXaaMO+l7b4i4ToI0/SFvqNLtdGG5drow37vNfQDZLaaCNpHb3ZvlcbbSS10UZSG20s1UYbl2ujDfte2uIvEqKPPElb6De6XBttXK6NNuzzXkM3SGqjjaR19Gb7Xm20kdRGG0lttLFUG21cro027Htpi79IiD7yJG2h3+hybbRxuTbasM97Dd0gqY02ktbRm+17tdFGUhttJLXRxlJttHG5Ntqw76Ut/iIh+siTtIV+o8u10cbl2mjDPu81dIOkNtpIWkdvtu/VRhtJbbSR1EYbS7XRxuXaaMO+l7b4i4yhfzRJbbSRJOlv9G9mqXX05qQ22khaR29OaqONpdpoI6mNNuzz1tGb7fNeQzdY6jV0gyRlvOAY+siT2mgjSdLf6N/MUuvozUlttJG0jt6c1EYbS7XRRlIbbdjnraM32+e9hm6w1GvoBknKeMEx9JEntdFGkqS/0b+ZpdbRm5PaaCNpHb05qY02lmqjjaQ22rDPW0dvts97Dd1gqdfQDZKU8YJj6CNPaqONJEl/o38zS62jNye10UbSOnpzUhttLNVGG0lttGGft47ebJ/3GrrBUq+hGyQp4wXH0Eee1EYbSZL+Rv9mllpHb05qo42kdfTmpDbaWKqNNpLaaMM+bx292T7vNXSDpV5DN0hSxguOoY88qY02kiT9jf7NLLWO3pzURhtJ6+jNSW20sVQbbSS10YZ93jp6s33ea+gGS72GbpCkjBccQx95UhttJEn6G/2bWWodvTmpjTaS1tGbk9poY6k22khqow37vHX0Zvu819ANlnoN3SBJGS84hj7ypDbaSJL0N/o3s9Q6enNSG20kraM3J7XRxlJttJHURhv2eevozfZ5r6EbLPUaukGSMl5wDH3kSW20kSTpb/RvZql19OakNtpIWkdvTmqjjaXaaCOpjTbs89bRm+3zXkM3WOo1dIMkZbzgGPrIk9poI0nS3+jfzFLr6M1JbbSRtI7enNRGG0u10UZSG23Y562jN9vnvYZusNRr6AZJynjBMfSRJ7XRRpKkv9G/maXW0ZuT2mgjaR29OamNNpZqo42kNtqwz1tHb7bPew3dYKnX0A2SlPGCY+gjT2qjjSRJf6N/M0utozcntdFG0jp6c1IbbSzVRhtJbbRhn7eO3myf9xq6wVKvoRskKeMFx9BHntRGG0mS/kb/ZpZaR29OaqONpHX05qQ22liqjTaS2mjDPm8dvdk+7zV0g6VeQzdIUsYLjqGPPKmNNpIk/Y3+zSy1jt6c1EYbSevozUlttLFUG20ktdGGfd46erN93mvoBku9hm6QpIwXHEMfeVIbbSRJ+hv9m1lqHb05qY02ktbRm5PaaGOpNtpIaqMN+7x19Gb7vNfQDZZ6Dd0gSRkvOIY+8qQ22kiS9Df6N7PUOnpzUhttJK2jNye10cZSbbSR1EYb9nnr6M32ea+hGyz1GrpBkjJecAx95ElttJEk6W/0b2apdfTmpDbaSFpHb05qo42l2mgjqY027PPW0Zvt815DN1jqNXSDJGW84Bj6yJPaaCNJ0t/o38xS6+jNSW20kbSO3pzURhtLtdFGUhtt2Oetozfb572GbrDUa+gGScp4wTH0kSe10UaSpL/Rv5ml1tGbk9poI2kdvTmpjTaWaqONpDbasM9bR2+2z3sN3WCp19ANkpTxgmPoI09qo40kSX+jfzNLraM3J7XRRtI6enNSG20s1UYbSW20YZ+3jt5sn/causFSr6EbJCnjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Eee9Bq6wVJttLFUG21cro02llpHb07SbfSb2+fpNvrNL7eO3ny5dfTmyynjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Eee9Bq6wVJttLFUG21cro02llpHb07SbfSb2+fpNvrNL7eO3ny5dfTmyynjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Eee9Bq6wVJttLFUG21cro02llpHb07SbfSb2+fpNvrNL7eO3ny5dfTmyynjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Eee9Bq6wVJttLFUG21cro02llpHb07SbfSb2+fpNvrNL7eO3ny5dfTmyynjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Eee9Bq6wVJttLFUG21cro02llpHb07SbfSb2+fpNvrNL7eO3ny5dfTmyynjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Eee9Bq6wVJttLFUG21cro02llpHb07SbfSb2+fpNvrNL7eO3ny5dfTmyynjBcfQR570GrrBUm20sVQbbVyujTaWWkdvTtJt9Jvb5+k2+s0vt47efLl19ObLKeMFx9BHnvQausFSbbSxVBttXK6NNpZaR29O0m30m9vn6Tb6zS+3jt58uXX05ssp4wXH0Ed+OUl/o38zl2ujDfu8NtpIaqONy62jNye9hm6Q9Bq6weXaaCPpNXSDyynjBcfQR345SX+jfzOXa6MN+7w22khqo43LraM3J72GbpD0GrrB5dpoI+k1dIPLKeMFx9BHfjlJf6N/M5drow37vDbaSGqjjcutozcnvYZukPQausHl2mgj6TV0g8sp4wXH0Ed+OUl/o38zl2ujDfu8NtpIaqONy62jNye9hm6Q9Bq6weXaaCPpNXSDyynjBcfQR345SX+jfzOXa6MN+7w22khqo43LraM3J72GbpD0GrrB5dpoI+k1dIPLKeMFx9BHfjlJf6N/M5drow37vDbaSGqjjcutozcnvYZukPQausHl2mgj6TV0g8sp4wXH0Ed+OUl/o38zl2ujDfu8NtpIaqONy62jNye9hm6Q9Bq6weXaaCPpNXSDyynjBcfQR345SX+jfzOXa6MN+7w22khqo43LraM3J72GbpD0GrrB5dpoI+k1dIPLKeMFx9BHfjlJf6N/M5drow37vDbaSGqjjcutozcnvYZukPQausHl2mgj6TV0g8sp4wXH0Ed+OUl/o38zl2ujDfu8NtpIaqONy62jNye9hm6Q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N016Dd1gKelf+MVIP4z+J3C5NtpYah29Oek1dIPLvYZuYHdaR29eShm6adJr6AZLSf/CL0b6YfQ/gcu10cZS6+jNSa+hG1zuNXQDu9M6evNSytBNk15DN1hK+hd+MdIPo/8JXK6NNpZaR29Oeg3d4HKvoRvYndbRm5dShm6a9Bq6wVLSv/CLkX4Y/U/gcm20sdQ6enPSa+gGl3sN3cDutI7evJQydNOk19ANlpL+hV+M9MPofwKXa6ONpdbRm5NeQze43GvoBnandfTmpZShmya9hm6wlPQv/GKkH0b/E7hcG20stY7enPQausHlXkM3sDutozcvpQzdNOk1dIOlpH/hFyP9MPqfwOXaaGOpdfTmpNfQDS73GrqB3WkdvXkpZeimSa+hGywl/Qu/GOmH0f8ELtdGG0utozcnvYZucLnX0A3sTuvozUspQzdNeg3dYCnpX/jFSD+M/idwuTbaWGodvTnpNXSDy72GbmB3WkdvXkoZumnSa+gGS0n/wi8mRP8Izf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KM3+ah29eak22jD7r1pHb05qo42kNtq4XBttLLWO3pz0GrrB5dpoI6mNNpZqo42llPGCIfoozf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KM3+ah29eak22jD7r1pHb05qo42kNtq4XBttLLWO3pz0GrrB5dpoI6mNNpZqo42llPGCIfoozf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KM3+ah29eak22jD7r1pHb05qo42kNtq4XBttLLWO3pz0GrrB5dpoI6mNNpZqo42llPGCIfoozf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KM3+ah29eak22jD7r1pHb05qo42kNtq4XBttLLWO3pz0GrrB5dpoI6mNNpZqo42llPGCIfoozf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KM3+ah29eak22jD7r1pHb05qo42kNtq4XBttLLWO3pz0GrrB5dpoI6mNNpZqo42llPGCIfoozf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KM3+ah29eak22jD7r1pHb05qo42kNtq4XBttLLWO3pz0GrrB5dpoI6mNNpZqo42llPGCIfoozf5qHb15qTbaMPuvWkdvTmqjjaQ22rhcG20stY7enPQausHl2mgjqY02lmqjjaWU8YIh+ijN/modvXmpNtow+69aR29OaqONpDbauFwbbSy1jt6c9Bq6weXaaCOpjTaWaqONpZTxgiH6KJO0hX6jpDbasO/VRhtJ6+jNl2ujjaVeQzdIeg3dwD5vHb05qY02ktpoI+k1dIOl2mhjKWW8YIg+yiRtod8oqY027Hu10UbSOnrz5dpoY6nX0A2SXkM3sM9bR29OaqONpDbaSHoN3WCpNtpYShkvGKKPMklb6DdKaqMN+15ttJG0jt58uTbaWOo1dIOk19AN7PPW0ZuT2mgjqY02kl5DN1iqjTaWUsYLhuijTNIW+o2S2mjDvlcbbSStozdfro02lnoN3SDpNXQD+7x19OakNtpIaqONpNfQDZZqo42llPGCIfook7SFfqOkNtqw79VGG0nr6M2Xa6ONpV5DN0h6Dd3APm8dvTmpjTaS2mgj6TV0g6XaaGMpZbxgiD7KJG2h3yipjTbse7XRRtI6evPl2mhjqdfQDZJeQzewz1tHb05qo42kNtpIeg3dYKk22lhKGS8Yoo8ySVvoN0pqow37Xm20kbSO3ny5NtpY6jV0g6TX0A3s89bRm5PaaCOpjTaSXkM3WKqNNpZSxguG6KNM0hb6jZLaaMO+VxttJK2jN1+ujTaWeg3dIOk1dAP7vHX05qQ22khqo42k19ANlmqjjaWU8YIh+iiTtIV+o6Q22rDv1UYbSevozZdro42lXkM3SHoN3cA+bx29OamNNpLaaCPpNXSDpdpoYyllvGCIPsokbaHfKKmNNux7tdFG0jp68+XaaGOp19ANkl5DN7DPW0dvTmqjjaQ22kh6Dd1gqTbaWEoZLxiijzJJW+g3SmqjDftebbSRtI7efLk22ljqNXSDpNfQDezz1tGbk9poI6mNNpJeQzdYqo02llLGC4boo0zSFvqNktpow75XG20kraM3X66NNpZ6Dd0g6TV0A/u8dfTmpDbaSGqjjaTX0A2WaqONpZTxgiH6KJO0hX6jpDbasO/VRhtJ6+jNl2ujjaVeQzdIeg3dwD5vHb05qY02ktpoI+k1dIOl2mhjKWW8YIg+yiRtod8oqY027Hu10UbSOnrz5dpoY6nX0A2SXkM3sM9bR29OaqONpDbaSHoN3WCpNtpYShkvGKKPMklb6DdKaqMN+15ttJG0jt58uTbaWOo1dIOk19AN7PPW0ZuT2mgjqY02kl5DN1iqjTaWUsYLhuijTNIW+o2S2mjDvlcbbSStozdfro02lnoN3SDpNXQD+7x19OakNtpIaqONpNfQDZZqo42llPGCIfook7SFfqOkNtqw79VGG0nr6M2Xa6ONpV5DN0h6Dd3APm8dvTmpjTaS2mgj6TV0g6XaaGMpZbxgiD7KJG2h3yipjTbse7XRRtI6evPl2mhjqdfQDZJeQzewz1tHb05qo42kNtpIeg3dYKk22lhKGS8Yoo8ySVvoN0pqow37Xm20kbSO3ny5NtpY6jV0g6TX0A3s89bRm5PaaCOpjTaSXkM3WKqNNpZSxguG6KNM0hb6jZLaaMO+VxttJK2jN1+ujTaWeg3dIOk1dAP7vHX05qQ22khqo42k19ANlmqjjaWU8YIh+iiT2mjjcm20kdRGG0lttJHURhtJytBNL7eO3mzfq402kpShmya10cZS6+jNdqc22khqo40kZbxgiD7KpDbauFwbbSS10UZSG20ktdFGkjJ008utozfb92qjjSRl6KZJbbSx1Dp6s92pjTaS2mgjSRkvGKKPMqmNNi7XRhtJbbSR1EYbSW20kaQM3fRy6+jN9r3aaCNJGbppUhttLLWO3mx3aqONpDbaSFLGC4boo0xqo43LtdFGUhttJLXRRlIbbSQpQze93Dp6s32vNtpIUoZumtRGG0utozfbndpoI6mNNpKU8YIh+iiT2mjjcm20kdRGG0lttJHURhtJytBNL7eO3mzfq402kpShmya10cZS6+jNdqc22khqo40kZbxgiD7KpDbauFwbbSS10UZSG20ktdFGkjJ008utozfb92qjjSRl6KZJbbSx1Dp6s92pjTaS2mgjSRkvGKKPMqmNNi7XRhtJbbSR1EYbSW20kaQM3fRy6+jN9r3aaCNJGbppUhttLLWO3mx3aqONpDbaSFLGC4boo0xqo43LtdFGUhttJLXRRlIbbSQpQze93Dp6s32vNtpIUoZumtRGG0utozfbndpoI6mNNpKU8YIh+iiT2mjjcm20kdRGG0lttJHURhtJytBNL7eO3mzfq402kpShmya10cZS6+jNdqc22khqo40kZbxgiD7KpDbauFwbbSS10UZSG20ktdFGkjJ008utozfb92qjjSRl6KZJbbSx1Dp6s92pjTaS2mgjSRkvGKKPMqmNNi7XRhtJbbSR1EYbSW20kaQM3fRy6+jN9r3aaCNJGbppUhttLLWO3mx3aqONpDbaSFLGC4boo0xqo43LtdFGUhttJLXRRlIbbSQpQze93Dp6s32vNtpIUoZumtRGG0utozfbndpoI6mNNpKU8YIh+iiT2mjjcm20kdRGG0lttJHURhtJytBNL7eO3mzfq402kpShmya10cZS6+jNdqc22khqo40kZbxgiD7KpDbauFwbbSS10UZSG20ktdFGkjJ008utozfb92qjjSRl6KZJbbSx1Dp6s92pjTaS2mgjSRkvGKKPMqmNNi7XRhtJbbSR1EYbSW20kaQM3fRy6+jN9r3aaCNJGbppUhttLLWO3mx3aqONpDbaSFLGC4boo0xqo43LtdFGUhttJLXRRlIbbSQpQze93Dp6s32vNtpIUoZumtRGG0utozfbndpoI6mNNpKU8YIh+iiT2mjjcm20kdRGG0lttJHURhtJytBNL7eO3mzfq402kpShmya10cZS6+jNdqc22khqo40kZbxgiD7KpDbauFwbbSS10UZSG20ktdFGkjJ008utozfb92qjjSRl6KZJ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"),
      ),
    );
  }

  showQrCodeDilaog(MyTicketsProvider myTicketsProvider, int index) async {
    CommonMethods.showLoadingDialog(context);
    await myTicketsProvider.getPassengerConfirmationDetails(myTicketsProvider.ticketDetails[index].ticketno.toString());
    await myTicketsProvider.getQrTextEn(myTicketsProvider.ticketsResponse.ticket![index].ticketno.toString());
    Navigator.pop(context);
    if (myTicketsProvider.passengerConfirmDetailsResponse.code == "100") {
      if (myTicketsProvider.getQrTextEnResponse.code == "101") {
        showTicketDiloag(myTicketsProvider, index);
      } else {
        CommonMethods.showSnackBar(context, "Something went wrong ....");
      }
    } else if (myTicketsProvider.passengerConfirmDetailsResponse.code == "999") {
      CommonMethods.showTokenExpireDialog(context);
    } else if (myTicketsProvider.passengerConfirmDetailsResponse.code == "900") {
      CommonMethods.showErrorDialog(context, "Something went wrong !");
    } else {
      CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong !");
    }

  }

  moveToCancelTicketDetailsScreen(MyTicketsProvider myTicketsProvider, int index) {
    Navigator.pushNamed(context, MyRoutes.cancelTicketsScreen,
        arguments:  CancelTicketsScreenDetailsArguments(
            myTicketsProvider.ticketDetails[index].ticketno!,
            myTicketsProvider.ticketDetails[index].source!,
            myTicketsProvider.ticketDetails[index].destination!,
            myTicketsProvider.ticketDetails[index].destination!,
            myTicketsProvider.ticketDetails[index].journeydate!,
            myTicketsProvider.ticketDetails[index].busservicetypename!,
            myTicketsProvider.ticketDetails[index].deptitme!,
            myTicketsProvider.ticketDetails[index].arrival!)).then((value) => checkTicketsForRating(myTicketsProvider));
  }

  checkTicketsForRating(MyTicketsProvider myTicketsProvider) {
    myTicketsProvider.ticketDetails.clear();
    myTicketsProvider.getTickets();
  }

  checkData(MyTicketsProvider myTicketsProvider) {
    if (myTicketsProvider.isLoading) {
      return false;
    } else if (myTicketsProvider.isLoading == false && myTicketsProvider.ticketDetails.isEmpty) {
      return true;
    } else {
      return false;
    }
  }


}
