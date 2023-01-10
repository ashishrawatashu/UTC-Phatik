class GetGrievanceReponse {
  GetGrievanceReponse({
      this.code, 
      this.grievance, 
      this.msg,});

  GetGrievanceReponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Grievance'] != null) {
      grievance = [];
      json['Grievance'].forEach((v) {
        grievance?.add(Grievance.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Grievance>? grievance;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (grievance != null) {
      map['Grievance'] = grievance?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
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
      this.ticketnumber,});

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
  }
  String? grefno;
  int? gcategoryid;
  String? categoryname;
  int? gsubcategoryid;
  String? subcategoryname;
  String? gremark;
  String? gbyuser;
  String? gstatus;
  String? gdatetime;
  String? assignto;
  String? busno;
  String? ticketnumber;

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
    return map;
  }

}