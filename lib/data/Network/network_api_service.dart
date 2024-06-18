import 'dart:convert';
import 'package:http/http.dart'as http;

class NetworkApiService {

  Future getApiResponse() async {
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse("https://ims.brthalirfinance.in/API/MobileAPI/BindMstKYCTypeAndMstKYC"),
      ).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } catch(e) {
      rethrow;
    }
    return responseJson;
  }


  @override
  Future postApiResponse(
      dynamic data,
      ) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse("https://ims.brthalirfinance.in/API/MobileAPI/AddKYCDetails"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } catch(e){
      rethrow;
    }
    return responseJson;
  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
    }
  }

}