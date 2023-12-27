import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

class MockPrediction {
  late BuiltList<num>? _hour0;
  late BuiltList<num>? _hour1;
  late BuiltList<num>? _hour2;
  late BuiltList<num>? _hour3;

  MockPrediction.fromJson(Map<String, dynamic> parsedJson) {
    List<num> mappedList0 =
        (parsedJson['hour0'] as List).map((element) => element as int).toList();
    BuiltList<num> builtList0 = BuiltList<num>.from(mappedList0);
    _hour0 = builtList0;
    List<num> mappedList1 =
        (parsedJson['hour1'] as List).map((element) => element as int).toList();
    BuiltList<num> builtList1 = BuiltList<num>.from(mappedList1);
    _hour1 = builtList1;
    List<num> mappedList2 =
        (parsedJson['hour2'] as List).map((element) => element as int).toList();
    BuiltList<num> builtList2 = BuiltList<num>.from(mappedList2);
    _hour2 = builtList2;
    List<num> mappedList3 =
        (parsedJson['hour3'] as List).map((element) => element as int).toList();
    BuiltList<num> builtList3 = BuiltList<num>.from(mappedList3);
    _hour3 = builtList3;
  }

  BuiltList<num>? get hour0 => _hour0;
  BuiltList<num>? get hour1 => _hour1;
  BuiltList<num>? get hour2 => _hour2;
  BuiltList<num>? get hour3 => _hour3;
}

class MockAPIProvider extends ChangeNotifier {
  // Mock property or method examples
  final mockClient = MockClient((request) async {
    // Prediction pred = Prediction();
    final mapJson = {
      'hour0': List<num>.from([0, 0, 0]),
      'hour1': List<num>.from([1, 1, 1]),
      'hour2': List<num>.from([2, 2, 2]),
      'hour3': List<num>.from([3, 3, 3])
    };
    return http.Response(json.encode(mapJson), 200);
  });

  fetchPosts() async {
    final response = await mockClient.get(Uri.parse('http://localhost:83'));
    MockPrediction mockPrediction =
        MockPrediction.fromJson(json.decode(response.body));
    return mockPrediction;
  }
}
