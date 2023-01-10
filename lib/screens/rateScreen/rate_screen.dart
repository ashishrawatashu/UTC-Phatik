import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/arguments/rate_screen_arguments.dart';
import 'package:utc_flutter_app/screens/rateScreen/rate_screen_provider.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {

  var _formKey = GlobalKey<FormState>();
  late RateScreenProvider _rateScreenProvider;
  String serviveTypeName = "";
  String serviceName = "";
  int size = 0;


  @override
  void initState() {
    super.initState();
    _rateScreenProvider = Provider.of<RateScreenProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RateScreenArguments;
    //print(args.ticketNumber);
    _rateScreenProvider.ticketNo = args.ticketNumber;
    serviceName = args.serviceName;
    serviveTypeName = args.serviceTypeName;
    size = args.size;
    return Consumer<RateScreenProvider>(
      builder: (_, rateScreenProvider, __) {
        return Scaffold(
            body: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Column(
                children: [
                  topAppBarSection(),
                  middleSection(rateScreenProvider),
                  submitFeedbackButton(rateScreenProvider)
                ],
              ),
            )
        );
      },
    );
  }

  Widget topAppBarSection() {
    return Container(
      padding: EdgeInsets.only(top: 45, bottom: 10),
      color: HexColor(MyColors.primaryColor),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.arrow_back, color: Colors.white)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviveTypeName,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    serviceName,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: HexColor(MyColors.grey3)),
                  ),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }

  middleSection(RateScreenProvider rateScreenProvider) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: Alignment.center,
                    child: Text("Rate Your Experience",
                      style: GoogleFonts.nunito(color: HexColor(MyColors.black),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),)),
                ourServiceSection(
                    1, "Our Service", "Was the Driving comfortable enough ?",
                    "assets/images/steeringwheel.png", rateScreenProvider),
                ourServiceSection(
                    2, "Bus Driver/Conductor", "How was the arrangenmets ?",
                    "assets/images/captain.png", rateScreenProvider),
                ourServiceSection(
                    3, "Booking Portal", "How was the booking procedure ?",
                    "assets/images/slip.png", rateScreenProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }


  starLayout(String star, int sectionNo, int starRating,
      RateScreenProvider rateScreenProvider) {
    return InkWell(
      onTap: () =>
          rateScreenProvider.setVisibilityOfEditText(starRating, sectionNo),
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
            color: rateScreenProvider.setStarRatingBgColor(
                sectionNo, starRating),
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(star,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: rateScreenProvider.setRateColor(sectionNo, starRating),
                  fontWeight: FontWeight.w500),),
            Image.asset(rateScreenProvider.setStarColor(sectionNo, starRating))
          ],
        ),
      ),
    );
  }

  ourServiceSection(int sectionNo, String title, String desc, String imagePath,
      RateScreenProvider rateScreenProvider) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/busblueicon.png", height: 30, width: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(title, style: GoogleFonts.nunito(
                    color: HexColor(MyColors.black),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),),
              )

            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 8),
            child: Row(
              children: [
                Image.asset(imagePath, height: 30, width: 30,),
                Padding(
                  padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                  child: Text(desc, style: GoogleFonts.nunito(
                      color: HexColor(MyColors.black),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),),
                )

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                starLayout("1", sectionNo, 1, rateScreenProvider),
                starLayout("2", sectionNo, 2, rateScreenProvider),
                starLayout("3", sectionNo, 3, rateScreenProvider),
                starLayout("4", sectionNo, 4, rateScreenProvider),
                starLayout("5", sectionNo, 5, rateScreenProvider),
              ],
            ),
          ),
          Visibility(
            visible: rateScreenProvider.getVisibilityOfEditText(sectionNo),
            child: Container(
              height: 80,
              margin: EdgeInsets.only(top: 15, left: 25),
              //fillColor: Colors.green
              child: TextFormField(
                enableInteractiveSelection: false,
                controller: rateScreenProvider.setTextEditingController(sectionNo),
                keyboardType: TextInputType.multiline,
                cursorColor: HexColor(MyColors.primaryColor),
                maxLines: 80 ~/ 20,
                decoration: new InputDecoration(
                  labelText: "Enter your feedback...",
                  floatingLabelStyle: GoogleFonts.nunito(color:  HexColor(MyColors.primaryColor)),
                  fillColor: HexColor(MyColors.primaryColor),focusColor:  HexColor(MyColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: HexColor(MyColors.primaryColor),
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (value) {
                  rateScreenProvider.feedbackValidation(value.toString(), sectionNo);
                  return rateScreenProvider.returnValidation(sectionNo);
                },
                //Normal textInputField will be displayed// when user presses enter it will adapt to it
              ),

            ),
          )
        ],
      ),
    );
  }

  submitFeedbackButton(RateScreenProvider rateScreenProvider) {
    return GestureDetector(
      onTap: () => submitFeedback(rateScreenProvider),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 60,
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: HexColor(MyColors.orange),
          borderRadius: BorderRadius.circular(30),),
        child: Center(
          child: Text("Submit",
            style: GoogleFonts.nunito(
                color: HexColor(MyColors.white),
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),),
        ),
      ),
    );
  }

  submitFeedback(RateScreenProvider rateScreenProvider) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if(!rateScreenProvider.checkStarRatingValidation()){
        if (_formKey.currentState!.validate()) {
          CommonMethods.showLoadingDialog(context);
          await rateScreenProvider.saveRating();
          if(rateScreenProvider.saveResponse.code=="100"){
            // Navigator.pop(context);
            Navigator.pop(context);
            CommonMethods.showSnackBar(context, "Feedback done successfully");
          }else if(rateScreenProvider.saveResponse.code == "999"){
            Navigator.pop(context);
            CommonMethods.showTokenExpireDialog(context);
          }else if(rateScreenProvider.saveResponse.code == "900"){
            Navigator.pop(context);
            CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
          }else {
            Navigator.pop(context);
            CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again");
          }
          // Navigator.popUntil(context, (route) => route.settings.name==MyRoutes.rateScreenList);
          if(size==1){
            Navigator.pushNamed(context, MyRoutes.homeRoute);
          }else{
            Navigator.pop(context);
          }

        }
      }else {
        CommonMethods.showSnackBar(context, "Please rate your experience ! ");
      }

    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

}

