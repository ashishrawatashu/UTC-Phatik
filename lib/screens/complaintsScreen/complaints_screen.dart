import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/grivance_details_arguments.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/screens/complaintsScreen/complaint_screen_provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);
  @override
  _ComplaintsScreenState createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  late ComplaintsScreenProvider _complaintsScreenProvider;
  
  @override
  void initState() {
    super.initState();
    _complaintsScreenProvider = Provider.of<ComplaintsScreenProvider>(context, listen: false);
    _complaintsScreenProvider.getGrivanceList.clear();

    Future.delayed(Duration.zero, () async {
      await _complaintsScreenProvider.authenticationMethod();
      await _complaintsScreenProvider.getGrievance();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ComplaintsScreenProvider>(
        builder: (_, complaintScreenProvider, __){
          return Scaffold(
            endDrawerEnableOpenDragGesture: true,
            endDrawer: NavigationDrawer(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
              ),
              backgroundColor: HexColor(MyColors.primaryColor),
              title: Text("Complaints"),
            ),
            body: complaintsListBuilder(),
          );
    });
    }



  complaintsListBuilder() {
    return Consumer<ComplaintsScreenProvider>(builder: (_, complaintsScreenProvider, __) {
      return Stack(
        children: [
          Visibility(
              visible: complaintsScreenProvider.isLoading?true:false,
              child: CommonWidgets.buildCircularProgressIndicatorWidget()),
          Visibility(
              visible: complaintsScreenProvider.isLoading?false:true,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: complaintsScreenProvider.getGrivanceList.length,
                // itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return complaintsListItems(index);
                },
              )),
          Visibility(
              visible: checkData(complaintsScreenProvider),
              child: CommonMethods.noDataFound(context)),
        ],
      );
    });
  }

  complaintsListItems(int index) {

    return Consumer<ComplaintsScreenProvider>(builder: (_, complaintsScreenProvider, __) {
      return Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(complaintsScreenProvider.getGrivanceList[index].ticketnumber!, style: GoogleFonts.nunito(
              //     fontSize: 14,
              //     color: HexColor(MyColors.black),
              //     fontWeight: FontWeight.w600
              // ),),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  "Ref.no :"+complaintsScreenProvider.getGrivanceList[index].grefno!, style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: HexColor(MyColors.grey1),
                    fontWeight: FontWeight.w500
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Row(
                      children: [
                        Text("Category: ", style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: HexColor(MyColors.grey1),
                            fontWeight: FontWeight.w500
                        ),),
                        Text(complaintsScreenProvider.getGrivanceList[index].categoryname!, style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: HexColor(MyColors.black),
                            fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Image.asset(
                          'assets/images/cal.png',
                          height: 18,
                          color: HexColor(MyColors.orange),
                          width: 18,
                        ),
                      ),
                      Text(complaintsScreenProvider.getGrivanceList[index].gdatetime!, style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: HexColor(MyColors.grey1),
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            MyRoutes.grievanceDetailsScreen,
                            arguments: GrivenanceDetailsArguments(_complaintsScreenProvider.getGrivanceList[index].grefno!));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            color: HexColor(MyColors.primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "View Detail",
                                style: GoogleFonts.roboto(
                                    color: HexColor(MyColors.white),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),

      );
    });

  }
  checkData(ComplaintsScreenProvider complaintsScreenProvider) {
    if (complaintsScreenProvider.isLoading && complaintsScreenProvider.getGrivanceList.isEmpty) {
      return false;
    } else if (complaintsScreenProvider.isLoading == false &&
        complaintsScreenProvider.getGrivanceList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
