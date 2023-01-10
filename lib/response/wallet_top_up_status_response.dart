class WalletTopUpStatusResponse {
  WalletTopUpStatusResponse({
      String? code, 
      List<WalletStatus>? walletStatus, 
      String? msg,}){
    _code = code;
    _walletStatus = walletStatus;
    _msg = msg;
}

  WalletTopUpStatusResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['WalletStatus'] != null) {
      _walletStatus = [];
      json['WalletStatus'].forEach((v) {
        _walletStatus?.add(WalletStatus.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<WalletStatus>? _walletStatus;
  String? _msg;

  String? get code => _code;
  List<WalletStatus>? get walletStatus => _walletStatus;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_walletStatus != null) {
      map['WalletStatus'] = _walletStatus?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

class WalletStatus {
  WalletStatus({
      String? userId, 
      String? txnref, 
      int? amount, 
      String? startdate, 
      dynamic enddate, 
      String? completeyn,}){
    _userId = userId;
    _txnref = txnref;
    _amount = amount;
    _startdate = startdate;
    _enddate = enddate;
    _completeyn = completeyn;
}

  WalletStatus.fromJson(dynamic json) {
    _userId = json['user_id'];
    _txnref = json['txnref'];
    _amount = json['amount'];
    _startdate = json['startdate'];
    _enddate = json['enddate'];
    _completeyn = json['completeyn'];
  }
  String? _userId;
  String? _txnref;
  int? _amount;
  String? _startdate;
  dynamic _enddate;
  String? _completeyn;

  String? get userId => _userId;
  String? get txnref => _txnref;
  int? get amount => _amount;
  String? get startdate => _startdate;
  dynamic get enddate => _enddate;
  String? get completeyn => _completeyn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['txnref'] = _txnref;
    map['amount'] = _amount;
    map['startdate'] = _startdate;
    map['enddate'] = _enddate;
    map['completeyn'] = _completeyn;
    return map;
  }

}