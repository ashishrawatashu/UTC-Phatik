import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/web_page_url_arguments.dart';
import 'package:utc_flutter_app/screens/locateMyBusScreen/locate_my_bus_screen_provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/common_methods.dart';
import '../../utils/common_widigits.dart';
import '../../utils/hex_color.dart';

class LocateMyBusScreen extends StatefulWidget {
  const LocateMyBusScreen({Key? key}) : super(key: key);

  @override
  State<LocateMyBusScreen> createState() => _LocateMyBusScreenState();
}

class _LocateMyBusScreenState extends State<LocateMyBusScreen> {

  late LocateMyBusScreenBusProvider _locateMyBusScreenBusProvider;

  @override
  void initState() {
    super.initState();
    _locateMyBusScreenBusProvider = Provider.of<LocateMyBusScreenBusProvider>(context, listen: false);
    _locateMyBusScreenBusProvider.getAllTickets.clear();

    Future.delayed(Duration.zero, () async {
      getActiveTickets();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      endDrawer: NavigationDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
        ),
        backgroundColor: HexColor(MyColors.primaryColor),
        title: Text("Locate/Track my bus",style: GoogleFonts.nunito(fontSize: 18),),
      ),
      body: Container(
        color: HexColor(MyColors.homegrey),
        child:locateBusBody(),
      ),
    );
  }


  myBusesListLayout(int index, LocateMyBusScreenBusProvider locateMyBusProvider) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(bottom: 5,top: 5),
          margin: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("PNR: "+locateMyBusProvider.getAllTickets[index].ticketno!,
                      style: GoogleFonts.nunito(fontSize: 12),),
                  ),
                  Text("Journey Date: "+locateMyBusProvider.getAllTickets[index].journeydate!, style: GoogleFonts.nunito(
                      fontSize: 12, color: HexColor(MyColors.grey1)),),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(top: 12, right: 12, left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: HexColor(
                                  MyColors.orange))
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
                              border: Border.all(color: HexColor(
                                  MyColors.orange))
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locateMyBusProvider.getAllTickets[index].source!, style: GoogleFonts.nunito(
                            color: HexColor(MyColors.black),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),),
                        Text(locateMyBusProvider.getAllTickets[index].destination!,
                          style: GoogleFonts.nunito(
                              color: HexColor(MyColors.black),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8,right: 8,top: 8),
                                child: Image.asset("assets/images/orangebus.png",height: 18,width: 18,color: HexColor(MyColors.orange),),
                              ),
                              Text(locateMyBusProvider.getAllTickets[index].servicetypenameen!,style: GoogleFonts.nunito(fontSize: 14),),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/crewicon.png",height: 20,width: 20,),
                              ),
                              Text(locateMyBusProvider.getAllTickets[index].conductorname!.trim()==""?"Conductore name N/A":locateMyBusProvider.getAllTickets[index].conductorname!.trim(),style: GoogleFonts.nunito(fontSize: 12),)
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/crewicon.png",height: 20,width: 20,),
                              ),
                              Text(locateMyBusProvider.getAllTickets[index].drivername!.trim()==""?"Drive name N/A":locateMyBusProvider.getAllTickets[index].drivername!.trim(),style: GoogleFonts.nunito(fontSize: 12),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    child: Image.asset("assets/images/location.png",height: 18,width: 18,color: HexColor(MyColors.orange),),
                                  ),
                                  Text("Bus location N/A",style: GoogleFonts.nunito(fontSize: 12),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 130,
                      child: statusList(index,locateMyBusProvider),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: locateMyBusProvider.getAllTickets[index].conductormobile.toString()=="NA"?false:true,
                    child: GestureDetector(
                      onTap: ()=>setState(() {
                        // launch('tel:${"12321232"}');
                        _makePhoneCall(locateMyBusProvider.getAllTickets[index].conductormobile.toString());
                      }),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5,top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.orange),
                        ),
                        height: 35,
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone,color: HexColor(MyColors.white),size: 20,),
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("Contact Staff",style: GoogleFonts.nunito(color: HexColor((MyColors.white))),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, MyRoutes.webPagesScreen,arguments: WebPageUrlArguments(AppConstants.TRACK_MY_BUS, "Track my bus"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(MyColors.orange),
                      ),
                      height: 35,
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/trackmybus.png",height: 15,width: 15,color: HexColor((MyColors.white))),
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text("Track Bus",style: GoogleFonts.nunito(color: HexColor((MyColors.white))),),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )

            ],
          )
      ),
    );
  }

  myBusesListBuilder() {
    return Consumer<LocateMyBusScreenBusProvider>(
        builder: (_, locateMyBusProvider, __) {
          return /*ratingListProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget(): */
            ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: locateMyBusProvider.getAllTickets.length,
            // itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return myBusesListLayout(index,locateMyBusProvider);
            },
          );
        });
  }

  locateBusBody() {
    return Consumer<LocateMyBusScreenBusProvider>(
        builder: (_, locateMyBusProvider, __) {
          return Stack(
            children: [
              Visibility(
                  visible: locateMyBusProvider.isLoading?true:false,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget()),
              Visibility(
                  visible: locateMyBusProvider.isLoading?false:true,
                  child: myBusesListBuilder()),
              Visibility(
                  visible: checkData(locateMyBusProvider),
                  child: Center(child: CommonMethods.noActiveBookings(context))),
            ],
          );
            
        });
  }

  checkData(LocateMyBusScreenBusProvider locateMyBusProvider) {
    if(locateMyBusProvider.isLoading&&locateMyBusProvider.getAllTickets.isEmpty){
      return false;
    }else if (locateMyBusProvider.isLoading==false&&locateMyBusProvider.getAllTickets.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  statusList(int index, LocateMyBusScreenBusProvider locateMyBusProvider) {
    String journeyStatus = locateMyBusProvider.getAllTickets[index].journeystatus!;
    List<String> journeyStatusList = journeyStatus.split(',');
    return /*ratingListProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget(): */
      ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: journeyStatusList.length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return statusListItems(itemIndex,journeyStatusList);
        },
      );
  }

  statusListItems(int index, List<String>  journeyStatusList) {
    return  Container(
      height: 28,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Image.asset("assets/images/roundDot.png",height: 12,width: 12,color: HexColor(MyColors.orange),),
          ),
          Text(journeyStatusList[index].toString(),style: GoogleFonts.nunito(fontSize: 12),),
        ],
      ),
    );
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void getActiveTickets() async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
    await _locateMyBusScreenBusProvider.authenticationMethod();
    _locateMyBusScreenBusProvider.getConfirmsTickets();
    // _cancelTicketsListProvider.getTickets();
    }
    else {
    CommonMethods.showNoInternetDialog(context);
    }
  }

}
