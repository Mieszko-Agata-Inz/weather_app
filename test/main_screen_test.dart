import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:http/testing.dart';

// The function to be tested
Future<String> connect(http.Client client) async {
  final response = await client.get(Uri.parse('http://localhost:83'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

void main() {
  test('connect returns data if HTTP call completes successfully', () async {
    final client = MockClient((request) async {
      return http.Response('{"connection:) ok"}', 200);
    });

    final result = await connect(client);

    expect(result, '{"connection:) ok"}');
  });

  test('connect throws an exception if HTTP call fails', () async {
    final client = MockClient((request) async {
      return http.Response('Not Found', 404);
    });

    expect(() => connect(client), throwsException);
  });

  test('connect returns data if HTTP call completes successfully', () async {
    final client = MockClient((request) async {
      return http.Response('{"connection:) ok"}', 200);
    });

    final result = await connect(client);

    expect(result, '{"connection:) ok"}');
  });
}