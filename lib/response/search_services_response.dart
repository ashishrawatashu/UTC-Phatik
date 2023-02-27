class SearchServicesResponse {
  SearchServicesResponse({
      this.code, 
      this.services, 
      this.msg,});

  SearchServicesResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Services'] != null) {
      services = [];
      json['Services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Services>? services;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (services != null) {
      map['Services'] = services?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Services {
  Services({
      this.dsvcid, 
      this.servicename, 
      this.strpid, 
      this.frstonid, 
      this.tostonid, 
      this.depttime, 
      this.arrtime, 
      this.tripdirection, 
      this.srtpid, 
      this.servicetypename, 
      this.layout, 
      this.totalseat, 
      this.routeid, 
      this.routename, 
      this.totaldistance, 
      this.totalfare, 
      this.amenity, 
      this.midstations, 
      this.seatsforbooking, 
      // this.fromstation,
      // this.tostation,
      this.arrivalBus,
      this.deptBus,
      this.showHideItem,
  });

  Services.fromJson(dynamic json) {
    dsvcid = json['DSVC_ID'];
    servicename = json['SERVICE_NAME_EN'];
    strpid = json['STRP_ID'];
    frstonid = json['FR_STON_ID'];
    tostonid = json['TO_STON_ID'];
    depttime = json['DEPARTURETIME'];
    arrtime = json['ARRIVALTIME'];
    tripdirection = json['TRIP_DIRECTION'];
    srtpid = json['SRTP_ID'];
    servicetypename = json['SERVICE_TYPE_NAME_EN'];
    layout = json['LAYOUTCODE'];
    totalseat = json['TOTALSEATS'];
    routeid = json['ROUT_ID'];
    routename = json['ROUTE_NAME_EN'];
    totaldistance = json['TOTAL_DIST_KM'];
    totalfare = json['FARE'];
    amenity = json['AMENITIES'];
    amenities_url = json['AMENITIES_URL'];
    midstations = json['PICKUP_DROPS'];
    seatsforbooking = json['TOTALSEATSFORBOOKING'];
    // fromstation = json['fromstation'];
    // tostation = json['tostation'];
    arrivalBus = json['arrivalBus'];
    deptBus = json['deptBus'];
  }
  String? dsvcid;
  String? servicename;
  int? strpid;
  int? frstonid;
  int? tostonid;
  String? depttime;
  String? arrtime;
  String? tripdirection;
  int? srtpid;
  String? servicetypename;
  int? layout;
  String? totalseat;
  int? routeid;
  String? routename;
  String? totaldistance;
  String? totalfare;
  dynamic amenity;
  String? midstations;
  String? amenities_url;
  String? seatsforbooking;
  // String? fromstation;
  // String? tostation;
  String? arrivalBus;
  String? deptBus;
  bool? showHideItem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DSVC_ID'] = dsvcid;
    map['SERVICE_NAME_EN'] = servicename;
    map['STRP_ID'] = strpid;
    map['FR_STON_ID'] = frstonid;
    map['TO_STON_ID'] = tostonid;
    map['DEPARTURETIME'] = depttime;
    map['ARRIVALTIME'] = arrtime;
    map['TRIP_DIRECTION'] = tripdirection;
    map['SRTP_ID'] = srtpid;
    map['SERVICE_TYPE_NAME_EN'] = servicetypename;
    map['LAYOUTCODE'] = layout;
    map['TOTALSEATS'] = totalseat;
    map['ROUT_ID'] = routeid;
    map['ROUTE_NAME_EN'] = routename;
    map['TOTAL_DIST_KM'] = totaldistance;
    map['FARE'] = totalfare;
    map['AMENITIES'] = amenity;
    map['AMENITIES_URL'] = amenities_url;
    map['PICKUP_DROPS'] = midstations;
    map['TOTALSEATSFORBOOKING'] = seatsforbooking;
    // map['fromstation'] = fromstation;
    // map['tostation'] = tostation;
    map['arrivalBus'] = arrivalBus;
    map['deptBus'] = deptBus;
    return map;
  }

}