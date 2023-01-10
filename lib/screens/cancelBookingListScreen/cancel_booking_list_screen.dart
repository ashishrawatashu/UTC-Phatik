import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/cancel_ticket_deatils_screen_arguments.dart';
import 'package:utc_flutter_app/response/get_cancel_available_tickets_response.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

import '../../utils/colors_code.dart';
import '../../utils/hex_color.dart';
import '../bottomTabsScreens/myBookingTab/my_tickets_provider.dart';
import 'cancel_ticket_list_provider.dart';

class CancelBookingListScreen extends StatefulWidget {
  const CancelBookingListScreen({Key? key}) : super(key: key);

  @override
  State<CancelBookingListScreen> createState() => _CancelBookingListScreenState();

}

class _CancelBookingListScreenState extends State<CancelBookingListScreen> {

  late CancelTicketListProvider _cancelTicketsListProvider;

  String from = "";



  @override
  void initState() {
    super.initState();
    _cancelTicketsListProvider = Provider.of<CancelTicketListProvider>(context, listen: false);
    _cancelTicketsListProvider.ticketsList.clear();

    Future.delayed(Duration.zero, () async {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        await _cancelTicketsListProvider.authenticationMethod();
        _cancelTicketsListProvider.getCancelAvailableTickets();
      }
      else {
        CommonMethods.showNoInternetDialog(context);
      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          endDrawerEnableOpenDragGesture: true,
          endDrawer: NavigationDrawer(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
            ),
            backgroundColor: HexColor(MyColors.primaryColor),
            title: Text("Cancel Tickets"),
          ),
          body: cancelListBuilder(),
        ));

  }



  cancelListItems(int index) {
    return Consumer<CancelTicketListProvider>(builder: (_, cancelTicketsListProvider, __) {
      return Card(
        child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 3),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PNR: "+cancelTicketsListProvider.ticketsList[index].ticketno!,
                  style: GoogleFonts.nunito(fontSize: 15),),
                Row(
                  children: [
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 12, right: 12, left: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: HexColor(MyColors.orange))
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
                                border: Border.all(
                                    color: HexColor(MyColors.orange))
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(cancelTicketsListProvider.ticketsList[index].source!, style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),),
                          Text(cancelTicketsListProvider.ticketsList[index].destination!, style: GoogleFonts
                              .nunito(color: HexColor(MyColors.black),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date:  "+cancelTicketsListProvider.ticketsList[index].journeydate!, style: GoogleFonts.nunito(
                        fontSize: 14, color: HexColor(MyColors.grey1)),),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          moveToCancelTicketDetailsScreen(cancelTicketsListProvider,index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: HexColor(MyColors.redColor),
                          ),
                          height: 40,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Center(
                              child: Text("Cancel Ticket",
                                style: GoogleFonts.nunito(
                                    color: HexColor((MyColors.white))),),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )


              ],
            )
        ),
      );
    });
  }

  cancelListBuilder() {
    return Consumer<CancelTicketListProvider>(builder: (_, cancelTicketsListProvider, __) {
      return Stack(
        children: [
          Visibility(
              visible: cancelTicketsListProvider.isLoading?true:false,
              child: CommonWidgets.buildCircularProgressIndicatorWidget()),
          Visibility(
              visible: cancelTicketsListProvider.isLoading?false:true,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: cancelTicketsListProvider.ticketsList.length,
                // itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return cancelListItems(index);
                },
              )),
          Visibility(
              visible: checkData(cancelTicketsListProvider),
              child: CommonMethods.noActiveBookings(context)),
        ],
      );
    });
  }

  checkData(CancelTicketListProvider cancelTicketsListProvider) {
    if(cancelTicketsListProvider.isLoading&&cancelTicketsListProvider.ticketsList.isEmpty){
      return false;
    }else if (cancelTicketsListProvider.isLoading==false&&cancelTicketsListProvider.ticketsList.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  void moveToCancelTicketDetailsScreen(CancelTicketListProvider cancelTicketsListProvider,int index) {
    Navigator.pushNamed(context, MyRoutes.cancelTicketsScreen,
        arguments:  CancelTicketsScreenDetailsArguments(
          cancelTicketsListProvider.ticketsList[index].ticketno!,
            cancelTicketsListProvider.ticketsList[index].source!,
            cancelTicketsListProvider.ticketsList[index].destination!,
            cancelTicketsListProvider.ticketsList[index].destination!,
            cancelTicketsListProvider.ticketsList[index].journeydate!,
            cancelTicketsListProvider.ticketsList[index].busservicetypename!,
            cancelTicketsListProvider.ticketsList[index].departuretime!,
            cancelTicketsListProvider.ticketsList[index].arrivaltime!)).then((value) => checkTicketsForRating(cancelTicketsListProvider));
  }

  checkTicketsForRating(CancelTicketListProvider cancelTicketsListProvider) {
    cancelTicketsListProvider.ticketsList.clear();
    cancelTicketsListProvider.getCancelAvailableTickets();

  }

}
