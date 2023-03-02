import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/screens/raiseAlarmScreen/raise_alarm_screen_provider.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/consants.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import '../../utils/common_widigits.dart';
class RaiseAlarmScreen extends StatefulWidget {

  const RaiseAlarmScreen({Key? key}) : super(key: key);
  @override
  State<RaiseAlarmScreen> createState() => _RaiseAlarmScreenState();

}

class _RaiseAlarmScreenState extends State<RaiseAlarmScreen> {
  late RaiseAlarmScreenProvider _alarmScreenProvider;

  @override
  void dispose() {
    // _alarmScreenProvider.close();
    super.dispose();
  }

  @override
  void initState() {
    _alarmScreenProvider =
        Provider.of<RaiseAlarmScreenProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      getRaiseAlarmData();
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: HexColor(MyColors.primaryColor),
        title: Text("Raise Alarm"),
      ),
      body: Container(
        color: HexColor(MyColors.homegrey),
        child: raiseAlarmBody(),
      ),
    );
  }


  myBusesListLayout(int index, RaiseAlarmScreenProvider raiseAlarmProvider) {

    return Card(
      child: Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PNR: "+raiseAlarmProvider.getAllTickets[index].ticketno!,style: GoogleFonts.nunito(fontSize: 15),),
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
                        Text(raiseAlarmProvider.getAllTickets[index].source!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 14,fontWeight: FontWeight.w600),),
                        Text(raiseAlarmProvider.getAllTickets[index].destination!,style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 14,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date: "+raiseAlarmProvider.getAllTickets[index].journeydate!,style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1)),),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        getAlarmList(raiseAlarmProvider.getAllTickets[index].ticketno.toString());

                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor(MyColors.redColor),
                        ),
                        height: 40,
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/bellicon.png",height: 15,width: 15,color: HexColor((MyColors.white))),
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("Raise Alarm",style: GoogleFonts.nunito(color: HexColor((MyColors.white))),),
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

  myBusesListBuilder() {

    return Consumer<RaiseAlarmScreenProvider>(builder: (_, raiseAlarmProvider, __) {
      return /*ratingListProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget(): */ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: raiseAlarmProvider.getAllTickets.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return myBusesListLayout(index,raiseAlarmProvider);
        },
      );
    });
  }

  showRaiseAlarmDialog(String ticketNo){

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(20.0)),
            child: contentBox(context,ticketNo),

          );
        });

  }

  contentBox(context, String ticketNo){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          padding: EdgeInsets.only(left: 10,top: 50, right: 10,bottom: 0
          ),
          margin: EdgeInsets.only(top: 55),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: HexColor(MyColors.dashBg),
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 50
                ),
              ]
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("In Case of emergency",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                SizedBox(height: 5,),
                Text("Tap to raise alarm",style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                SizedBox(height: 22,),


                alarmCategoriesListBuilder(ticketNo)
              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/bellimagebg.png")
            ),
          ),
        ),
      ],
    );
  }

  showAlarmRaised(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
            height: 180,
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Done !",
                    style: GoogleFonts.nunito(
                        fontSize: 18, color: HexColor(MyColors.black)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Your Alarm has been raised and forwarded to control room for necessary action.",
                    style: GoogleFonts.nunito(
                        fontSize: 15,
                        color: HexColor(MyColors.black)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor(MyColors.orange),
                    ),
                    child: Center(
                        child: Text(
                          "OK",
                          style: GoogleFonts.nunito(
                              fontSize: 15, color: HexColor(MyColors.white)),
                        )),
                  ),
                )
              ],
            ));
      },
    );
  }

  alarmCategoriesListBuilder(String ticketNo) {
    return Consumer<RaiseAlarmScreenProvider>(builder: (_, raiseAlarmProvider, __) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: raiseAlarmProvider.alarmList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return alarmCategoriesListItems(index,raiseAlarmProvider,ticketNo);
        },
      );
    });
  }


  alarmCategoriesListItems(int index, RaiseAlarmScreenProvider raiseAlarmProvider, String ticketNo) {
    return  Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        onTap: (){saveAlarm(raiseAlarmProvider,index,ticketNo);},
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(raiseAlarmProvider.alarmList[index].alarmtype!,style: GoogleFonts.nunito(fontSize: 14),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward,color: Colors.black,),
              )
            ],

          ),
        ),
      ),
    );
  }

  void getAlarmList(String ticketNo) async {
   //  CommonMethods.showLoadingDialog(context);
   // await _alarmScreenProvider.getAlarmCategories();
   // Navigator.pop(context);
    showRaiseAlarmDialog(ticketNo);

  }

  void saveAlarm(RaiseAlarmScreenProvider raiseAlarmProvider, int index, String ticketNo) async {
    Navigator.pop(context);
    await raiseAlarmProvider.saveAlarm(raiseAlarmProvider.alarmList[index].alarmtypeid.toString(),ticketNo);
    CommonMethods.showLoadingDialog(context);
    if(raiseAlarmProvider.saveAlarmResponse.code == "100"){
      Navigator.pop(context);
      showAlarmRaised();
    }else if(raiseAlarmProvider.saveAlarmResponse.code == "999"){
      Navigator.pop(context);
      CommonMethods.showTokenExpireDialog(context);
    }else if(raiseAlarmProvider.saveAlarmResponse.code == "900"){
      Navigator.pop(context);
      CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
    }else {
      Navigator.pop(context);
      CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again");
    }
  }

  raiseAlarmBody() {
    return Consumer<RaiseAlarmScreenProvider>(
        builder: (_, raiseAlarmProvider, __) {
          return Stack(
            children: [
              Visibility(
                  visible: raiseAlarmProvider.isLoading?true:false,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget()),
              Visibility(
                  visible: raiseAlarmProvider.isLoading?false:true,
                  child: myBusesListBuilder()),
              Visibility(
                  visible: checkData(raiseAlarmProvider),
                  child: CommonMethods.noDataState(context,"You can raise alarm only during the journey")),
            ],
          );

        });
  }

  checkData(RaiseAlarmScreenProvider raiseAlarmProvider) {
    if(raiseAlarmProvider.isLoading&&raiseAlarmProvider.getAllTickets.isEmpty){
      return false;
    }else if (raiseAlarmProvider.isLoading==false&&raiseAlarmProvider.getAllTickets.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  void getRaiseAlarmData() async {
    await _alarmScreenProvider.authenticationMethod();
    if(_alarmScreenProvider.authenticationMethodResponse.code=="100"){
      await _alarmScreenProvider.getAlarmCategories();
      await _alarmScreenProvider.getConfirmsTickets();
    }else {
      CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again");
    }

  }

}