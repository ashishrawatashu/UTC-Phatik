import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/screens/trackMyBusScreen/track_my_bus_screen_provider.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class TrackMyBusScreen extends StatefulWidget {
  const TrackMyBusScreen({Key? key}) : super(key: key);

  @override
  State<TrackMyBusScreen> createState() => _TrackMyBusScreenState();
}

class _TrackMyBusScreenState extends State<TrackMyBusScreen> {
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
        // automaticallyImplyLeading: false,
        backgroundColor: HexColor(MyColors.primaryColor),
        title: Text("Track My BUs"),
      ),
      body: Container(
        color: HexColor(MyColors.homegrey),
        child: myBusesListBuilder(),
      ),
    );
  }


  myBusesListLayout(int index) {
    return Card(
      child: Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PNR: PNR23456789DFGHJK",style: GoogleFonts.nunito(fontSize: 15),),
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
                        Text("Dehradun ISBT",style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 16,fontWeight: FontWeight.bold),),
                        Text("Delhi Kashmiri Gate ISBT",style: GoogleFonts.nunito(color: HexColor(MyColors.black),fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date:  20/22/2022",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1)),),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(MyColors.orange),
                      ),
                      height: 30,
                      width: 100,
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
                  )
                ],
              )


              
            ],
          )
      ),
    );

  }

  myBusesListBuilder() {
    return Consumer<TrackMyBusScreenProvider>(builder: (_, ratingListProvider, __) {
      return /*ratingListProvider.isLoading?CommonWidgets.buildCircularProgressIndicatorWidget(): */ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 4,
        // itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return myBusesListLayout(index);
        },
      );
    });
  }

}
