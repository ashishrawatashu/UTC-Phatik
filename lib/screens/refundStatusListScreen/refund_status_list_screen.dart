import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/web_page_url_arguments.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/screens/refundStatusListScreen/refund_tickets_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

import '../../utils/colors_code.dart';
import '../../utils/hex_color.dart';
import '../trackMyBusScreen/track_my_bus_screen_provider.dart';

class RefundStatusListScreen extends StatefulWidget {
  const RefundStatusListScreen({Key? key}) : super(key: key);

  @override
  State<RefundStatusListScreen> createState() => _RefundStatusListScreenState();
}

class _RefundStatusListScreenState extends State<RefundStatusListScreen> {

  late RefundTicketsProvider _refundTicketsProvider;
  @override
  void initState() {
    _refundTicketsProvider = Provider.of<RefundTicketsProvider>(context, listen: false);
    getRefundTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RefundTicketsProvider>(builder: (_, refundTicketsProvider, __) {
      return Scaffold(
        endDrawerEnableOpenDragGesture: true,
        endDrawer: NavigationDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>  Navigator.pushNamed(context, MyRoutes.homeRoute),
          ),
          // automaticallyImplyLeading: false,
          backgroundColor: HexColor(MyColors.primaryColor),
          title: Text(
            "Refund Status", style: GoogleFonts.nunito(fontSize: 18),),
        ),
        body: Container(
          color: HexColor(MyColors.grey2),
          child: Stack(
            children: [
              Visibility(
                visible: refundTicketsProvider.refundTicketsList.isEmpty?false:true,
                  child: Column(
                    children: [
                      // enterOfferManually(),
                      myBusesListBuilder()
                    ],
                  )),
              Visibility(
                  visible: refundTicketsProvider.isLoading,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget()),
              Visibility(
                  visible: checkData(refundTicketsProvider),
                  child: CommonMethods.noDataFound(context)
              )
            ],
          ),
        ),
      );
    });
  }

  myBusesListBuilder() {
    return Consumer<RefundTicketsProvider>(builder: (_, refundTicketsProvider, __) {
      return /*ratingListProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget(): */ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: refundTicketsProvider.refundTicketsList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return myBusesListLayout(index,refundTicketsProvider);
        },
      );
    });
  }

  myBusesListLayout(int index, RefundTicketsProvider refundTicketsProvider) {

    return Card(
      child: Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PNR: "+refundTicketsProvider.refundTicketsList[index].ticketno!,style: GoogleFonts.nunito(fontSize: 16),),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cancellation Ref no.",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1),fontWeight: FontWeight.w600),),
                        Text(refundTicketsProvider.refundTicketsList[index].cancellationrefno!,style: GoogleFonts.nunito(fontSize: 16,color: HexColor(MyColors.black)),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cancellation Date/Time",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1),fontWeight: FontWeight.w600),),
                            Text(refundTicketsProvider.refundTicketsList[index].cancellationdate!,style: GoogleFonts.nunito(fontSize: 16,color: HexColor(MyColors.black)),),
                          ],
                        ),
                        InkWell(
                          onTap: (){

                            refundTicketsProvider.checkRefundStatus(index,context);


                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor(MyColors.orange),
                            ),
                            height: 40,
                            width: 120,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Center(child: Text("Check Status",style: GoogleFonts.nunito(color: HexColor((MyColors.white))),)),
                            ),
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ],
          )
      ),
    );

  }

  checkData(RefundTicketsProvider refundTicketsProvider) {
    if(refundTicketsProvider.isLoading&&refundTicketsProvider.refundTicketsList.isEmpty){
      return false;
    }else if (refundTicketsProvider.isLoading==false&&refundTicketsProvider.refundTicketsList.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  void getRefundTickets() async {
    await _refundTicketsProvider.authenticationMethod();
    _refundTicketsProvider.getRefundTickets();
  }
}
