import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class OfferDetailsScreen extends StatefulWidget {

  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();


}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(MyColors.primaryColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Offer Details"),
      ),
        body: Container(
          color: HexColor(MyColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Image.asset("assets/images/offerimage.png",height: 200,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Book Return Ticket !",style: GoogleFonts.nunito(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: HexColor(MyColors.primaryColor)
                ),),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                margin: EdgeInsets.only(top: 5,bottom: 2),
                child: Text("Flat Rs. 100 off for you | Code RETURN100",style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor(MyColors.grey4)
                ),),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: "your text"));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 5, bottom: 5,left: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HexColor(MyColors.orange),
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Copy Coupon Code",
                          style: GoogleFonts.roboto(
                              color: HexColor(MyColors.white),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Image.asset(
                          "assets/images/copyicon.png",
                          height: 15,
                          fit: BoxFit.fill,
                          width: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10),
                height: 1,
                color: HexColor(MyColors.grey7),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text("Terms & Conditions ",style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: HexColor(MyColors.grey6)
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/terms.png",fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
              ),


            ],
          ),
        ),
    );
  }
}
