class RespObj{
  final dynamic data;
  final ApiState apiState;
  final ErrorState? errorState;
  RespObj({required this.data, required this.apiState, this.errorState});
}

enum ApiState {
  initial,loading,success,failure;
}

enum ErrorState {
  notFound, forbidden, server, network, unknown,unauthorized,badRequest,tooManyRequest
}

//RespObj(ApiState.error, 'Server Error')

///RespObj(
///   apiState: ApiState.success
///   data : data
///)