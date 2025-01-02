import 'package:flutter/material.dart';
import 'package:news_api/consts/constant.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/network/resp_obj.dart';
import 'package:news_api/repository/category_repository.dart';
class CategoryProvider extends ChangeNotifier{
  
  CategoryRepository apiRepository = CategoryRepository();

  //initial
  RespObj respObj = RespObj(apiState: ApiState.initial,data: null);
  
  Future<void> getApiData(String categoryName) async {

    respObj = RespObj(apiState: ApiState.loading,data: null);
    notifyListeners();
    final response = await apiRepository.
    //categoryName can also be "{health/business/entertainment/technology}"
    //basically we can identify the categoryType by parsing 
    // from the UI Screen (from InitState())
    getDesiredList(headlineEndpoint,categoryName);
    
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
