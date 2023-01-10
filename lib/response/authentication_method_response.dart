class AuthenticationMethodResponse {
  AuthenticationMethodResponse({
      this.code, 
      this.result, 
      this.msg,});

  AuthenticationMethodResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Result'] != null) {
      result = [];
      json['Result'].forEach((v) {
        result?.add(AuthResult.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<AuthResult>? result;
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

class AuthResult {
  AuthResult({
      this.token,});

  AuthResult.fromJson(dynamic json) {
    token = json['token'];
  }
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}