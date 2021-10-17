import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  String urlBase = "https://eduwingserp.com/Api/v1/mobile/";
  String apiKey = "ZUthbndlckluZGlhTHVkaGlhbmE=";
  String serverApi = "getEducationalDetail.php";

  Future getEducationDetail(formId) async {
    final response = await http.post(Uri.parse(urlBase + serverApi),
        headers: {'APIKEY': apiKey}, body: {"formid": formId});
    return response;
  }
}
