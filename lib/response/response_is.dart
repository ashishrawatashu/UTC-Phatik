/// ROWNUMBER : 1.0
/// COLNUMBER : 1.0
/// SEATNO : 0.0
/// SEATYN : "N"
/// TRAVELLERTYPECODE : "G"
/// SEATAVAILFORONLBOOKING : "Y"
/// STATUS : null
/// isSelected : true

class Response_is {
  Response_is({
    double? rownumber,
    double? colnumber,
    double? seatno,
    String? seatyn,
    String? travellertypecode,
    String? seatavailforonlbooking,
    dynamic status,
    bool? isSelected,
  }) {
    _rownumber = rownumber;
    _colnumber = colnumber;
    _seatno = seatno;
    _seatyn = seatyn;
    _travellertypecode = travellertypecode;
    _seatavailforonlbooking = seatavailforonlbooking;
    _status = status;
    _isSelected = isSelected;
  }

  Response_is.fromJson(dynamic json) {
    _rownumber = json['ROWNUMBER'];
    _colnumber = json['COLNUMBER'];
    _seatno = json['SEATNO'];
    _seatyn = json['SEATYN'];
    _travellertypecode = json['TRAVELLERTYPECODE'];
    _seatavailforonlbooking = json['SEATAVAILFORONLBOOKING'];
    _status = json['STATUS'];
    _isSelected = json['isSelected'];
  }

  double? _rownumber;
  double? _colnumber;
  double? _seatno;
  String? _seatyn;
  String? _travellertypecode;
  String? _seatavailforonlbooking;
  dynamic _status;
  bool? _isSelected;

  double? get rownumber => _rownumber;

  double? get colnumber => _colnumber;

  double? get seatno => _seatno;

  String? get seatyn => _seatyn;

  String? get travellertypecode => _travellertypecode;

  String? get seatavailforonlbooking => _seatavailforonlbooking;

  dynamic get status => _status;

  bool? get isSelected => _isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ROWNUMBER'] = _rownumber;
    map['COLNUMBER'] = _colnumber;
    map['SEATNO'] = _seatno;
    map['SEATYN'] = _seatyn;
    map['TRAVELLERTYPECODE'] = _travellertypecode;
    map['SEATAVAILFORONLBOOKING'] = _seatavailforonlbooking;
    map['STATUS'] = _status;
    map['isSelected'] = _isSelected;
    return map;
  }
}
