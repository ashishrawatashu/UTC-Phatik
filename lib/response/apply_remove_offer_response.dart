class ApplyRemoveOfferResponse {
  ApplyRemoveOfferResponse({
      String? code, 
      List<Offers>? offers, 
      String? msg,}){
    _code = code;
    _offers = offers;
    _msg = msg;
}

  ApplyRemoveOfferResponse.fromJson(dynamic json) {
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
      String? status, 
      String? couponcode, 
      int? offeramount,
      int? totalamount,}){
    _status = status;
    _couponcode = couponcode;
    _offeramount = offeramount;
    _totalamount = totalamount;
}

  Offers.fromJson(dynamic json) {
    _status = json['STATUS'];
    _couponcode = json['COUPONCODE'];
    _offeramount = json['OFFERAMOUNT'];
    _totalamount = json['TOTALAMOUNT'];
  }
  String? _status;
  String? _couponcode;
  int? _offeramount;
  int? _totalamount;

  String? get status => _status;
  String? get couponcode => _couponcode;
  int? get offeramount => _offeramount;
  int? get totalamount => _totalamount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STATUS'] = _status;
    map['COUPONCODE'] = _couponcode;
    map['OFFERAMOUNT'] = _offeramount;
    map['TOTALAMOUNT'] = _totalamount;
    return map;
  }

}