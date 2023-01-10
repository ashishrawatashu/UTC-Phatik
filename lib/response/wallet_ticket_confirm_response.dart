class WalletTicketConfirmResponse {
  WalletTicketConfirmResponse({
      this.code, 
      this.wallet, 
      this.msg,});

  WalletTicketConfirmResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Wallet'] != null) {
      wallet = [];
      json['Wallet'].forEach((v) {
        wallet?.add(Wallet.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Wallet>? wallet;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (wallet != null) {
      map['Wallet'] = wallet?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Wallet {
  Wallet({
      this.statuss,});

  Wallet.fromJson(dynamic json) {
    statuss = json['STATUSS'];
  }
  String? statuss;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STATUSS'] = statuss;
    return map;
  }

}