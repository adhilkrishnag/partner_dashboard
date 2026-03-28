import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:partner_dashboard/services/secure_storage.dart';

class HttpHelper {
  static Future<http.Response> _sendRequest(
    http.Request request, {
    bool authenticated = false,
  }) async {
    final String? authToken = await SecureStorageService().accessToken;
    if (authenticated) {
      request.headers.addAll({'Authorization': 'Bearer $authToken'});
    }

    late http.Response response;
    switch (request.method) {
      case 'GET':
        response = await http.get(request.url, headers: request.headers);
        break;
      case 'POST':
        response = await http.post(
          request.url,
          headers: request.headers,
          body: request.body,
        );
        break;
      case 'PUT':
        response = await http.put(
          request.url,
          headers: request.headers,
          body: request.body,
        );
        break;
      case 'DELETE':
        response = await http.delete(
          request.url,
          headers: request.headers,
          body: request.body,
        );
        break;
      default:
        throw Exception('Unsupported HTTP method: ${request.method}');
    }

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      throw http.ClientException('Error: ${response.statusCode}');
    } else {
      throw http.ClientException('Error: ${response.statusCode}');
    }
  }

  static Future<http.Response> sendPostRequest(
    String url, {
    dynamic body,
    bool authenticated = false,
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request('POST', uri);
    request.body = jsonEncode(body);
    request.headers.addAll({'Content-Type': 'application/json'});
    return await _sendRequest(request, authenticated: authenticated);
  }

  static Future<http.Response> sendAuthenticatedPostRequest(
    String url,
    dynamic body,
  ) async {
    final String authToken = await SecureStorageService().accessToken ?? "";

    if (authToken.isEmpty) {
      throw Exception('No auth token set.');
    }
    return await sendPostRequest(url, body: body, authenticated: true);
  }

  static Future<http.Response> sendGetRequest(
    String url, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request('GET', uri);
    return await _sendRequest(request, authenticated: authenticated);
  }

  static Future<http.Response> sendPutRequest(
    String url, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request('PUT', uri);
    return await _sendRequest(request, authenticated: authenticated);
  }

  static Future<http.Response> sendDeleteRequest(
    String url, {
    bool authenticated = false,
    dynamic body,
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request('DELETE', uri);
    if (body != null) {
      request.body = jsonEncode(body);
      request.headers.addAll({'Content-Type': 'application/json'});
    }

    return await _sendRequest(request, authenticated: authenticated);
  }

  static Future<http.Response> sendAuthenticatedGetRequest(String url) async {
    final String authToken = await SecureStorageService().accessToken ?? '';

    if (authToken.isEmpty) {
      throw Exception('No auth token set.');
    }
    return await sendGetRequest(url, authenticated: true);
  }

  static Future<http.Response> sendAuthenticatedDeleteRequest(
    String url, {
    dynamic body,
  }) async {
    final String authToken = await SecureStorageService().accessToken ?? "";

    if (authToken.isEmpty) {
      throw Exception('No auth token set.');
    }
    return await sendDeleteRequest(url, authenticated: true, body: body);
  }
}
