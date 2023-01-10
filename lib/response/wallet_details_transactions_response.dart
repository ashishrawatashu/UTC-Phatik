class WalletDetailsTransactionsResponse {
  WalletDetailsTransactionsResponse({
      this.code, 
      this.wallet, 
      this.walletTransactions, 
      this.msg,});

  WalletDetailsTransactionsResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Wallet'] != null) {
      wallet = [];
      json['Wallet'].forEach((v) {
        wallet?.add(Wallet.fromJson(v));
      });
    }
    if (json['WalletTransactions'] != null) {
      walletTransactions = [];
      json['WalletTransactions'].forEach((v) {
        walletTransactions?.add(WalletTransactions.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Wallet>? wallet;
  List<WalletTransactions>? walletTransactions;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (wallet != null) {
      map['Wallet'] = wallet?.map((v) => v.toJson()).toList();
    }
    if (walletTransactions != null) {
      map['WalletTransactions'] = walletTransactions?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class WalletTransactions {
  WalletTransactions({
      this.userid, 
      this.wallettxnreference, 
      this.wallettxnid, 
      this.wallettxntypecode, 
      this.txntype, 
      this.txnreference, 
      this.txnamount, 
      this.txndate,});

  WalletTransactions.fromJson(dynamic json) {
    userid = json['USERID'];
    wallettxnreference = json['WALLET_TXNREFERENCE'];
    wallettxnid = json['WALLET_TXNID'];
    wallettxntypecode = json['WALLET_TXNTYPECODE'];
    txntype = json['TXNTYPE'];
    txnreference = json['TXNREFERENCE'];
    txnamount = json['TXNAMOUNT'];
    txndate = json['TXNDATE'];
  }
  String? userid;
  String? wallettxnreference;
  String? wallettxnid;
  String? wallettxntypecode;
  String? txntype;
  String? txnreference;
  int? txnamount;
  String? txndate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USERID'] = userid;
    map['WALLET_TXNREFERENCE'] = wallettxnreference;
    map['WALLET_TXNID'] = wallettxnid;
    map['WALLET_TXNTYPECODE'] = wallettxntypecode;
    map['TXNTYPE'] = txntype;
    map['TXNREFERENCE'] = txnreference;
    map['TXNAMOUNT'] = txnamount;
    map['TXNDATE'] = txndate;
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