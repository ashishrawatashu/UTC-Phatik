class BusSeatLayoutResponse {
  BusSeatLayoutResponse({
    String? code,
    List<LowerLayoutRowCol>? lowerLayoutRowCol,
    List<LowerLayout>? lowerLayout,
    List<UpperLayoutRowCol>? upperLayoutRowCol,
    List<UpperLayout>? upperLayout,
    List<Boarding>? boarding,
    String? msg,}){
    _code = code;
    _lowerLayoutRowCol = lowerLayoutRowCol;
    _lowerLayout = lowerLayout;
    _upperLayoutRowCol = upperLayoutRowCol;
    _upperLayout = upperLayout;
    _boarding = boarding;
    _msg = msg;
  }

  BusSeatLayoutResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['LowerLayoutRowCol'] != null) {
      _lowerLayoutRowCol = [];
      json['LowerLayoutRowCol'].forEach((v) {
        _lowerLayoutRowCol?.add(LowerLayoutRowCol.fromJson(v));
      });
    }
    if (json['LowerLayout'] != null) {
      _lowerLayout = [];
      json['LowerLayout'].forEach((v) {
        _lowerLayout?.add(LowerLayout.fromJson(v));
      });
    }
    if (json['UpperLayoutRowCol'] != null) {
      _upperLayoutRowCol = [];
      json['UpperLayoutRowCol'].forEach((v) {
        _upperLayoutRowCol?.add(UpperLayoutRowCol.fromJson(v));
      });
    }
    if (json['UpperLayout'] != null) {
      _upperLayout = [];
      json['UpperLayout'].forEach((v) {
        _upperLayout?.add(UpperLayout.fromJson(v));
      });
    }
    if (json['Boarding'] != null) {
      _boarding = [];
      json['Boarding'].forEach((v) {
        _boarding?.add(Boarding.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<LowerLayoutRowCol>? _lowerLayoutRowCol;
  List<LowerLayout>? _lowerLayout;
  List<UpperLayoutRowCol>? _upperLayoutRowCol;
  List<UpperLayout>? _upperLayout;
  List<Boarding>? _boarding;
  String? _msg;

  String? get code => _code;
  List<LowerLayoutRowCol>? get lowerLayoutRowCol => _lowerLayoutRowCol;
  List<LowerLayout>? get lowerLayout => _lowerLayout;
  List<UpperLayoutRowCol>? get upperLayoutRowCol => _upperLayoutRowCol;
  List<UpperLayout>? get upperLayout => _upperLayout;
  List<Boarding>? get boarding => _boarding;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_lowerLayoutRowCol != null) {
      map['LowerLayoutRowCol'] = _lowerLayoutRowCol?.map((v) => v.toJson()).toList();
    }
    if (_lowerLayout != null) {
      map['LowerLayout'] = _lowerLayout?.map((v) => v.toJson()).toList();
    }
    if (_upperLayoutRowCol != null) {
      map['UpperLayoutRowCol'] = _upperLayoutRowCol?.map((v) => v.toJson()).toList();
    }
    if (_upperLayout != null) {
      map['UpperLayout'] = _upperLayout?.map((v) => v.toJson()).toList();
    }
    if (_boarding != null) {
      map['Boarding'] = _boarding?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

class Boarding {
  Boarding({
    int? stcode,
    String? stname,}){
    _stcode = stcode;
    _stname = stname;
  }

  Boarding.fromJson(dynamic json) {
    _stcode = json['STCODE'];
    _stname = json['STNAME'];
  }
  int? _stcode;
  String? _stname;

  int? get stcode => _stcode;
  String? get stname => _stname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STCODE'] = _stcode;
    map['STNAME'] = _stname;
    return map;
  }

}

class UpperLayout {
  UpperLayout({
    int? rownumber,
    int? colnumber,
    int? seatno,
    String? seatyn,
    String? travellertypecode,
    String? seatavailforonlbooking,
    dynamic status,}){
    _rownumber = rownumber;
    _colnumber = colnumber;
    _seatno = seatno;
    _seatyn = seatyn;
    _travellertypecode = travellertypecode;
    _seatavailforonlbooking = seatavailforonlbooking;
    _status = status;
  }

  UpperLayout.fromJson(dynamic json) {
    _rownumber = json['ROWNUMBER'];
    _colnumber = json['COLNUMBER'];
    _seatno = json['SEATNO'];
    _seatyn = json['SEATYN'];
    _travellertypecode = json['TRAVELLERTYPECODE'];
    _seatavailforonlbooking = json['SEATAVAILFORONLBOOKING'];
    _status = json['STATUS'];
  }
  int? _rownumber;
  int? _colnumber;
  int? _seatno;
  String? _seatyn;
  String? _travellertypecode;
  String? _seatavailforonlbooking;
  dynamic _status;

  int? get rownumber => _rownumber;
  int? get colnumber => _colnumber;
  int? get seatno => _seatno;
  String? get seatyn => _seatyn;
  String? get travellertypecode => _travellertypecode;
  String? get seatavailforonlbooking => _seatavailforonlbooking;
  dynamic get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ROWNUMBER'] = _rownumber;
    map['COLNUMBER'] = _colnumber;
    map['SEATNO'] = _seatno;
    map['SEATYN'] = _seatyn;
    map['TRAVELLERTYPECODE'] = _travellertypecode;
    map['SEATAVAILFORONLBOOKING'] = _seatavailforonlbooking;
    map['STATUS'] = _status;
    return map;
  }

}

class UpperLayoutRowCol {
  UpperLayoutRowCol({
    int? noofrows,
    int? noofcolumns,}){
    _noofrows = noofrows;
    _noofcolumns = noofcolumns;
  }

  UpperLayoutRowCol.fromJson(dynamic json) {
    _noofrows = json['NOOFROWS'];
    _noofcolumns = json['NOOFCOLUMNS'];
  }
  int? _noofrows;
  int? _noofcolumns;

  int? get noofrows => _noofrows;
  int? get noofcolumns => _noofcolumns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['NOOFROWS'] = _noofrows;
    map['NOOFCOLUMNS'] = _noofcolumns;
    return map;
  }

}

class LowerLayout {
  LowerLayout({
    int? rownumber,
    int? colnumber,
    int? seatno,
    String? seatyn,
    String? travellertypecode,
    String? seatavailforonlbooking,
    dynamic status,}){
    _rownumber = rownumber;
    _colnumber = colnumber;
    _seatno = seatno;
    _seatyn = seatyn;
    _travellertypecode = travellertypecode;
    _seatavailforonlbooking = seatavailforonlbooking;
    _status = status;
  }

  LowerLayout.fromJson(dynamic json) {
    _rownumber = json['ROWNUMBER'];
    _colnumber = json['COLNUMBER'];
    _seatno = json['SEATNO'];
    _seatyn = json['SEATYN'];
    _travellertypecode = json['TRAVELLERTYPECODE'];
    _seatavailforonlbooking = json['SEATAVAILFORONLBOOKING'];
    _status = json['STATUS'];
  }
  int? _rownumber;
  int? _colnumber;
  int? _seatno;
  String? _seatyn;
  String? _travellertypecode;
  String? _seatavailforonlbooking;
  dynamic _status;

  int? get rownumber => _rownumber;
  int? get colnumber => _colnumber;
  int? get seatno => _seatno;
  String? get seatyn => _seatyn;
  String? get travellertypecode => _travellertypecode;
  String? get seatavailforonlbooking => _seatavailforonlbooking;
  dynamic get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ROWNUMBER'] = _rownumber;
    map['COLNUMBER'] = _colnumber;
    map['SEATNO'] = _seatno;
    map['SEATYN'] = _seatyn;
    map['TRAVELLERTYPECODE'] = _travellertypecode;
    map['SEATAVAILFORONLBOOKING'] = _seatavailforonlbooking;
    map['STATUS'] = _status;
    return map;
  }

}

class LowerLayoutRowCol {
  LowerLayoutRowCol({
    int? noofrows,
    int? noofcolumns,}){
    _noofrows = noofrows;
    _noofcolumns = noofcolumns;
  }

  LowerLayoutRowCol.fromJson(dynamic json) {
    _noofrows = json['NOOFROWS'];
    _noofcolumns = json['NOOFCOLUMNS'];
  }
  int? _noofrows;
  int? _noofcolumns;

  int? get noofrows => _noofrows;
  int? get noofcolumns => _noofcolumns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['NOOFROWS'] = _noofrows;
    map['NOOFCOLUMNS'] = _noofcolumns;
    return map;
  }

}