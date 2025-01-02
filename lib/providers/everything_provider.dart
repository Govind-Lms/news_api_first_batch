import 'package:flutter/material.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/network/resp_obj.dart';
import 'package:news_api/repository/everything_repository.dart';
class EverythingProvider extends ChangeNotifier{
  
  EverythingRepository apiRepository = EverythingRepository();

  //initial
  RespObj respObj = RespObj(apiState: ApiState.initial,data: null);
  
  Future<void> getApiData(String searchString,{String? filteredBy, String? fromDate , String? toDate}) async {

     respObj = RespObj(apiState: ApiState.initial,data: null);
     notifyListeners();

    final response = await apiRepository.getDesiredList(searchString,filteredBy,fromDate,toDate);
    
    //success
    if(response.apiState == ApiState.success) {
      //assigning resp data to dynamic list variable apiJSON 
      List<dynamic> articlesJson = response.data['articles'];

      //converting jsonData to model class data
      final modelData = articlesJson.map((item) => NewsModel.fromJson(item)).toList();
      
      respObj = RespObj(apiState: ApiState.success,data: modelData);
      
    }    
    else{
      //error
      respObj = RespObj(apiState: ApiState.failure, data: response.data);
    }
    notifyListeners();
  }
}
