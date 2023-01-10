import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/arguments/rate_screen_arguments.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/screens/ratingListScreen/rating_list_provider.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class RateListScreen extends StatefulWidget {
  const RateListScreen({Key? key}) : super(key: key);

  @override
  _RateListScreenState createState() => _RateListScreenState();

}

class _RateListScreenState extends State<RateListScreen> {
  late RatingListProvider _ratingListProvider;
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want exit from app ? '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  void initState() {
    _ratingListProvider = Provider.of<RatingListProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      await _ratingListProvider.authenticationMethod();
      _ratingListProvider.getRatingTickets();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RatingListProvider>(
      builder: (_,rateListProvider,__){
        return Scaffold(
          endDrawerEnableOpenDragGesture: true,
          endDrawer: NavigationDrawer(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>  Navigator.pushNamed(context, MyRoutes.homeRoute),
            ),
            backgroundColor: HexColor(MyColors.primaryColor),
            title: Text("Ratings our services"),
          ),
          body: Container(
            child: Stack(
              children: [
                Visibility(
                  visible: rateListProvider.isLoading ? false : true,
                  child: rateListProvider.isLoading == false &&
                      rateListProvider.getRatingTicketsList.length > 0
                      ? ratingListBuilder()
                      : CommonMethods.noDataState(context, "Sorry, there is no completed journey !"),
                ),
                Visibility(
                  visible: rateListProvider.isLoading,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ratingListCardLayout(int index, RatingListProvider ratingListProvider){
    return Card(
      child: Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PNR: "+ratingListProvider.getRatingTicketsList[index].ticketno!,style: GoogleFonts.nunito(fontSize: 15),),
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
                    padding: EdgeInsets.only(top: 8,bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ratingListProvider.getRatingTicketsList[index].fromstation!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 14,fontWeight: FontWeight.w600),),
                        Text(ratingListProvider.getRatingTicketsList[index].tostation.toString(),style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 14,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Journey Date: "+ratingListProvider.getRatingTicketsList[index].journeydate.toString(),style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1)),),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: ()=>clickOnRate(index,ratingListProvider,ratingListProvider.getRatingTicketsList[index].ticketno!,ratingListProvider.getRatingTicketsList[index].busservicetypename,ratingListProvider.getRatingTicketsList[index].fromstation!+"-"+ratingListProvider.getRatingTicketsList[index].tostation!),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.green),
                        ),
                        height: 35,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("Rate Bus",style: GoogleFonts.nunito(color: HexColor((MyColors.white))),),
                            )
                          ],
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

  ratingListLayout(int index, RatingListProvider rateListProvider) {
    return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset("assets/images/ticketicon.png",height: 35,width: 35,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rateListProvider.getRatingTicketsList[index].ticketno!,style: GoogleFonts.nunito(fontSize: 16,color: HexColor(MyColors.black),fontWeight: FontWeight.w600),),
                        Text(rateListProvider.getRatingTicketsList[index].fromstation!+"-"+rateListProvider.getRatingTicketsList[index].tostation!,style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1)),),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: ()=>clickOnRate(index,rateListProvider,rateListProvider.getRatingTicketsList[index].ticketno!,rateListProvider.getRatingTicketsList[index].busservicetypename,rateListProvider.getRatingTicketsList[index].fromstation!+"-"+rateListProvider.getRatingTicketsList[index].tostation!),
                    child: Text("Rate",style: GoogleFonts.nunito(fontSize: 18,color: HexColor(MyColors.green),fontWeight: FontWeight.w600),)),
              ],
            ),
            Container(
              color: HexColor(MyColors.grey2),
              height: 1,
            )
          ],
        )
    );

  }
  clickOnRate(int index, RatingListProvider rateListProvider, String ticketno, String? serviceTypeName, String? serviceName) {
    Navigator.pushNamed(context, MyRoutes.rateScreen, arguments: RateScreenArguments(ticketno,serviceTypeName!,serviceName!,rateListProvider.getRatingTicketsList.length)).then((value) => checkRatingList());
  }

  ratingListBuilder() {
    return Consumer<RatingListProvider>(builder: (_, ratingListProvider, __) {
      return ratingListProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget(): ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: ratingListProvider.getRatingTicketsList.length,
        // itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ratingListCardLayout(index,ratingListProvider);
        },
      );
    });
  }

  checkRatingList() {
    _ratingListProvider.getRatingTickets();
    if(_ratingListProvider.getRatingTicketsList.isEmpty){
      Navigator.pushNamed(context, MyRoutes.homeRoute);
    }
  }


}
