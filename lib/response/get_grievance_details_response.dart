class GetGrievanceDetailsResponse {
  GetGrievanceDetailsResponse({
      this.code, 
      this.grievance, 
      this.grievanceTransaction, 
      this.msg,});

  GetGrievanceDetailsResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Grievance'] != null) {
      grievance = [];
      json['Grievance'].forEach((v) {
        grievance?.add(Grievance.fromJson(v));
      });
    }
    if (json['GrievanceTransaction'] != null) {
      grievanceTransaction = [];
      json['GrievanceTransaction'].forEach((v) {
        grievanceTransaction?.add(GrievanceTransaction.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Grievance>? grievance;
  List<GrievanceTransaction>? grievanceTransaction;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (grievance != null) {
      map['Grievance'] = grievance?.map((v) => v.toJson()).toList();
    }
    if (grievanceTransaction != null) {
      map['GrievanceTransaction'] = grievanceTransaction?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class GrievanceTransaction {
  GrievanceTransaction({
      this.statusname, 
      this.updatedby, 
      this.updatedatetime,});

  GrievanceTransaction.fromJson(dynamic json) {
    statusname = json['STATUSNAME'];
    updatedby = json['UPDATEDBY'];
    updatedatetime = json['UPDATEDATETIME'];
  }
  String? statusname;
  String? updatedby;
  String? updatedatetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STATUSNAME'] = statusname;
    map['UPDATEDBY'] = updatedby;
    map['UPDATEDATETIME'] = updatedatetime;
    return map;
  }

}

class Grievance {
  Grievance({
      this.grefno, 
      this.gcategoryid, 
      this.categoryname, 
      this.gsubcategoryid, 
      this.subcategoryname, 
      this.gremark, 
      this.gbyuser, 
      this.gstatus, 
      this.gdatetime, 
      this.assignto, 
      this.busno, 
      this.ticketnumber, 
      this.gpic1, 
      this.gpic2,});

  Grievance.fromJson(dynamic json) {
    grefno = json['GREFNO'];
    gcategoryid = json['GCATEGORYID'];
    categoryname = json['CATEGORYNAME'];
    gsubcategoryid = json['GSUBCATEGORYID'];
    subcategoryname = json['SUBCATEGORYNAME'];
    gremark = json['GREMARK'];
    gbyuser = json['GBYUSER'];
    gstatus = json['GSTATUS'];
    gdatetime = json['GDATETIME'];
    assignto = json['ASSIGNTO'];
    busno = json['BUSNO'];
    ticketnumber = json['TICKETNUMBER'];
    gpic1 = json['GPIC1'] != null ? json['GPIC1'].cast<int>() : [];
    gpic2 = json['GPIC2'] != null ? json['GPIC2'].cast<int>() : [];
  }
  String? grefno;
  int? gcategoryid;
  String? categoryname;
  int? gsubcategoryid;
  String? subcategoryname;
  dynamic gremark;
  String? gbyuser;
  String? gstatus;
  String? gdatetime;
  String? assignto;
  String? busno;
  dynamic ticketnumber;
  List<int>? gpic1;
  List<int>? gpic2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GREFNO'] = grefno;
    map['GCATEGORYID'] = gcategoryid;
    map['CATEGORYNAME'] = categoryname;
    map['GSUBCATEGORYID'] = gsubcategoryid;
    map['SUBCATEGORYNAME'] = subcategoryname;
    map['GREMARK'] = gremark;
    map['GBYUSER'] = gbyuser;
    map['GSTATUS'] = gstatus;
    map['GDATETIME'] = gdatetime;
    map['ASSIGNTO'] = assignto;
    map['BUSNO'] = busno;
    map['TICKETNUMBER'] = ticketnumber;
    map['GPIC1'] = gpic1;
    map['GPIC2'] = gpic2;
    return map;
  }

}