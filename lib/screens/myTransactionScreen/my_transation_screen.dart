import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class MyTransactionScreen extends StatefulWidget {
  const MyTransactionScreen({Key? key}) : super(key: key);

  @override
  State<MyTransactionScreen> createState() => _MyTransactionScreenState();

}

class _MyTransactionScreenState extends State<MyTransactionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(MyColors.primaryColor),
        title: Text(
          "My Transaction",style: GoogleFonts.nunito(
        ),
        ),
      ),
      body: Container(
        child: myTransationListBuilder(),
      ),
    );
  }


  Widget myTransationListBuilder() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 10,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return myTransationListLayout(index);
      },
    );
  }

  Widget myTransationListLayout(int index) {
    return  Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 3),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:EdgeInsets.all(5.0),
                      child: Image.asset("assets/images/rupeeicon.png",height: 50,width: 50,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ticket Booking",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.black),fontWeight: FontWeight.w600),),
                        Text("09-05-2022 03:33 PM",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.grey1)),),

                      ],
                    ),
                  ],
                ),
                Text("+₹ "+"100.00",style: GoogleFonts.nunito(fontSize: 14,color: HexColor(MyColors.green),fontWeight: FontWeight.w700),),
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

}
