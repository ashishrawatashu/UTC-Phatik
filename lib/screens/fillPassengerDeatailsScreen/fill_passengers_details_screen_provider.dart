import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/checkConcessionDataSource/check_concession_data_source.dart';
import 'package:utc_flutter_app/dataSource/checkMobileNumber/check_mobile_number_data_source.dart';
import 'package:utc_flutter_app/dataSource/getConcessionTypesDataSource/get_concession_types_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginFail/login_fail_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginFirstTime/login_first_time_data_source.dart';
import 'package:utc_flutter_app/dataSource/loginSuccess/login_success_data_source.dart';
import 'package:utc_flutter_app/dataSource/savePassengers/save_passengers_data_source.dart';
import 'package:utc_flutter_app/response/check_concession_response.dart';
import 'package:utc_flutter_app/response/check_mobile_number_response.dart';
import 'package:utc_flutter_app/response/get_concession_types_response.dart';
import 'package:utc_flutter_app/response/login_first_time_response.dart';
import 'package:utc_flutter_app/response/passenger_information_pojo.dart';
import 'package:utc_flutter_app/response/save_passengers_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class FillPassengersDetailsProvider extends ChangeNotifier {

  String depotServiceCode = "", tripType ="", tripId= "", fromStationId="", toStationId = "", bordeingStationId = "", passengers ="";
  String ticketNumber="";
  String? selectedGenderValue;
  bool isGenderSelected = false;
  bool isContainAnyConcession = false;


  dropDownValue(int index){
    if (passengerList[index].gender=="M"){
      //print("Malefghvjbknlml,");
      return "Male";
    }else if (passengerList[index].gender=="F"){
      return "Female";
    } else if (passengerList[index].gender=="O"){
      return "Other";
    }

  }


  selectGenderFromDropDown(String selectedGenderValue, int index){
    //print(selectedGenderValue.toString()+"bbbb");
    isGenderSelected = true;
    passengerList[index].genderName=selectedGenderValue;
    // //print(selectedGenderValue);
    if(selectedGenderValue=="Male"){
      passengerList[index].gender="M";
    }else if(selectedGenderValue=="Female"){
      passengerList[index].gender="F";
    }else if(selectedGenderValue=="Other") {
      passengerList[index].gender = "O";
    }
    //print(passengerList[index].genderName.toString()+"aaaa");
    notifyListeners();
  }

  //contact information validator
  TextEditingController userEmailTextEditingController = TextEditingController();
  TextEditingController userPhoneTextEditingController = TextEditingController(text: AppConstants.USER_MOBILE_NO);


  var _passengerName;
  get passengerName => _passengerName;

  void passengerNameValidation(String passengerName){
    if (!passengerName.isEmpty) {
      _passengerName = null;
    } else {
      _passengerName = "Invalid name!";
    }
    notifyListeners();
  }

  bool passengerForm = false;

  validatePassengerList(){
    for(int i=0;i<passengerList.length;i++){
      if(passengerList[i].passengerNameTextEditingController.text==null&&passengerList[i].passengerAgeTextEditingController.text==null){
        passengerForm = false;
      }else if(passengerList[i].gender!="G"&&!passengerList[i].passengerNameTextEditingController.text.isEmpty&&!passengerList[i].passengerAgeTextEditingController.text.isEmpty){
        passengerList[i].name = passengerList[i].passengerNameTextEditingController.text.toString();
        passengerList[i].age = passengerList[i].passengerAgeTextEditingController.text.toString();
        if(passengerList[i].gender=="M"){
          passengerList[i].gender = "Male";
        }else if(passengerList[i].gender=="F"){
          passengerList[i].gender = "Female";
        }else if(passengerList[i].gender=="O"){
          passengerList[i].gender = "Other";
        }
        passengerForm = true;
      }else {
        passengerForm = false;
      }
    }
    notifyListeners();
  }

  var _passengerAge;
  get passengerAge => _passengerAge;

  void passengerAgeValidation(String passengerAge){
    if (!passengerAge.isEmpty) {
      _passengerAge = null;
    } else {
      _passengerAge = "Invalid age!";
    }
    notifyListeners();
  }



  var _userPhone;
  get userPhone => _userPhone;

  void userPhoneValidation(String? phone) {
    if (phone!.length==10) {
      _userPhone = null;
    } else {
      _userPhone = "Invalid phone number !";
    }
    notifyListeners();
  }

  var _userEmail;
  get userEmail => _userEmail;

  void userEmailValidation(String? email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email!);
    if (!email.isEmpty) {
      if(!emailValid){
        _userEmail = "Invalid email address !";
      }
    } else {
      _userEmail = null;
    }
    notifyListeners();
  }



  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  String isUserLoggedIn = "";
  String isUserSkipped = "";

  getDataOfSharedPref() async {
    await getIsLoggedIn();
    await getIsSkipped();
  }

  getIsLoggedIn() async{
    await  encryptedSharedPreferences.getString(StringsFile.isLoggedIn).then((String value) {
      isUserLoggedIn = value;/// Prints Hello, World!
    });

  }

  getIsSkipped() {
    encryptedSharedPreferences.getString(StringsFile.isSkipped).then((String value) {
      isUserSkipped = value;/// Prints Hello, World!
    });
  }


  //otp and name validator
  TextEditingController userFullNameTextEditingController = TextEditingController();
  TextEditingController userOtpTextEditingController = TextEditingController();

  var _otpValidate;
  get otpLength => _otpValidate;

  void userOtpValidation(String? user) {
    if (user!.length == 6) {
      _otpValidate = null;
    } else {
      _otpValidate = "Invalid otp";

    }
    notifyListeners();
  }

  var _userName;
  get userName => _userName;

  void userNameValidation(String? user) {
    if (user!.length>1) {
      _userName = null;
    } else {
      _userName = "Enter your full name";
    }
    notifyListeners();
  }



  List<PassengerInformationPojo> passengerList = [];
  String seatsNumbers = "";

  concatSeatsNumber() {

    String totalSeatsCount ="";
    for(int i=0;i<passengerList.length;i++){
      totalSeatsCount = totalSeatsCount+"," + passengerList[i].seatNo.toString();
    }

    if(totalSeatsCount.isEmpty){
      return totalSeatsCount;
    }else {
      return totalSeatsCount.substring(1);
    }

  }

// seatno, name, gender , age , concessionId, fare=0, onlineverficationYN, passno, Id verificationYN, Id verfication , documnetverifucation VN, documentverfication
  concatPassengersListToString(){
    passengers = "";
    for(int i=0;i<passengerList.length;i++){
      if(passengerList.length==1){
        passengers = passengerList[i].seatNo.toString()+","+
            passengerList[i].name.toString()+","+
            passengerList[i].gender.toString()+","+
            passengerList[i].age.toString()+","+"1"+","+tripType+","+",0"+","+"N"+","+" "+","+"N"+","+" "+"N"+","+" ";
      }else {
        passengers = passengerList[i].seatNo.toString()+","+ passengerList[i].name.toString()+","+ passengerList[i].gender.toString()+","+ passengerList[i].age.toString()+","+"1"+","+tripType+","+",0"+","+"N"+","+" "+","+"N"+","+" "+"N"+","+" "+"|"+passengers;
      }
    }
    if(passengerList.length>1){
      passengers = passengers.substring(0,passengers.length-1);
    }

    //print(passengers);

    notifyListeners();

  }



  checkUserGenderChangeBgColor(int index,String type) {

    if(passengerList[index].gender==type){
      return HexColor(MyColors.primaryColor);
    }else if(passengerList[index].gender==type){
      return HexColor(MyColors.primaryColor);
    }else if (passengerList[index].gender==type){
      return HexColor(MyColors.primaryColor);
    }else{
      return HexColor(MyColors.white);

    }

  }


  checkUserGenderChangeIconForMale(int index,String type) {
    if(passengerList[index].gender==type){
      return "assets/images/malefill.png";
    }else {
      return "assets/images/maleicon.png";
    }

  }


  checkUserGenderChangeIconForFeMale(int index,String type) {
    if(passengerList[index].gender==type){
      return "assets/images/femalefill.png";
    }else {
      return "assets/images/femaleicon.png";
    }

  }



  checkUserGenderChangeTextColor(int index,String type) {

    if(passengerList[index].gender==type){
      return HexColor(MyColors.white);
    }else if(passengerList[index].gender==type){
      return HexColor(MyColors.white);
    }else if (passengerList[index].gender==type){
      return HexColor(MyColors.white);
    }else{
      return HexColor(MyColors.primaryColor);
    }


  }

  selectGender(int index,String gender){
    passengerList[index].gender=gender;
    notifyListeners();

  }

  setPassengerName(int index,String name){
    passengerList[index].name=name;
    notifyListeners();

  }



  setPassengerAge(int index,String age){
    passengerList[index].age=age;
    notifyListeners();

  }


  String mobilenumber = "";
  String username = "";
  String already_yn = "";
  String EncryptOTP = "N";
  String MyEncryptOTP = "";
  String login_app_web = "M";
  String ip_imei = AppConstants.DEVICE_ID!;
  bool isLoggedIn = false;


  matchOtp() async {
    if(EncryptOTP==MyEncryptOTP){
      //print("OTP valid");
      if(already_yn=="N"){
        //print("For N");
        await loginFirstTime(userPhoneTextEditingController.text.toString(), userFullNameTextEditingController.text.toString(), login_app_web,ip_imei);
        saveDataToSharedPref("true","false");
      }else {
        //print("For Yyyyy");
        await loginSuccess(userPhoneTextEditingController.text.toString(), login_app_web, ip_imei);
        saveDataToSharedPref("true","false");
        // if(loginSuccessResponse.code=="100"){
        //
        // }else if (loginSuccessResponse.code=="101") {
        //
        // }else {
        //
        // }
      }
      return true;
    }else{
      //print("OTP invalid");
      await loginFail(mobilenumber, login_app_web, ip_imei);
      if(loginSuccessResponse.code=="100"){

      }else if (loginSuccessResponse.code=="101") {

      }else {

      }
      return false;
    }

  }


  saveDataToSharedPref(String isLoggedIn, String isSkipped) async{
    await MemoryManagement.setIsLoggedIn(isLoggedIn: isLoggedIn);
    await MemoryManagement.setUserName(userName: username);
    await MemoryManagement.setIsSkipped(isSkipped: isSkipped);
  }

  //first Time user login APi integration

  LoginResponse loginFirstTimeResponse = LoginResponse();
  LoginFirstTimeDataSource loginFirstTimeDataSource = LoginFirstTimeDataSource();

  Future<LoginResponse> loginFirstTime(String mobileNumber,String userName,String login_app_web, String ip_imei) async{
    var response = await loginFirstTimeDataSource.loginFirstTimeApi(mobileNumber,userName,login_app_web,ip_imei);
    //print(response);
    loginFirstTimeResponse = LoginResponse.fromJson(response);
    username = userFullNameTextEditingController.text.toString();
    //print(userName);
    MemoryManagement.setPhoneNumber(phoneNumber: userPhoneTextEditingController.text.toString());
    MemoryManagement.setUserName(userName: username);
    await getPhoneNumber();
    return loginFirstTimeResponse;

  }
  getPhoneNumber() async {
    await encryptedSharedPreferences
        .getString(StringsFile.phoneNumber)
        .then((String value) {
      //print(value + "PHONE NUMBER GET");
      AppConstants.USER_MOBILE_NO = value;


      /// Prints Hello, World!
    });

    await encryptedSharedPreferences
        .getString(StringsFile.userName)
        .then((String value) {
      //print(value + "USERNAME GET ");
      AppConstants.USER_NAME = value;


      /// Prints Hello, World!
    });
  }

  // login Success Api integration
  LoginResponse loginSuccessResponse = LoginResponse();
  LoginSuccessDataSource loginSuccessDataSource = LoginSuccessDataSource();

  Future<LoginResponse> loginSuccess(String mobileNumber,String login_app_web, String ip_imei) async{
    var response = await loginSuccessDataSource.loginSuccessApi(mobileNumber,login_app_web,ip_imei);
    //print(response);
    loginSuccessResponse = LoginResponse.fromJson(response);

    if(loginSuccessResponse.code=="100"){
      //print(userPhoneTextEditingController.text.toString()+"PHONEEEEE");
      MemoryManagement.setPhoneNumber(phoneNumber: userPhoneTextEditingController.text.toString());
      MemoryManagement.setPhoneNumber(phoneNumber: username);
      await getPhoneNumber();
    }

    return loginSuccessResponse;

  }

  //login fail Api integration
  LoginResponse loginFailTimeResponse = LoginResponse();
  LoginFailDataSource loginFailDataSource = LoginFailDataSource();

  Future<LoginResponse> loginFail(String mobileNumber,String login_app_web, String ip_imei) async{
    var response = await loginFailDataSource.loginFailApi(mobileNumber,login_app_web,ip_imei);
    //print(response);
    loginFailTimeResponse = LoginResponse.fromJson(response);
    return loginFailTimeResponse;

  }

  //check phone number
  CheckMobileNumberResponse checkMobileNumberResponse = CheckMobileNumberResponse();
  CheckMobileNumberDataSource checkMobileNumberDataSource = CheckMobileNumberDataSource();

  Future<CheckMobileNumberResponse> checkMobileNumber(String mobileNumber) async{
    var response = await checkMobileNumberDataSource.checkMobileNumberApi(mobileNumber);
    //print(response);
    checkMobileNumberResponse = CheckMobileNumberResponse.fromJson(response);
    if(checkMobileNumberResponse.code=="100") {
      already_yn = checkMobileNumberResponse.traveller![0].alreadyYn!;
      EncryptOTP = checkMobileNumberResponse.traveller![0].encryptOTP!;
      username = checkMobileNumberResponse.traveller![0].username!;
    }
    return checkMobileNumberResponse;

  }


  //save passengers
  SavePassengersResponse savePassengersResponse = SavePassengersResponse();
  SavePassengersDataSource savePassengersDataSource = SavePassengersDataSource();

  Future<SavePassengersResponse> savePassengers() async{
    var response = await savePassengersDataSource.savePassengersApi(depotServiceCode, tripType, tripId, AppConstants.JOURNEY_DATE, fromStationId, toStationId, "T", AppConstants.USER_MOBILE_NO, AppConstants.USER_MOBILE_NO, userEmailTextEditingController.text.toString(), bordeingStationId, passengers, ip_imei,AppConstants.MY_TOKEN);
    //print(response);
    savePassengersResponse = SavePassengersResponse.fromJson(response);
    if(savePassengersResponse.code=="100"){
      ticketNumber = savePassengersResponse.result![0].pTicketnumber.toString();
      //print(ticketNumber);
    }

    return savePassengersResponse;

  }


  //get Concession
  GetConcessionTypesResponse getConcessionTypesResponse = GetConcessionTypesResponse();
  GetConcessionTypesDataSource getConcessionTypesDataSource = GetConcessionTypesDataSource();
  List<ConcessionList> concessionList = [];

  Future<GetConcessionTypesResponse> getConcessionTypes(String dsvcid, String fromstationId ,String tostationId, BuildContext context) async{
    var response = await getConcessionTypesDataSource.getConcessionTypes(dsvcid, fromstationId, tostationId, AppConstants.MY_TOKEN);
    print(response);
    getConcessionTypesResponse = GetConcessionTypesResponse.fromJson(response);
    if(getConcessionTypesResponse.code=="100"){
      concessionList = getConcessionTypesResponse.concession!;
      setConcessionInPassengersList(concessionList);
      //print(concessionList);
    }else if(getConcessionTypesResponse.code=="999"){
      CommonMethods.showTokenExpireDialog(context);
    }else if(getConcessionTypesResponse.code=="900"){
      CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
    }

    return getConcessionTypesResponse;

  }


  // CheckConcessionResponse
  CheckConcessionResponse checkConcessionResponse = CheckConcessionResponse();
  CheckConcessionDataSource checkConcessionDataSource = CheckConcessionDataSource();


  Future<CheckConcessionResponse> checkConcession(String concession, String gender ,String age) async{
    var response = await checkConcessionDataSource.checkConcessionApi(concession, gender, age, AppConstants.MY_TOKEN);
    print(response);
    checkConcessionResponse = CheckConcessionResponse.fromJson(response);
    if(checkConcessionResponse.code=="100"){
      //print(checkConcessionResponse.concession.toString());
    }

    return checkConcessionResponse;

  }




  var _passengerName1;

  get passengerName1 => _passengerName1;

  void uservalidation(String? user,int index) {
    if (user!.isEmpty) {
      _passengerName1 = "Invalid name !";
      notifyListeners();
    } else {
      _passengerName1 = null;
      notifyListeners();
    }
  }

  var _age1;

  get age1 => _age1;

  void agevalidation(String? user,int index) {
    if (user!.isEmpty) {
      _age1 = "Invalid age !";
      notifyListeners();
    } else {
      _age1 = null;
      notifyListeners();
    }
  }


  selectConsessionFromDropDown(String concessionName, int index){
    passengerList[index].concessionName=concessionName;
    if(concessionName==concessionList[0].categoryname){
      isContainAnyConcession = false;
      passengerList[index].pgenderresult="N";
      passengerList[index].pageresult="N";
      passengerList[index].sponlineverificationyn="N";
      passengerList[index].spidverificationyn="N";
      passengerList[index].spidverification="N";
      passengerList[index].spdocumentverificationyn="N";
      passengerList[index].spdocumentverification="N";
      passengerList[index].spconcessionname=concessionName;
    }else {
      isContainAnyConcession = true;
    }
    notifyListeners();
  }

  bool validation = false;
   checkPassengerValidation(String concessionName, String age , String gender, int index,BuildContext context) async {
     validation = false;
     String concessionID = "";
     for(int i=0;i<concessionList.length;i++){
       if(concessionName==concessionList[i].categoryname.toString()){
         concessionID = concessionList[i].categorycode.toString();
      }
    }
     if(concessionID=="0"){

    }
     else {
      if(passengerList[index].name?.trim().length==0){
        CommonMethods.showSnackBar(context, "Please enter name");
      }else if(passengerList[index].gender.toString()=="G"){
          CommonMethods.showSnackBar(context, "Please select gender");
        }else {
        if(passengerList[index].passengerAgeTextEditingController.text.toString().isEmpty){
          CommonMethods.showLoadingDialog(context);
          await checkConcession(concessionID, passengerList[index].gender.toString(), "0");
          Navigator.pop(context);
        }else {
          CommonMethods.showLoadingDialog(context);
          await checkConcession(concessionID, passengerList[index].gender.toString(), passengerList[index].passengerAgeTextEditingController.text.toString());
          Navigator.pop(context);
        }
          if(await checkConcessionResponse.code=="100"){
            if(checkConcessionResponse.concession![0].pgenderresult!="Success"){
              CommonMethods.showSnackBar(context, checkConcessionResponse.concession![0].pgenderresult.toString());
              validation = false;
            }if(checkConcessionResponse.concession![0].pageresult!="Success"){
              passengerList[index].passengerAgeTextEditingController.clear();
              CommonMethods.showSnackBar(context, checkConcessionResponse.concession![0].pageresult.toString());
              validation = false;
            }
            if(checkConcessionResponse.concession![0].pgenderresult=="Success"&&checkConcessionResponse.concession![0].pageresult=="Success"){
              validation = true;
              passengerList[index].pgenderresult=checkConcessionResponse.concession![0].pgenderresult;
              passengerList[index].pageresult=checkConcessionResponse.concession![0].pageresult;
              passengerList[index].sponlineverificationyn=checkConcessionResponse.concession![0].sponlineverificationyn;
              passengerList[index].spidverificationyn=checkConcessionResponse.concession![0].spidverificationyn;
              passengerList[index].spidverification=checkConcessionResponse.concession![0].spidverification;
              passengerList[index].spdocumentverificationyn=checkConcessionResponse.concession![0].spdocumentverificationyn;
              passengerList[index].spdocumentverification=checkConcessionResponse.concession![0].spdocumentverification;
              passengerList[index].spconcessionname=checkConcessionResponse.concession![0].spconcessionname;
              passengerList[index].concessionId=concessionID;
            }else {
              validation = false;
              selectConsessionFromDropDown(concessionList[0].categoryname.toString(), index);
            }
          }else  if(await checkConcessionResponse.code=="999"){
            CommonMethods.showTokenExpireDialog(context);
          }else{
            CommonMethods.showErrorMoveToDashBaordDialog(context,"Something went wrong, please try again");
          }
        }
    }
  }

  setConcessionInPassengersList(List<ConcessionList> concessionList) {
     print(concessionList[0].categoryname);
     for(int index = 0;index< passengerList.length;index++) {
       isContainAnyConcession = false;
       passengerList[index].pgenderresult="N";
       passengerList[index].pageresult="N";
       passengerList[index].sponlineverificationyn="N";
       passengerList[index].spidverificationyn="N";
       passengerList[index].spidverification="N";
       passengerList[index].spdocumentverificationyn="N";
       passengerList[index].spdocumentverification="N";
       passengerList[index].concessionName=concessionList[0].categoryname;
       passengerList[index].spconcessionname=concessionList[0].categoryname;

     }
     notifyListeners();
  }

}