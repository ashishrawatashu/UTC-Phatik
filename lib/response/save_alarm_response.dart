class SaveAlarmResponse {
  SaveAlarmResponse({
      this.code, 
      this.alarm, 
      this.msg,});

  SaveAlarmResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Alarm'] != null) {
      alarm = [];
      json['Alarm'].forEach((v) {
        alarm?.add(SaveAlarm.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<SaveAlarm>? alarm;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (alarm != null) {
      map['Alarm'] = alarm?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class SaveAlarm {
  SaveAlarm({
      this.status,});

  SaveAlarm.fromJson(dynamic json) {
    status = json['STATUS'];
  }
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STATUS'] = status;
    return map;
  }

}