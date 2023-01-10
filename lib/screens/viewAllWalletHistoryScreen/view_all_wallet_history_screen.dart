import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class ViewAllWalletHistoryScreen extends StatefulWidget {
  const ViewAllWalletHistoryScreen({Key? key}) : super(key: key);

  @override
  _ViewAllWalletHistoryScreenState createState() => _ViewAllWalletHistoryScreenState();
}

class _ViewAllWalletHistoryScreenState extends State<ViewAllWalletHistoryScreen> {
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
        title: Text("Wallet History"),
      ),
      body: walletHistoryListBuilder(),
    );
  }


  Widget walletHistoryListBuilder() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:  10,
      // itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return walletHistoryListLayout(index);
      },
    );
  }

  Widget walletHistoryListLayout(int index) {

    return Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/rupeeicon.png",height: 55,width: 55,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Amount Credit",style: GoogleFonts.nunito(fontSize: 20,color: HexColor(MyColors.black),fontWeight: FontWeight.w600),),
                        Text("27/09/2022",style: GoogleFonts.nunito(fontSize: 16,color: HexColor(MyColors.grey1)),),

                      ],
                    ),
                  ],
                ),
                Text("+₹500.0",style: GoogleFonts.nunito(fontSize: 16,color: HexColor(MyColors.green),fontWeight: FontWeight.w700),),


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
