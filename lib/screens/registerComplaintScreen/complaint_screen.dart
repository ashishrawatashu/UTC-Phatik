import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/screens/registerComplaintScreen/complaint_screen_provider.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

class RegisterComplaintScreen extends StatefulWidget {
  const RegisterComplaintScreen({Key? key}) : super(key: key);

  @override
  _RegisterComplaintScreenState createState() =>
      _RegisterComplaintScreenState();
}

class _RegisterComplaintScreenState extends State<RegisterComplaintScreen> {
  late RegisterComplaintScreenProvider _registerComplaintScreenProvider;
  var _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _registerComplaintScreenProvider.close();
    super.dispose();

  }
  @override
  void initState() {
    _registerComplaintScreenProvider = Provider.of<RegisterComplaintScreenProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      _registerComplaintScreenProvider.clearAllData();
      await _registerComplaintScreenProvider.authenticationMethod();
      await _registerComplaintScreenProvider.getGrievanceCategory();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterComplaintScreenProvider>(
        builder: (_, registerComplaintScreenProvider, __) {
          return Scaffold(
            endDrawerEnableOpenDragGesture: true,
            endDrawer: NavigationDrawer(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, MyRoutes.homeRoute),
              ),
              backgroundColor: HexColor(MyColors.primaryColor),
              automaticallyImplyLeading: true,
              title: Text(
                "Register Complaint",
                style:
                GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                "Issue Reported",
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showCategoryBottomSheet();
                              },
                              child: Container(
                                height: 45,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      registerComplaintScreenProvider
                                          .selectedCat,
                                      style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: registerComplaintScreenProvider
                                              .changeCatColor()),
                                    ),
                                    Image.asset(
                                      "assets/images/downarrow.png",
                                      height: 30,
                                      width: 30,
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(color: HexColor(MyColors.grey1)),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Want to report upon",
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showSubCategoryBottomSheet();
                              },
                              child: Container(
                                height: 45,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      registerComplaintScreenProvider
                                          .selectedSubCatName,
                                      style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: registerComplaintScreenProvider
                                              .changeSubCatColor()),
                                    ),
                                    Image.asset(
                                      "assets/images/downarrow.png",
                                      height: 30,
                                      width: 30,
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(color: HexColor(MyColors.grey1)),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            Visibility(
                              visible: registerComplaintScreenProvider.visibilityOfPnrNumber(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "PNR Number",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: TextFormField(
                                        enableInteractiveSelection: false,
                                        controller: registerComplaintScreenProvider.pnrNoTextEditingController,
                                        cursorColor: HexColor(MyColors.primaryColor),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                                          LengthLimitingTextInputFormatter(11),
                                        ],
                                        decoration: new InputDecoration(
                                          hintText: "PNR Number",
                                          floatingLabelStyle: GoogleFonts.nunito(
                                              color: HexColor(MyColors.primaryColor)),
                                          fillColor: HexColor(MyColors.primaryColor),
                                          focusColor: HexColor(MyColors.primaryColor),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: HexColor(MyColors.primaryColor),
                                            ),
                                          ),
                                          //fillColor: Colors.green
                                        ),
                                        validator: (value) {
                                          registerComplaintScreenProvider.pnrNumberValidation(value.toString());
                                          return registerComplaintScreenProvider.pnrNumberValidationError;
                                        }
                                      //Normal textInputField will be displayed// when user presses enter it will adapt to it
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Bus Number(Optional)",
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                controller: registerComplaintScreenProvider.busNoTextEditingController,
                                cursorColor: HexColor(MyColors.primaryColor),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 -]')),
                                  LengthLimitingTextInputFormatter(11),
                                ],
                                decoration: new InputDecoration(
                                  hintText: "Bus Number",
                                  floatingLabelStyle: GoogleFonts.nunito(
                                      color: HexColor(MyColors.primaryColor)),
                                  fillColor: HexColor(MyColors.primaryColor),
                                  focusColor: HexColor(MyColors.primaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: HexColor(MyColors.primaryColor),
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {},
                                //Normal textInputField will be displayed// when user presses enter it will adapt to it
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Description",
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextFormField(
                                enableInteractiveSelection: false,
                                controller: registerComplaintScreenProvider
                                    .descriptionTextEditingController,
                                keyboardType: TextInputType.multiline,
                                cursorColor: HexColor(MyColors.primaryColor),
                                maxLines: 80 ~/ 20,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9. ?,]')),
                                ],
                                decoration: new InputDecoration(
                                  hintText: "Maximum 200 character",
                                  floatingLabelStyle: GoogleFonts.nunito(
                                      color: HexColor(MyColors.primaryColor)),
                                  fillColor: HexColor(MyColors.primaryColor),
                                  focusColor: HexColor(MyColors.primaryColor),
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
                                  registerComplaintScreenProvider
                                      .descriptionValidation(value.toString());
                                  return registerComplaintScreenProvider
                                  .description;
                                }
                              //Normal textInputField will be displayed// when user presses enter it will adapt to it
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "If you have any picture of the event, please upload.",
                                style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                            imageNoOne("1"),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              height: 1,
                              color: HexColor(MyColors.grey2),
                            ),
                            imageNoOne("2")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    submitComplaint(registerComplaintScreenProvider);
                  },
                  child: Container(
                    margin:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 25),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: HexColor(MyColors.orange),
                        borderRadius: BorderRadius.circular(30)),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 50,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "SUBMIT",
                            style: GoogleFonts.roboto(
                                color: HexColor(MyColors.white),
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  imageNoOne(String imageNo) {
    return Consumer<RegisterComplaintScreenProvider>(
        builder: (_, registerComplaintScreenProvider, __) {
          return GestureDetector(
            onTap: () {
              // registerComplaintScreenProvider.pickImage(ImageSource.gallery, imageNo);
              showImagePickerBottomSheet(imageNo);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    checkCondition(imageNo, registerComplaintScreenProvider),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Choose image",
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: HexColor(MyColors.grey6)),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/images/camera.png",
                  height: 30,
                  width: 30,
                )
              ],
            ),
          );
        });
  }

  showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),
      builder: (BuildContext context) {
        return Consumer<RegisterComplaintScreenProvider>(
            builder: (_, registerComplaintScreenProvider, __) {
              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                padding: EdgeInsets.only(top: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        alignment: Alignment.center,
                        child: Text(
                          "Issue Reported",
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: HexColor(MyColors.black)),
                        ),
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.only(top: 3, bottom: 2),
                        color: HexColor(MyColors.primaryColor),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: registerComplaintScreenProvider
                            .CategoryListAfterRemoveDuplicate.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              registerComplaintScreenProvider.check(registerComplaintScreenProvider.CategoryListAfterRemoveDuplicate[index].catid!);
                              registerComplaintScreenProvider.selectCatName(registerComplaintScreenProvider.CategoryListAfterRemoveDuplicate[index].catname!, registerComplaintScreenProvider.CategoryListAfterRemoveDuplicate[index].catid!);
                              registerComplaintScreenProvider.isDuringJourney =  registerComplaintScreenProvider.CategoryListAfterRemoveDuplicate[index].catname!;
                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  alignment: Alignment.centerLeft,
                                  margin:
                                  EdgeInsets.only(top: 3, bottom: 2, left: 10),
                                  child: Text(
                                    registerComplaintScreenProvider
                                        .CategoryListAfterRemoveDuplicate[index]
                                        .catname!,
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        color: HexColor(MyColors.black),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2, bottom: 2),
                                  height: 2,
                                  color: HexColor(MyColors.grey2),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  showSubCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),
      builder: (BuildContext context) {
        return Consumer<RegisterComplaintScreenProvider>(
            builder: (_, registerComplaintScreenProvider, __) {
              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.6,
                padding: EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        alignment: Alignment.center,
                        child: Text(
                          "Want to report upon",
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: HexColor(MyColors.black)),
                        ),
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.only(top: 3, bottom: 2),
                        color: HexColor(MyColors.primaryColor),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount:
                        registerComplaintScreenProvider.subCategoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              registerComplaintScreenProvider.selectSubCatName(
                                  registerComplaintScreenProvider
                                      .subCategoryList[index].subcatname!,
                                  registerComplaintScreenProvider
                                      .subCategoryList[index].subcatid!);
                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  alignment: Alignment.centerLeft,
                                  margin:
                                  EdgeInsets.only(top: 3, bottom: 2, left: 10),
                                  child: Text(
                                    registerComplaintScreenProvider
                                        .subCategoryList[index].subcatname!,
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        color: HexColor(MyColors.black),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2, bottom: 2),
                                  height: 2,
                                  color: HexColor(MyColors.grey2),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  checkCondition(String imageNo, RegisterComplaintScreenProvider registerComplaintScreenProvider) {
    if (imageNo == "1") {
      return ClipOval(
          child: registerComplaintScreenProvider.pickedImageOne != null
              ? Image.file(
            registerComplaintScreenProvider.pickedImageOne!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
              : Icon(Icons.image,size: 50,color: HexColor(MyColors.grey1),));
    } else {
      return ClipOval(
          child: registerComplaintScreenProvider.pickedImageTwo != null
              ? Image.file(
            registerComplaintScreenProvider.pickedImageTwo!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
              : Icon(Icons.image,size: 50,color: HexColor(MyColors.grey1),));
    }
  }

  void submitComplaint(RegisterComplaintScreenProvider registerComplaintScreenProvider) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      if (_formKey.currentState!.validate()) {
          await registerComplaintScreenProvider.saveGrievance();
          if(registerComplaintScreenProvider.saveGrievanceResponse.code=="100"){
            Navigator.pop(context);
            CommonMethods.dialogDone(context, "Feedback send successfully ");
          }else if(registerComplaintScreenProvider.saveGrievanceResponse.code=="999"){
            Navigator.pop(context);
            CommonMethods.showTokenExpireDialog(context);
          }else if(registerComplaintScreenProvider.saveGrievanceResponse.code=="900"){
            Navigator.pop(context);
            CommonMethods.showErrorDialog(context,"Something went wrong, please try again");
          }else {
            Navigator.pop(context);
            CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
          }


        }
      }
     else {
      CommonMethods.showNoInternetDialog(context);
    }
  }



  showImagePickerBottomSheet(String imageNo) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),
      builder: (BuildContext context) {
        return Consumer<RegisterComplaintScreenProvider>(builder: (_, registerComplaintScreenProvider, __) {
              return Container(
                height:150,
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  
                  child: Column(
                    children: [
                      Text("Choose option",style: GoogleFonts.nunito(fontSize: 18,color: Colors.black),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: InkWell(
                            onTap: (){
                              registerComplaintScreenProvider.pickImage(ImageSource.gallery, imageNo);
                              Navigator.pop(context);
                            },
                              child: Column(
                                children: [
                                  Icon(Icons.photo,size: 80,color: HexColor(MyColors.primaryColor),),
                                  Text("Gallery")
                                ],
                              ))),
                          Expanded(child: InkWell(
                              onTap: (){
                                registerComplaintScreenProvider.pickImage(ImageSource.camera, imageNo);
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.camera_alt_rounded,size: 80,color: HexColor(MyColors.primaryColor),),
                                  Text("Camera")
                                ],
                              ))),
                        ],
                      )
                    ],
                  ),
                  
                ),
              );
            });
      },
    );
  }


}

