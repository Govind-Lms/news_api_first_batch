import 'package:news_api/consts/constant.dart';
import 'package:news_api/network/api_service.dart';
import 'package:news_api/network/resp_obj.dart';

class EverythingRepository  {
  
  final apiService = ApiService();
  Future<RespObj> getDesiredList(String searchString,String? filteredBy, String? fromDate , String? toDate) async{
    final response = await apiService.get(
      everythingEndpoint,
      params: {
        "q" : searchString,
        "apiKey": apiKey,
        if (fromDate != null) "from": fromDate,
        if (toDate != null) "to": toDate,
        if (filteredBy != null) "sortBy": filteredBy,
      }
    );
    return response;
  }
}

