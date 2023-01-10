import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/screens/viewAllOffersScreen/view_all_offers_screen_provider.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/common_widigits.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class MyAccountTab extends StatefulWidget {
  const MyAccountTab({Key? key}) : super(key: key);

  @override
  MyAccountTabState createState() => MyAccountTabState();

}

class MyAccountTabState extends State<MyAccountTab> {
  bool isloading = false;

  late ViewAllOffersProvider  _viewAllOffersProvider;
  @override
  void initState() {
    super.initState();
    _viewAllOffersProvider = Provider.of<ViewAllOffersProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      if (await CommonMethods.getInternetUsingInternetConnectivity()) {
        await _viewAllOffersProvider.authenticationMethod();
        _viewAllOffersProvider.getAllOffers();
      }
      else {
        CommonMethods.showNoInternetDialog(context);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewAllOffersProvider>(builder: (_, viewAllOffersProvider, __) {

      return Scaffold(
        endDrawerEnableOpenDragGesture: true,
        endDrawer: NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: HexColor(MyColors.primaryColor),
          automaticallyImplyLeading: false,
          title: Text(
            "Offers",
            style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          color: HexColor(MyColors.grey2),
          child: Stack(
            children: [
              Visibility(
                  child: Column(
                    children: [
                      // enterOfferManually(),
                      offerListBuilder(viewAllOffersProvider),
                    ],
                  )),
              Visibility(
                  visible: viewAllOffersProvider.isloading,
                  child: CommonWidgets.buildCircularProgressIndicatorWidget()),
              Visibility(
                  visible: checkData(viewAllOffersProvider),
                  child: CommonMethods.noOffer(context)
              )
            ],
          ),
        ),
      );
    });


  }

  Widget offerListBuilder(ViewAllOffersProvider viewAllOffersProvider) {
    return Expanded(
      child: Column(children: [
        Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: viewAllOffersProvider.offersList.length,
              itemBuilder: (BuildContext context, int index) {
                // var item = placesList[index];
                return offersList(index,viewAllOffersProvider);
              },
            ))
      ]),
    );
  }

  Widget offersList(int index, ViewAllOffersProvider viewAllOffersProvider) {
    return Container(
        color: HexColor(MyColors.white),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 3,bottom: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(AppConstants.OFFER_IMAGE_URL+viewAllOffersProvider.offersResponse.offers![index].couponid.toString()+"_M.png",fit: BoxFit.fill,height: 150,width: MediaQuery.of(context).size.width,),
            // // Text(
            // //   "Get 60% Off uo to ₹ 150",
            // //   style: GoogleFonts.nunito(
            // //     color: HexColor(MyColors.black),
            // //       fontWeight: FontWeight.w500,
            // //       fontSize: 18),
            // // ),
            // Row(
            //   children: [
            //     Text(
            //       "Valid on ticket worth ₹ 200 or more",
            //       style: GoogleFonts.nunito(
            //           color: HexColor(MyColors.black),
            //           fontWeight: FontWeight.w500,
            //           fontSize: 14),
            //     ),
            //     // Padding(
            //     //   padding: EdgeInsets.only(left: 5),
            //     //   child: Text(
            //     //     "View deatils",
            //     //     style: GoogleFonts.poppins(
            //     //         color: HexColor(MyColors.black),
            //     //         fontWeight: FontWeight.w600,
            //     //         fontSize: 15),
            //     //   ),
            //     // )
            //   ],
            // ),
            Container(
              height: 1,
              margin: EdgeInsets.only(top:5,bottom: 10),
              color: HexColor(MyColors.grey2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      viewAllOffersProvider.offersList[index].couponcode!,
                      style: GoogleFonts.nunito(),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor(MyColors.skyBlue)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.pop(context, viewAllOffersProvider.offersList[index].couponcode.toString());
                  //   // Navigator.pushNamed(context, MyRoutes.viewAllOffers);
                  // },
                  child: Text(
                    "",
                    style: GoogleFonts.poppins(
                        color: HexColor(MyColors.skyBlue),
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              margin: EdgeInsets.only(top:10,bottom: 10),
              color: HexColor(MyColors.grey2),
            ),
            Text(
              "You will save ₹"+ viewAllOffersProvider.offersList[index].discountamount.toString()+" with this code ",
              style: GoogleFonts.nunito(
                  color: HexColor(MyColors.skyBlue),
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ],
        )
      // ),
    );
  }

  Widget enterOfferManually() {
    return Container(
      color: HexColor(MyColors.white),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                enableInteractiveSelection: false,
                cursorColor: HexColor(MyColors.primaryColor),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter coupon code',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 22),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HexColor(MyColors.primaryColor))),
                ),
              ),
            ),
          ),
          GestureDetector(
            // onTap: () {
            //
            //   // Navigator.pushNamed(context, MyRoutes.viewAllOffers);
            // },
            child: Text(
              "Copy ",
              style: GoogleFonts.poppins(
                  color: HexColor(MyColors.skyBlue),
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  checkData(ViewAllOffersProvider viewAllOffersProvider) {
    if(viewAllOffersProvider.isloading&&viewAllOffersProvider.offersList.isEmpty){
      return false;
    }else if (viewAllOffersProvider.isloading==false&&viewAllOffersProvider.offersList.isEmpty){
      return true;
    }else{
      return false;
    }
  }

}
