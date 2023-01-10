class SeatLayouLboardingResponse {
  SeatLayouLboardingResponse({
      this.code,
      this.lowerLayoutRowCol,
      this.lowerLayout,
      this.upperLayoutRowCol,
      this.upperLayout,
      this.boarding,
      this.msg,});

  SeatLayouLboardingResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['LowerLayoutRowCol'] != null) {
      lowerLayoutRowCol = [];
      json['LowerLayoutRowCol'].forEach((v) {
        lowerLayoutRowCol?.add(LowerLayoutRowCol.fromJson(v));
      });
    }
    if (json['LowerLayout'] != null) {
      lowerLayout = [];
      json['LowerLayout'].forEach((v) {
        lowerLayout?.add(LowerLayout.fromJson(v));
      });
    }
    if (json['UpperLayoutRowCol'] != null) {
      upperLayoutRowCol = [];
      json['UpperLayoutRowCol'].forEach((v) {
        upperLayoutRowCol?.add(UpperLayoutRowCol.fromJson(v));
      });
    }
    if (json['UpperLayout'] != null) {
      upperLayout = [];
      json['UpperLayout'].forEach((v) {
        upperLayout?.add(UpperLayout.fromJson(v));
      });
    }
    if (json['Boarding'] != null) {
      boarding = [];
      json['Boarding'].forEach((v) {
        boarding?.add(Boarding.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<LowerLayoutRowCol>? lowerLayoutRowCol;
  List<LowerLayout>? lowerLayout;
  List<UpperLayoutRowCol>? upperLayoutRowCol;
  List<UpperLayout>? upperLayout;
  List<Boarding>? boarding;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (lowerLayoutRowCol != null) {
      map['LowerLayoutRowCol'] = lowerLayoutRowCol?.map((v) => v.toJson()).toList();
    }
    if (lowerLayout != null) {
      map['LowerLayout'] = lowerLayout?.map((v) => v.toJson()).toList();
    }
    if (upperLayoutRowCol != null) {
      map['UpperLayoutRowCol'] = upperLayoutRowCol?.map((v) => v.toJson()).toList();
    }
    if (upperLayout != null) {
      map['UpperLayout'] = upperLayout?.map((v) => v.toJson()).toList();
    }
    if (boarding != null) {
      map['Boarding'] = boarding?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Boarding {
  Boarding({
      this.pStcode,
      this.pStname,});

  Boarding.fromJson(dynamic json) {
    pStcode = json['STCODE'];
    pStname = json['STNAME'];
  }
  int? pStcode;
  String? pStname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STCODE'] = pStcode;
    map['STNAME'] = pStname;
    return map;
  }

}

class UpperLayout {
  UpperLayout({
      this.rownumber,
      this.colnumber,
      this.seatno,
      this.seatyn,
      this.travellertypecode,
      this.seatavailforonlbooking,
      this.status,});

  UpperLayout.fromJson(dynamic json) {
    rownumber = json['ROWNUMBER'];
    colnumber = json['COLNUMBER'];
    seatno = json['SEATNO'];
    seatyn = json['SEATYN'];
    travellertypecode = json['TRAVELLERTYPECODE'];
    seatavailforonlbooking = json['SEATAVAILFORONLBOOKING'];
    status = json['STATUS'];
  }
  int? rownumber;
  int? colnumber;
  int? seatno;
  String? seatyn;
  String? travellertypecode;
  String? seatavailforonlbooking;
  dynamic status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ROWNUMBER'] = rownumber;
    map['COLNUMBER'] = colnumber;
    map['SEATNO'] = seatno;
    map['SEATYN'] = seatyn;
    map['TRAVELLERTYPECODE'] = travellertypecode;
    map['SEATAVAILFORONLBOOKING'] = seatavailforonlbooking;
    map['STATUS'] = status;
    return map;
  }

}

class UpperLayoutRowCol {
  UpperLayoutRowCol({
      this.noofrows,
      this.noofcolumns,});

  UpperLayoutRowCol.fromJson(dynamic json) {
    noofrows = json['NOOFROWS'];
    noofcolumns = json['NOOFCOLUMNS'];
  }
  int? noofrows;
  int? noofcolumns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['NOOFROWS'] = noofrows;
    map['NOOFCOLUMNS'] = noofcolumns;
    return map;
  }

}

class LowerLayout {
  LowerLayout({
      this.rownumber,
      this.colnumber,
      this.seatno,
      this.seatyn,
      this.travellertypecode,
      this.seatavailforonlbooking,
      this.status,
      this.isSelected,
      this.isBlocked});

  LowerLayout.fromJson(dynamic json) {
    rownumber = json['ROWNUMBER'];
    colnumber = json['COLNUMBER'];
    seatno = json['SEATNO'];
    seatyn = json['SEATYN'];
    travellertypecode = json['TRAVELLERTYPECODE'];
    seatavailforonlbooking = json['SEATAVAILFORONLBOOKING'];
    status = json['STATUS'];
    isSelected = json['isSelected'];
    isBlocked = json['isBlocked'];
  }
  int? rownumber;
  int? colnumber;
  int? seatno;
  String? seatyn;
  String? travellertypecode;
  String? seatavailforonlbooking;
  dynamic status;
  bool? isSelected = false;
  bool? isBlocked = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ROWNUMBER'] = rownumber;
    map['COLNUMBER'] = colnumber;
    map['SEATNO'] = seatno;
    map['SEATYN'] = seatyn;
    map['TRAVELLERTYPECODE'] = travellertypecode;
    map['SEATAVAILFORONLBOOKING'] = seatavailforonlbooking;
    map['STATUS'] = status;
    map['isSelected'] = isSelected;
    map['isBlocked'] = isBlocked;
    return map;
  }

}

class LowerLayoutRowCol {
  LowerLayoutRowCol({
      this.noofrows,
      this.noofcolumns,});

  LowerLayoutRowCol.fromJson(dynamic json) {
    noofrows = json['NOOFROWS'];
    noofcolumns = json['NOOFCOLUMNS'];
  }
  int? noofrows;
  int? noofcolumns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['NOOFROWS'] = noofrows;
    map['NOOFCOLUMNS'] = noofcolumns;
    return map;
  }

}