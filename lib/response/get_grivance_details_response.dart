class GetGrivanceDetailsResponse {
  GetGrivanceDetailsResponse({
      this.code, 
      this.result, 
      this.msg,});

  GetGrivanceDetailsResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Result'] != null) {
      result = [];
      json['Result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Result>? result;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (result != null) {
      map['Result'] = result?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Result {
  Result({
      this.refno, 
      this.catid, 
      this.catname, 
      this.subcatid, 
      this.subcatname, 
      this.remark, 
      this.userid, 
      this.status, 
      this.datetime, 
      this.assignTo, 
      this.busNo, 
      this.ticketno,});

  Result.fromJson(dynamic json) {
    refno = json['refno'];
    catid = json['catid'];
    catname = json['catname'];
    subcatid = json['subcatid'];
    subcatname = json['subcatname'];
    remark = json['remark'];
    userid = json['userid'];
    status = json['status'];
    datetime = json['datetime'];
    assignTo = json['assign_to'];
    busNo = json['bus_no'];
    ticketno = json['ticketno'];
  }
  String? refno;
  int? catid;
  String? catname;
  int? subcatid;
  String? subcatname;
  String? remark;
  String? userid;
  String? status;
  String? datetime;
  String? assignTo;
  String? busNo;
  String? ticketno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refno'] = refno;
    map['catid'] = catid;
    map['catname'] = catname;
    map['subcatid'] = subcatid;
    map['subcatname'] = subcatname;
    map['remark'] = remark;
    map['userid'] = userid;
    map['status'] = status;
    map['datetime'] = datetime;
    map['assign_to'] = assignTo;
    map['bus_no'] = busNo;
    map['ticketno'] = ticketno;
    return map;
  }

}