import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

void  paymentIsUnderProcessDialogBox(BuildContext context, String ticketNumber)  {
   showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (BuildContext context) {
      return Container(
          height: 140,
          padding: EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Your booking is under process",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: HexColor(MyColors.black)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Do you want to cancel your booking process ?",
                  style: GoogleFonts.nunito(
                      fontSize: 15, color: HexColor(MyColors.black)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: HexColor(MyColors.orange)),
                        color: HexColor(MyColors.white),
                      ),
                      child: Center(
                          child: Text(
                            "No",
                            style: GoogleFonts.nunito(
                                fontSize: 15, color: HexColor(MyColors.orange)),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(context);
                      Navigator.pushNamed(context, MyRoutes.bookingHistoryDetailsScreen, arguments: PaymentScreenArguments(ticketNumber, "Booking"));
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor(MyColors.orange),
                      ),
                      child: Center(
                          child: Text(
                            "Yes",
                            style: GoogleFonts.nunito(
                                fontSize: 15, color: HexColor(MyColors.white)),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ));
    },
  );
}

void  paymentIsFailedDialogBox(BuildContext context, String ticketNumber)  {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (BuildContext context) {
      return Container(
          height: 140,
          padding: EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Your booking is under process",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: HexColor(MyColors.black)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Do you want to cancel your booking process ?",
                  style: GoogleFonts.nunito(
                      fontSize: 15, color: HexColor(MyColors.black)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: HexColor(MyColors.orange)),
                        color: HexColor(MyColors.white),
                      ),
                      child: Center(
                          child: Text(
                            "No",
                            style: GoogleFonts.nunito(
                                fontSize: 15, color: HexColor(MyColors.orange)),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(context);
                      Navigator.pushNamed(context, MyRoutes.bookingHistoryDetailsScreen, arguments: PaymentScreenArguments(ticketNumber, "Booking"));
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor(MyColors.orange),
                      ),
                      child: Center(
                          child: Text(
                            "Yes",
                            style: GoogleFonts.nunito(
                                fontSize: 15, color: HexColor(MyColors.white)),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ));
    },
  );
}
