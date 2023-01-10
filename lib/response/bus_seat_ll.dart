class Bus_seat_ll {
  Bus_seat_ll({
      this.rownumber, 
      this.colnumber, 
      this.seatno, 
      this.seatyn, 
      this.travellertypecode, 
      this.seatavailforonlbooking, 
      this.status, 
      this.isSelected,});

  Bus_seat_ll.fromJson(dynamic json) {
    rownumber = json['ROWNUMBER'];
    colnumber = json['COLNUMBER'];
    seatno = json['SEATNO'];
    seatyn = json['SEATYN'];
    travellertypecode = json['TRAVELLERTYPECODE'];
    seatavailforonlbooking = json['SEATAVAILFORONLBOOKING'];
    status = json['STATUS'];
    isSelected = json['isSelected'];
  }
  double? rownumber;
  double? colnumber;
  double? seatno;
  String? seatyn;
  String? travellertypecode;
  String? seatavailforonlbooking;
  dynamic status;
  bool? isSelected = false;

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
    return map;
  }

}