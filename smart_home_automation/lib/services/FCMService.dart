import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FCMService {
  static const String FCMAPI =
      "AAAAdEtj-Ew:APA91bEIGzKOCAmCnnAVq8uXry_qtZKteFJGX08i_2X5zYYrJ-OmVS_iAb4Evs9XNeSDAfaP9JIsr-05hApJ_EQKKKhYzuTa2UwAKRA-Fdq16VNhLTE-OO5WxDin8-V6iSx-Q5PzihTA";

  static String makePayLoadWithToken(String? token, Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'to': token,
      'data': data,
      'notification': notification,
    });
  }
}
