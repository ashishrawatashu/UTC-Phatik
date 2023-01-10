class GetDashboardResponse {
  GetDashboardResponse({
      this.code, 
      this.serviceTypes, 
      this.helpdek, 
      this.wallet, 
      this.offerCount, 
      this.offers, 
      this.advanceDays, 
      this.msg,});

  GetDashboardResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['ServiceTypes'] != null) {
      serviceTypes = [];
      json['ServiceTypes'].forEach((v) {
        serviceTypes?.add(ServiceTypes.fromJson(v));
      });
    }
    if (json['Helpdek'] != null) {
      helpdek = [];
      json['Helpdek'].forEach((v) {
        helpdek?.add(Helpdek.fromJson(v));
      });
    }
    if (json['Wallet'] != null) {
      wallet = [];
      json['Wallet'].forEach((v) {
        wallet?.add(Wallet.fromJson(v));
      });
    }
    if (json['OfferCount'] != null) {
      offerCount = [];
      json['OfferCount'].forEach((v) {
        offerCount?.add(OfferCount.fromJson(v));
      });
    }
    if (json['Offers'] != null) {
      offers = [];
      json['Offers'].forEach((v) {
        offers?.add(Offers.fromJson(v));
      });
    }
    if (json['AdvanceDays'] != null) {
      advanceDays = [];
      json['AdvanceDays'].forEach((v) {
        advanceDays?.add(AdvanceDays.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<ServiceTypes>? serviceTypes;
  List<Helpdek>? helpdek;
  List<Wallet>? wallet;
  List<OfferCount>? offerCount;
  List<Offers>? offers;
  List<AdvanceDays>? advanceDays;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (serviceTypes != null) {
      map['ServiceTypes'] = serviceTypes?.map((v) => v.toJson()).toList();
    }
    if (helpdek != null) {
      map['Helpdek'] = helpdek?.map((v) => v.toJson()).toList();
    }
    if (wallet != null) {
      map['Wallet'] = wallet?.map((v) => v.toJson()).toList();
    }
    if (offerCount != null) {
      map['OfferCount'] = offerCount?.map((v) => v.toJson()).toList();
    }
    if (offers != null) {
      map['Offers'] = offers?.map((v) => v.toJson()).toList();
    }
    if (advanceDays != null) {
      map['AdvanceDays'] = advanceDays?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class AdvanceDays {
  AdvanceDays({
      this.days, 
      this.status, 
      this.actionlogid, 
      this.updatedby, 
      this.updationdatetime,});

  AdvanceDays.fromJson(dynamic json) {
    days = json['DAYS'];
    status = json['STATUS'];
    actionlogid = json['ACTIONLOGID'];
    updatedby = json['UPDATEDBY'];
    updationdatetime = json['UPDATIONDATETIME'];
  }
  int? days;
  String? status;
  int? actionlogid;
  String? updatedby;
  String? updationdatetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DAYS'] = days;
    map['STATUS'] = status;
    map['ACTIONLOGID'] = actionlogid;
    map['UPDATEDBY'] = updatedby;
    map['UPDATIONDATETIME'] = updationdatetime;
    return map;
  }

}

class Offers {
  Offers({
      this.couponid, 
      this.couponcode, 
      this.coupontitle, 
      this.discountdescription, 
      this.discounttype, 
      this.discounton, 
      this.discountamount, 
      this.maxdiscountamount, 
      this.validfromdate, 
      this.validtodate,});

  Offers.fromJson(dynamic json) {
    couponid = json['COUPON_ID'];
    couponcode = json['COUPON_CODE'];
    coupontitle = json['COUPON_TITLE'];
    discountdescription = json['DISCOUNT_DESCRIPTION'];
    discounttype = json['DISCOUNT_TYPE'];
    discounton = json['DISCOUNT_ON'];
    discountamount = json['DISCOUNT_AMOUNT'];
    maxdiscountamount = json['MAX_DISCOUNT_AMOUNT'];
    validfromdate = json['VALID_FROM_DATE'];
    validtodate = json['VALID_TO_DATE'];
  }
  int? couponid;
  String? couponcode;
  String? coupontitle;
  String? discountdescription;
  String? discounttype;
  String? discounton;
  int? discountamount;
  int? maxdiscountamount;
  String? validfromdate;
  String? validtodate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['COUPON_ID'] = couponid;
    map['COUPON_CODE'] = couponcode;
    map['COUPON_TITLE'] = coupontitle;
    map['DISCOUNT_DESCRIPTION'] = discountdescription;
    map['DISCOUNT_TYPE'] = discounttype;
    map['DISCOUNT_ON'] = discounton;
    map['DISCOUNT_AMOUNT'] = discountamount;
    map['MAX_DISCOUNT_AMOUNT'] = maxdiscountamount;
    map['VALID_FROM_DATE'] = validfromdate;
    map['VALID_TO_DATE'] = validtodate;
    return map;
  }

}

class OfferCount {
  OfferCount({
      this.offercount,});

  OfferCount.fromJson(dynamic json) {
    offercount = json['OFFERCOUNT'];
  }
  int? offercount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OFFERCOUNT'] = offercount;
    return map;
  }

}

class Wallet {
  Wallet({
      this.userid, 
      this.openingdate, 
      this.currentbalanceamount, 
      this.ddate,});

  Wallet.fromJson(dynamic json) {
    userid = json['USERID'];
    openingdate = json['OPENINGDATE'];
    currentbalanceamount = json['CURRENTBALANCEAMOUNT'];
    ddate = json['DDATE'];
  }
  String? userid;
  String? openingdate;
  int? currentbalanceamount;
  String? ddate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USERID'] = userid;
    map['OPENINGDATE'] = openingdate;
    map['CURRENTBALANCEAMOUNT'] = currentbalanceamount;
    map['DDATE'] = ddate;
    return map;
  }

}

class Helpdek {
  Helpdek({
      this.mobileNo, 
      this.emailId,});

  Helpdek.fromJson(dynamic json) {
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
  }
  String? mobileNo;
  String? emailId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileNo'] = mobileNo;
    map['emailId'] = emailId;
    return map;
  }

}

class ServiceTypes {
  ServiceTypes({
      this.srtpid, 
      this.servicecode, 
      this.servicetypenameen, 
      this.servicetypenamehi, 
      this.acschargepkm, 
      this.slschargeps, 
      this.heatschargepkm, 
      this.speedhillkmh, 
      this.speedplainkmh, 
      this.createby, 
      this.createdt, 
      this.updateby, 
      this.updatedt, 
      this.status, 
      this.mcstatus, 
      this.datelastupdt, 
      this.activeflag, 
      this.adultmax, 
      this.childmax, 
      this.luggagerate, 
      this.luggmulunit, 
      this.luggwithpsngr, 
      this.incentivedriver, 
      this.incentiveconductor, 
      this.servicetax,});

  ServiceTypes.fromJson(dynamic json) {
    srtpid = json['SRTP_ID'];
    servicecode = json['SERVICE_CODE'];
    servicetypenameen = json['SERVICE_TYPE_NAME_EN'];
    servicetypenamehi = json['SERVICE_TYPE_NAME_HI'];
    acschargepkm = json['AC_SCHARGE_PKM'];
    slschargeps = json['SL_SCHARGE_PS'];
    heatschargepkm = json['HEAT_SCHARGE_PKM'];
    speedhillkmh = json['SPEED_HILL_KMH'];
    speedplainkmh = json['SPEED_PLAIN_KMH'];
    createby = json['CREATE_BY'];
    createdt = json['CREATE_DT'];
    updateby = json['UPDATE_BY'];
    updatedt = json['UPDATE_DT'];
    status = json['STATUS'];
    mcstatus = json['MC_STATUS'];
    datelastupdt = json['DATELASTUPDT'];
    activeflag = json['ACTIVE_FLAG'];
    adultmax = json['ADULT_MAX'];
    childmax = json['CHILD_MAX'];
    luggagerate = json['LUGGAGE_RATE'];
    luggmulunit = json['LUGG_MUL_UNIT'];
    luggwithpsngr = json['LUGG_WITH_PSNGR'];
    incentivedriver = json['INCENTIVE_DRIVER'];
    incentiveconductor = json['INCENTIVE_CONDUCTOR'];
    servicetax = json['SERVICE_TAX'];
  }
  String? srtpid;
  int? servicecode;
  String? servicetypenameen;
  dynamic servicetypenamehi;
  int? acschargepkm;
  int? slschargeps;
  int? heatschargepkm;
  int? speedhillkmh;
  int? speedplainkmh;
  String? createby;
  String? createdt;
  String? updateby;
  String? updatedt;
  String? status;
  dynamic mcstatus;
  dynamic datelastupdt;
  String? activeflag;
  int? adultmax;
  int? childmax;
  dynamic? luggagerate;
  int? luggmulunit;
  String? luggwithpsngr;
  int? incentivedriver;
  int? incentiveconductor;
  int? servicetax;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SRTP_ID'] = srtpid;
    map['SERVICE_CODE'] = servicecode;
    map['SERVICE_TYPE_NAME_EN'] = servicetypenameen;
    map['SERVICE_TYPE_NAME_HI'] = servicetypenamehi;
    map['AC_SCHARGE_PKM'] = acschargepkm;
    map['SL_SCHARGE_PS'] = slschargeps;
    map['HEAT_SCHARGE_PKM'] = heatschargepkm;
    map['SPEED_HILL_KMH'] = speedhillkmh;
    map['SPEED_PLAIN_KMH'] = speedplainkmh;
    map['CREATE_BY'] = createby;
    map['CREATE_DT'] = createdt;
    map['UPDATE_BY'] = updateby;
    map['UPDATE_DT'] = updatedt;
    map['STATUS'] = status;
    map['MC_STATUS'] = mcstatus;
    map['DATELASTUPDT'] = datelastupdt;
    map['ACTIVE_FLAG'] = activeflag;
    map['ADULT_MAX'] = adultmax;
    map['CHILD_MAX'] = childmax;
    map['LUGGAGE_RATE'] = luggagerate;
    map['LUGG_MUL_UNIT'] = luggmulunit;
    map['LUGG_WITH_PSNGR'] = luggwithpsngr;
    map['INCENTIVE_DRIVER'] = incentivedriver;
    map['INCENTIVE_CONDUCTOR'] = incentiveconductor;
    map['SERVICE_TAX'] = servicetax;
    return map;
  }

}