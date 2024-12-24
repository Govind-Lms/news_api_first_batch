import 'package:news_api/consts/constant.dart';
import 'package:news_api/network/api_service.dart';
import 'package:news_api/network/resp_obj.dart';

class EverythingRepository  {
  
  final apiService = ApiService();
  Future<RespObj> getDesiredList(String endpointUrl) async{
    final response = await apiService.get(
      endpointUrl,
      params: {
        //we can also parse "q and sortBy" from Provider
        // (q = "google/tesla/apple/...")
        "q" : "tesla",
        "sortBy" : "publishedAt",
        "apiKey": apiKey,
      }
    );
    return response;
  }
}

