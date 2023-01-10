class GetPaymentGatewaysResponse {
  GetPaymentGatewaysResponse({
      this.code, 
      this.pg, 
      this.msg,});

  GetPaymentGatewaysResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['PG'] != null) {
      pg = [];
      json['PG'].forEach((v) {
        pg?.add(Pg.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Pg>? pg;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (pg != null) {
      map['PG'] = pg?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Pg {
  Pg({
      this.gatewayid, 
      this.gatewayname, 
      this.status, 
      this.statusname, 
      this.updateby, 
      this.description,});

  Pg.fromJson(dynamic json) {
    gatewayid = json['GATEWAY_ID'];
    gatewayname = json['GATEWAY_NAME'];
    status = json['STATUS'];
    statusname = json['STATUS_NAME'];
    updateby = json['UPDATEBY'];
    description = json['DESCRIPTION'];
  }
  int? gatewayid;
  String? gatewayname;
  String? status;
  String? statusname;
  String? updateby;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GATEWAY_ID'] = gatewayid;
    map['GATEWAY_NAME'] = gatewayname;
    map['STATUS'] = status;
    map['STATUS_NAME'] = statusname;
    map['UPDATEBY'] = updateby;
    map['DESCRIPTION'] = description;
    return map;
  }

}