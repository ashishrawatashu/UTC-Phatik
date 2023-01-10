import 'package:flutter/cupertino.dart';

class PassengerInformationPojo {
  String? seatNo;
  String? gender;
  String? name = "";
  String? age;
  String? onlyMale;
  String? genderName;
  String? concessionName;
  String? concessionId;

  String? checkBusPassStatus;
  bool? idPassValid;

  String? pgenderresult;
  String? pageresult;
  String? sponlineverificationyn;
  String? spidverificationyn;
  dynamic spidverification;
  String? spdocumentverificationyn;
  dynamic spdocumentverification;
  String? spconcessionname;


  var formKey = GlobalKey<FormState>();
  var bussPassKey = GlobalKey<FormState>();
  TextEditingController passengerNameTextEditingController = TextEditingController();
  TextEditingController passengerAgeTextEditingController = TextEditingController();
  TextEditingController passengerPassNoTextEditingController = TextEditingController();
  TextEditingController passengerIdNoTextEditingController = TextEditingController();


}