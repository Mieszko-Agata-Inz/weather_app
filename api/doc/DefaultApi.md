# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:83*

Method | HTTP request | Description
------------- | ------------- | -------------
[**forecastForecastGeohashGet**](DefaultApi.md#forecastforecastgeohashget) | **GET** /forecast/{geohash} | Forecast
[**rawdataRawdataTimestampGet**](DefaultApi.md#rawdatarawdatatimestampget) | **GET** /rawdata/{timestamp} | Rawdata
[**rootGet**](DefaultApi.md#rootget) | **GET** / | Root
[**updateModelUpdateStateModelNamePost**](DefaultApi.md#updatemodelupdatestatemodelnamepost) | **POST** /update/{state}/{model_name} | Update Model


# **forecastForecastGeohashGet**
> JsonObject forecastForecastGeohashGet(geohash)

Forecast

function returns a forecast for a given geohash  geohash - string of a geohash, must correspond to a geohash present in redis

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
final JsonObject geohash = ; // JsonObject | 

try {
    final response = api.forecastForecastGeohashGet(geohash);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->forecastForecastGeohashGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **geohash** | [**JsonObject**](.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rawdataRawdataTimestampGet**
> JsonObject rawdataRawdataTimestampGet(timestamp)

Rawdata

function returns all raw data from  timestamp up until now timestamp - unix timestamp in miliseconds, defaults to 1 hour

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
final JsonObject timestamp = ; // JsonObject | 

try {
    final response = api.rawdataRawdataTimestampGet(timestamp);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->rawdataRawdataTimestampGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **timestamp** | [**JsonObject**](.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootGet**
> BuiltList<String> rootGet()

Root

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();

try {
    final response = api.rootGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->rootGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**BuiltList&lt;String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateModelUpdateStateModelNamePost**
> JsonObject updateModelUpdateStateModelNamePost(state, modelName, reqApiKey, file)

Update Model

function returns all raw data from  timestamp up until now timestamp - unix timestamp in miliseconds, defaults to 1 hour

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
final String state = state_example; // String | 
final String modelName = modelName_example; // String | 
final String reqApiKey = reqApiKey_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.updateModelUpdateStateModelNamePost(state, modelName, reqApiKey, file);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->updateModelUpdateStateModelNamePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **state** | **String**|  | 
 **modelName** | **String**|  | 
 **reqApiKey** | **String**|  | 
 **file** | **MultipartFile**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

