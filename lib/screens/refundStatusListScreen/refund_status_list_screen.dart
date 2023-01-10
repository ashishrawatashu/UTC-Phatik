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
        itemCount: 2,
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
              Text("PNR: "+refundTicketsProvider.refundTicketsList[index].ticketno!,style: GoogleFonts.nunito(fontSize: 15),),
              Row(
                children: [
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 12,right: 12,left: 12),
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
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(refundTicketsProvider.refundTicketsList[index].ticketno!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(refundTicketsProvider.refundTicketsList[index].ticketno!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date:  "+refundTicketsProvider.refundTicketsList[index].cancellationdate!,style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1)),),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, MyRoutes.webPagesScreen,arguments: WebPageUrlArguments(AppConstants.REFUND_STATUS_URL, "Refund Status"));

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
                    ),
                  )
                ],
              )



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
