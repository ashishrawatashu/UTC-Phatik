class GetWalletResponse {
  GetWalletResponse({
      String? code,
      List<Wallet>? wallet,
      String? msg,}){
    _code = code;
    _wallet = wallet;
    _msg = msg;
}

  GetWalletResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['Wallet'] != null) {
      _wallet = [];
      json['Wallet'].forEach((v) {
        _wallet?.add(Wallet.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<Wallet>? _wallet;
  String? _msg;

  String? get code => _code;
  List<Wallet>? get wallet => _wallet;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_wallet != null) {
      map['Wallet'] = _wallet?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

class Wallet {
  Wallet({
      String? userid,
      String? openingdate,
      int? currentbalanceamount,
      String? ddate,}){
    _userid = userid;
    _openingdate = openingdate;
    _currentbalanceamount = currentbalanceamount;
    _ddate = ddate;
}

  Wallet.fromJson(dynamic json) {
    _userid = json['USERID'];
    _openingdate = json['OPENINGDATE'];
    _currentbalanceamount = json['CURRENTBALANCEAMOUNT'];
    _ddate = json['DDATE'];
  }
  String? _userid;
  String? _openingdate;
  int? _currentbalanceamount;
  String? _ddate;

  String? get userid => _userid;
  String? get openingdate => _openingdate;
  int? get currentbalanceamount => _currentbalanceamount;
  String? get ddate => _ddate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USERID'] = _userid;
    map['OPENINGDATE'] = _openingdate;
    map['CURRENTBALANCEAMOUNT'] = _currentbalanceamount;
    map['DDATE'] = _ddate;
    return map;
  }

}