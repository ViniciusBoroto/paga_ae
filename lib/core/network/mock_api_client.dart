import 'dart:convert';
import 'dart:io';

class MockApiClient {
  MockApiClient({HttpClient? httpClient})
    : _httpClient = httpClient ?? HttpClient();

  static const String defaultBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );

  final HttpClient _httpClient;
  final String baseUrl = defaultBaseUrl;

  Future<List<dynamic>> getList(String path) async {
    final response = await _send('GET', path);
    if (response is List<dynamic>) return response;
    throw const HttpException('Expected a list response from API');
  }

  Future<Map<String, dynamic>> getMap(String path) async {
    final response = await _send('GET', path);
    if (response is Map<String, dynamic>) return response;
    throw const HttpException('Expected an object response from API');
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final response = await _send('POST', path, body: body);
    if (response is Map<String, dynamic>) return response;
    throw const HttpException('Expected an object response from API');
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final response = await _send('PATCH', path, body: body);
    if (response is Map<String, dynamic>) return response;
    throw const HttpException('Expected an object response from API');
  }

  Future<void> delete(String path) async {
    await _send('DELETE', path);
  }

  Future<dynamic> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final request = await _httpClient.openUrl(
      method,
      Uri.parse('$baseUrl$path'),
    );
    request.headers.contentType = ContentType.json;
    request.headers.set(HttpHeaders.acceptHeader, ContentType.json.mimeType);

    if (body != null) {
      request.write(jsonEncode(body));
    }

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        responseBody.isEmpty ? 'API request failed' : responseBody,
        uri: Uri.parse('$baseUrl$path'),
      );
    }

    if (responseBody.isEmpty) return const <String, dynamic>{};
    return jsonDecode(responseBody);
  }
}
