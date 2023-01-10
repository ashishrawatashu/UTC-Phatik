class WalletTopUpResponse {
  WalletTopUpResponse({
      String? code, 
      List<WalletStatus>? walletStatus, 
      String? msg,}){
    _code = code;
    _walletStatus = walletStatus;
    _msg = msg;
}

  WalletTopUpResponse.fromJson(dynamic json) {
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
      String? pRslt,}){
    _pRslt = pRslt;
}

  WalletStatus.fromJson(dynamic json) {
    _pRslt = json['p_rslt'];
  }
  String? _pRslt;

  String? get pRslt => _pRslt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['p_rslt'] = _pRslt;
    return map;
  }

}