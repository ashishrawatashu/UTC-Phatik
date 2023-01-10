import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/getDashboardData/get_dashboard_data_source.dart';
import 'package:utc_flutter_app/dataSource/getGrievanceCategorie/get_grievance_categorie_data_source.dart';
import 'package:utc_flutter_app/dataSource/saveGrievanceDataSource/save_grievance_data_source.dart';
import 'package:utc_flutter_app/dataSource/savePassengers/save_passengers_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_grievance_category_response.dart';
import 'package:utc_flutter_app/response/get_grievance_sub_category_response.dart';
import 'package:utc_flutter_app/response/grievance_cat_response.dart';
import 'package:utc_flutter_app/response/save_grievance_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class RegisterComplaintScreenProvider extends ChangeNotifier{


  close(){

  }

  List<Result> getGrievanceCategoryList = [];
  List<CategoryList> categoryList = [];
  List<CategoryList> CategoryListAfterRemoveDuplicate = [];
  List<SubCategory> subCategoryList = [];

  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController busNoTextEditingController = TextEditingController();
  TextEditingController pnrNoTextEditingController = TextEditingController();


  var _description;
  get description => _description;

  descriptionValidation (String value){
    if(!value.isEmpty){
      _description = null;
    } else {
      _description = "Please enter your feedback!";
    }
  }

  String isDuringJourney = "";
  bool visibilityOfPnrNumber(){
    if(isDuringJourney=="During Journey"){
      return true;
    }else {
      return false;
    }
  }


  var _pnrNumberValidationError;
  get pnrNumberValidationError => _pnrNumberValidationError;

  pnrNumberValidation (String value){
    if(!value.isEmpty){
      _pnrNumberValidationError = null;
    } else {
      _pnrNumberValidationError = "Please enter PNR number !";
    }
  }

  check(int catId){
    subCategoryList.clear();
    for(int i = 0; i<getGrievanceCategoryList.length;i++){
      if(getGrievanceCategoryList[i].catid==catId){
        SubCategory subCategory = SubCategory();
        subCategory.subcatid = getGrievanceCategoryList[i].subcatid;
        subCategory.subcatname = getGrievanceCategoryList[i].subcatname;
        subCategoryList.add(subCategory);

      }

    }


    // print(subCategoryList.length);

  }

  int selectedCatId = 0;
  var _selectedCat = "Issue Reported";
  get selectedCat => _selectedCat;


  selectCatName(String catName, int catId){
    _selectedCat = catName;
    selectedCatId = catId;
    notifyListeners();
  }


  var _selectedSubCatName = "Want to report upon";
  get selectedSubCatName => _selectedSubCatName;
  int selectedSubCatId = 0 ;
  selectSubCatName(String subCatName, int subCatId){
    _selectedSubCatName = subCatName;
    selectedSubCatId = subCatId;
    notifyListeners();
  }

  changeCatColor(){
    if(_selectedCat=="Issue Reported"){
      return HexColor(MyColors.grey1);
    }else {
      return HexColor(MyColors.black);
    }

  }

  changeSubCatColor(){
    if(_selectedSubCatName=="Want to report upon"){
      return HexColor(MyColors.grey1);
    }else {
      return HexColor(MyColors.black);
    }
  }



  File? pickedImageOne;
  File? pickedImageTwo;
  // late Uint8List imageBytesOne;
  // late Uint8List imageBytesTwo;
  // ByteData? imageOneByteData;
  // ByteData? imageTwoByteData;
  String base64ImagePic1 = "";
  String base64ImagePic2 = "";
  // readFileByte(String filePath, String imageNo) async {
  //   if(imageNo=="1"){
  //     final bytes = File(filePath).readAsBytesSync();
  //     base64ImagePic1 =  base64Encode(bytes);
  //     print("img_pan : $base64ImagePic1");
  //   }else{
  //     final bytes = File(filePath).readAsBytesSync();
  //     base64ImagePic2 =  base64Encode(bytes);
  //     print(base64ImagePic2);
  //   }
  // }

  pickImage(ImageSource imageType, String imageNo) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      if(imageNo=="1"){
        final tempImageOne = File(photo.path);
        pickedImageOne = tempImageOne;
        // readFileByte(pickedImageOne!.path.toString(),imageNo);
        final bytes = File(pickedImageOne!.path.toString()).readAsBytesSync();
        base64ImagePic1 =  base64Encode(bytes);
        // print("img_pan : $base64ImagePic1");
        notifyListeners();
      }else {
        final tempImageTwo = File(photo.path);
        pickedImageTwo = tempImageTwo;
        // readFileByte(pickedImageTwo!.path.toString(),imageNo);
        final bytes = File(pickedImageTwo!.path.toString()).readAsBytesSync();
        base64ImagePic2 =  base64Encode(bytes);
        // print(base64ImagePic2);
        notifyListeners();
      }

    } catch (error) {
      debugPrint(error.toString());
    }
  }


  GetGrievanceCategoryResponse getGrievanceCategoryResponse = GetGrievanceCategoryResponse();
  GetGrievanceCategoryDataSource getGrievanceCategoryDataSource = GetGrievanceCategoryDataSource();
  Future<GetGrievanceCategoryResponse> getGrievanceCategory() async {

    var response = await getGrievanceCategoryDataSource.getGrievanceCategoryApi(AppConstants.USER_MOBILE_NO, AppConstants.MY_TOKEN);
    getGrievanceCategoryResponse = GetGrievanceCategoryResponse.fromJson(response);
    // print(response);
    if(getGrievanceCategoryResponse.code=="100"){
      categoryList.clear();
      getGrievanceCategoryList = getGrievanceCategoryResponse.result!;

      for(int i = 0;i<getGrievanceCategoryList.length;i++){
        CategoryList categoryListdata = CategoryList();
        categoryListdata.catid = getGrievanceCategoryList[i].catid;
        categoryListdata.catname = getGrievanceCategoryList[i].catname;
        categoryList.add(categoryListdata);

      }
      // remove duplicate elements from list
      categoryList.forEach((element) {
        CategoryListAfterRemoveDuplicate.removeWhere((e) => element.catid == e.catid);
        CategoryListAfterRemoveDuplicate.add(element);
      });


    }

    return getGrievanceCategoryResponse;

  }

  SaveGrievanceDataSource saveGrievanceDataSource = SaveGrievanceDataSource();
  SaveGrievanceResponse saveGrievanceResponse = SaveGrievanceResponse();

  Future<SaveGrievanceResponse> saveGrievance() async {
    var response = await saveGrievanceDataSource.saveGrievanceApi(selectedCatId.toString(), selectedSubCatId.toString(), busNoTextEditingController.value.text.toString(), " ",descriptionTextEditingController.value.text.toString(), base64ImagePic1, base64ImagePic2, "1212122", "22222", AppConstants.USER_MOBILE_NO, AppConstants.DEVICE_ID!,AppConstants.MY_TOKEN);
    saveGrievanceResponse = SaveGrievanceResponse.fromJson(response);
    // print(response);
    return saveGrievanceResponse;
  }


  clearAllData(){
    _selectedCat = "Issue Reported";
    _selectedSubCatName = "Want to report upon";

    busNoTextEditingController.clear();
    descriptionTextEditingController.clear();
    pickedImageOne = null;
    pickedImageTwo = null;
    base64ImagePic1 = "";
    base64ImagePic2 = "";
  }

  AuthenticationMethodDataSource authenticationMethodDataSource = AuthenticationMethodDataSource();
  AuthenticationMethodResponse authenticationMethodResponse = AuthenticationMethodResponse();
  Future<AuthenticationMethodResponse> authenticationMethod() async {
    var response = await authenticationMethodDataSource.authenticationMethod(AppConstants.AUTH_USER_ID, AppConstants.AUTH_IMEI);
    // print(response);
    authenticationMethodResponse = AuthenticationMethodResponse.fromJson(response);
    if(authenticationMethodResponse.code=="100"){
      AppConstants.MY_TOKEN = authenticationMethodResponse.result![0].token.toString();
    }
    return authenticationMethodResponse;
  }

}