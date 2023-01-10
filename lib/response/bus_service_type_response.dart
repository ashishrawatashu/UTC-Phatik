class BusServiceTypeResponse {
  BusServiceTypeResponse({
      this.code, 
      this.serviceTypeMaxSeat, 
      this.msg,});

  BusServiceTypeResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['ServiceTypeMaxSeat'] != null) {
      serviceTypeMaxSeat = [];
      json['ServiceTypeMaxSeat'].forEach((v) {
        serviceTypeMaxSeat?.add(ServiceTypeMaxSeat.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<ServiceTypeMaxSeat>? serviceTypeMaxSeat;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (serviceTypeMaxSeat != null) {
      map['ServiceTypeMaxSeat'] = serviceTypeMaxSeat?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class ServiceTypeMaxSeat {
  ServiceTypeMaxSeat({
      this.currentseats,});

  ServiceTypeMaxSeat.fromJson(dynamic json) {
    currentseats = json['CURRENTSEATS'];
  }
  int? currentseats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CURRENTSEATS'] = currentseats;
    return map;
  }

}