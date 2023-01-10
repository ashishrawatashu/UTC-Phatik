import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/grivance_details_arguments.dart';
import 'package:utc_flutter_app/screens/grievanceDetailsScreen/grivance_details_screen_provilder.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class GrievanceDetailsScreen extends StatefulWidget {
  const GrievanceDetailsScreen({Key? key}) : super(key: key);

  @override
  _GrievanceDetailsScreenState createState() => _GrievanceDetailsScreenState();
}

class _GrievanceDetailsScreenState extends State<GrievanceDetailsScreen> {
  late GrievanceDetailsScreenProvider _grievanceDetailsScreenProvider;

  @override
  void initState() {
    super.initState();
    _grievanceDetailsScreenProvider =
        Provider.of<GrievanceDetailsScreenProvider>(context, listen: false);
    // _grievanceDetailsScreenProvider.setLoading(true);
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)!.settings.arguments as GrivenanceDetailsArguments;
      //print(args.refNo);
      _grievanceDetailsScreenProvider.setLoading(true);
      _grievanceDetailsScreenProvider.getGrivanceDetails(args.refNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GrievanceDetailsScreenProvider>(
        builder: (_, grievanceDetailsScreenProvider, __) {
      return Scaffold(
          endDrawerEnableOpenDragGesture: true,
          endDrawer: NavigationDrawer(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: HexColor(MyColors.primaryColor),
            title: Text("Grievance Details"),
          ),
          body: checkIsLoading(grievanceDetailsScreenProvider));
    });
  }

  complaintsStatusListBuilder(
      GrievanceDetailsScreenProvider grievanceDetailsScreenProvider) {
    return ListView.builder(
      itemCount: grievanceDetailsScreenProvider.getGrievanceDetailsResponse.grievanceTransaction!.length,
      itemBuilder: (BuildContext context, int index) {
        return complaintsStausListLayout(index, grievanceDetailsScreenProvider);
      },
    );
  }

  complaintsStausListLayout(int index,
      GrievanceDetailsScreenProvider grievanceDetailsScreenProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          grievanceDetailsScreenProvider.getGrievanceDetailsResponse
              .grievanceTransaction![index].statusname
              .toString(),
          style: GoogleFonts.nunito(
              fontSize: 16,
              color: HexColor(MyColors.black),
              fontWeight: FontWeight.w600),
        ),
        Text(
          grievanceDetailsScreenProvider.getGrievanceDetailsResponse
              .grievanceTransaction![index].updatedby
              .toString(),
          style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: HexColor(MyColors.grey1)),
        ),
        Container(
          color: HexColor(MyColors.lightGrey),
          height: 1,
        )
      ],
    );
  }

  checkIsLoading(GrievanceDetailsScreenProvider grievanceDetailsScreenProvider) {
    if(grievanceDetailsScreenProvider.isLoading){
      return CommonWidgets.buildCircularProgressIndicatorWidget();
    }else if(grievanceDetailsScreenProvider.getGrievanceDetailsResponse.code=="100"){
      return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Grievance",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              grievanceDetailsScreenProvider
                  .getGrievanceDetailsResponse
                  .grievance![0]
                  .categoryname! +
                  "-" +
                  grievanceDetailsScreenProvider
                      .getGrievanceDetailsResponse
                      .grievance![0]
                      .categoryname!,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: HexColor(MyColors.grey1),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Reference No",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              grievanceDetailsScreenProvider
                  .getGrievanceDetailsResponse
                  .grievance![0]
                  .grefno!,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: HexColor(MyColors.grey1),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Remark",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              grievanceDetailsScreenProvider
                  .getGrievanceDetailsResponse
                  .grievance![0]
                  .gremark
                  .toString(),
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: HexColor(MyColors.grey1),
                  fontWeight: FontWeight.w500),
            ),
            Visibility(
              visible:  grievanceDetailsScreenProvider
                  .getGrievanceDetailsResponse
                  .grievance![0].busno==null?false:true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bus Number",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    grievanceDetailsScreenProvider
                        .getGrievanceDetailsResponse
                        .grievance![0]
                        .busno
                        .toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Visibility(
              visible:  grievanceDetailsScreenProvider
                  .getGrievanceDetailsResponse
                  .grievance![0].ticketnumber==" "?false:true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ticket No",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    grievanceDetailsScreenProvider
                        .getGrievanceDetailsResponse
                        .grievance![0]
                        .ticketnumber
                        .toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: HexColor(MyColors.grey1),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              "Date & Time",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: HexColor(MyColors.black),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              grievanceDetailsScreenProvider
                  .getGrievanceDetailsResponse
                  .grievance![0]
                  .gdatetime!,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: HexColor(MyColors.grey1),
                  fontWeight: FontWeight.w500),
            ),
            // Text(
            //   "Status",
            //   style: GoogleFonts.nunito(fontSize: 18),
            // ),
            // Container(
            //   color: HexColor(MyColors.lightGrey),
            //   height: 1,
            // ),
            // Container(
            //   height: 100,
            //   child: complaintsStatusListBuilder(grievanceDetailsScreenProvider),
            // ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.memory(Uint8List.fromList(grievanceDetailsScreenProvider.getGrievanceDetailsResponse.grievance![0].gpic1!),fit: BoxFit.fill,
                          errorBuilder: (context,o,s){
                            return Container();
                          },),
                      )),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.memory(Uint8List.fromList(grievanceDetailsScreenProvider.getGrievanceDetailsResponse.grievance![0].gpic2!),fit: BoxFit.fill,
                            errorBuilder: (context,o,s){
                              return Container();
                            },)
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    }

  }
}
