# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:83*

Method | HTTP request | Description
------------- | ------------- | -------------
[**forecastForecastLatLonGet**](DefaultApi.md#forecastforecastlatlonget) | **GET** /forecast/{lat}/{lon} | Forecast
[**rootGet**](DefaultApi.md#rootget) | **GET** / | Root


# **forecastForecastLatLonGet**
> Prediction forecastForecastLatLonGet(lat, lon)

Forecast

function returns a forecast for a given geohash  geohash - string of a geohash, must correspond to a geohash present in redis

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
final num lat = 8.14; // num | 
final num lon = 8.14; // num | 

try {
    final response = api.forecastForecastLatLonGet(lat, lon);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->forecastForecastLatLonGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **lat** | **num**|  | 
 **lon** | **num**|  | 

### Return type

[**Prediction**](Prediction.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootGet**
> JsonObject rootGet()

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

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

