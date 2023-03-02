import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class CommonWidgets {

  static Widget buildCircularProgressIndicatorWidget() {
    return Container(
      child: Center(
          child: CircularProgressIndicator(),
          // ),
        ),
    );
  }

  static Widget buildListViewNoDataWidget() {
    return /*Expanded(
      child:*/
      Center(
        child: Text("No Data Available"),
        // ),
      );
  }




  static Widget somethingWentWrong(BuildContext context){
    return Center(
      child: Column(
        children: [
          Text("Something went wrong!",style: GoogleFonts.nunito(
            fontSize: 16
          ),),
          ElevatedButton(onPressed: (){},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(HexColor(MyColors.primaryColor)),),
              child: Container(
            color: HexColor(MyColors.primaryColor),
            child: Text("Retry",style: GoogleFonts.nunito(fontSize: 16,color: HexColor(MyColors.white)),),
          ))
        ],
      ),
      // ),
    );


  }

}