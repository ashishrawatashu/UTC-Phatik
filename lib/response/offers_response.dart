class OffersResponse {
  OffersResponse({
      String? code, 
      List<Offers>? offers, 
      String? msg,}){
    _code = code;
    _offers = offers;
    _msg = msg;
}

  OffersResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['Offers'] != null) {
      _offers = [];
      json['Offers'].forEach((v) {
        _offers?.add(Offers.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<Offers>? _offers;
  String? _msg;

  String? get code => _code;
  List<Offers>? get offers => _offers;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_offers != null) {
      map['Offers'] = _offers?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

class Offers {
  Offers({
      int? couponid, 
      String? couponcode, 
      String? coupontitle, 
      String? discountdescription, 
      String? discounttype, 
      String? discounton, 
      int? discountamount, 
      int? maxdiscountamount, 
      String? validfromdate, 
      String? validtodate,}){
    _couponid = couponid;
    _couponcode = couponcode;
    _coupontitle = coupontitle;
    _discountdescription = discountdescription;
    _discounttype = discounttype;
    _discounton = discounton;
    _discountamount = discountamount;
    _maxdiscountamount = maxdiscountamount;
    _validfromdate = validfromdate;
    _validtodate = validtodate;
}

  Offers.fromJson(dynamic json) {
    _couponid = json['COUPON_ID'];
    _couponcode = json['COUPON_CODE'];
    _coupontitle = json['COUPON_TITLE'];
    _discountdescription = json['DISCOUNT_DESCRIPTION'];
    _discounttype = json['DISCOUNT_TYPE'];
    _discounton = json['DISCOUNT_ON'];
    _discountamount = json['DISCOUNT_AMOUNT'];
    _maxdiscountamount = json['MAX_DISCOUNT_AMOUNT'];
    _validfromdate = json['VALID_FROM_DATE'];
    _validtodate = json['VALID_TO_DATE'];
  }
  int? _couponid;
  String? _couponcode;
  String? _coupontitle;
  String? _discountdescription;
  String? _discounttype;
  String? _discounton;
  int? _discountamount;
  int? _maxdiscountamount;
  String? _validfromdate;
  String? _validtodate;

  int? get couponid => _couponid;
  String? get couponcode => _couponcode;
  String? get coupontitle => _coupontitle;
  String? get discountdescription => _discountdescription;
  String? get discounttype => _discounttype;
  String? get discounton => _discounton;
  int? get discountamount => _discountamount;
  int? get maxdiscountamount => _maxdiscountamount;
  String? get validfromdate => _validfromdate;
  String? get validtodate => _validtodate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['COUPON_ID'] = _couponid;
    map['COUPON_CODE'] = _couponcode;
    map['COUPON_TITLE'] = _coupontitle;
    map['DISCOUNT_DESCRIPTION'] = _discountdescription;
    map['DISCOUNT_TYPE'] = _discounttype;
    map['DISCOUNT_ON'] = _discounton;
    map['DISCOUNT_AMOUNT'] = _discountamount;
    map['MAX_DISCOUNT_AMOUNT'] = _maxdiscountamount;
    map['VALID_FROM_DATE'] = _validfromdate;
    map['VALID_TO_DATE'] = _validtodate;
    return map;
  }

}