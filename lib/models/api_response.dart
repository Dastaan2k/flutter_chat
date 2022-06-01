class APIResponse<T> {

  dynamic data;
  bool error;
  String? reason;

  APIResponse({this.data, this.error = false, this.reason});

}