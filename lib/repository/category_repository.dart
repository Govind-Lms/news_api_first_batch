import 'package:news_api/consts/constant.dart';
import 'package:news_api/network/api_service.dart';
import 'package:news_api/network/resp_obj.dart';

class CategoryRepository  {
  final apiService = ApiService();
  Future<RespObj> getDesiredList(String endpointUrl, String categoryName) async{
    final response = await apiService.get(
      endpointUrl,
      params: {
        "country" : "us",
        "category" : categoryName,
        "apiKey": apiKey,
      }
    );
    return response;
  }
}