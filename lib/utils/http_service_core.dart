import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart' as Foundation;

enum REQUEST_ERROR { TIMEOUT, NO_INTERNET }

class HttpServiceCore {
  String? baseUrl;
  int? defaultTimeout;
  int? maxTimeRetry;
  Map<String, String>? defaultHeaders;
  Map<String, dynamic>? defaultBody;
  ResponseInfo? responseInfo;
  bool showDebug = true;
  bool enableDebugTool = true;
  String serverDebugTool = 'http://localhost';

  void onError(REQUEST_ERROR error) {}
  Future interceptorRequest() async {}
  Future interceptorResponse(Res request) async => request;

  int _currentTimeRetry = 0;

  // ignore: non_constant_identifier_names
  final POST = 'POST';
  // ignore: non_constant_identifier_names
  var GET = 'GET';
  // ignore: non_constant_identifier_names
  var PUT = 'PUT';
  // ignore: non_constant_identifier_names
  var DELETE = 'DELETE';

  Future<Res> fetch({
    String? url,
    String? method,
    Map<String, dynamic>? params,
    int? timeout,
    Function(REQUEST_ERROR)? onTimeout,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    List<File>? images,
  }) async {
    final completer = Completer<Res>();
    Uri uri = await _getUrl(url!, params!);
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      confirmErrorConnect(
        onConfirm: () async {
          Get.back();
          completer.complete(await fetch(
            method: method,
            url: uri.path,
            timeout: timeout,
            onTimeout: onTimeout,
            headers: headers,
            body: body,
          ));
        },
        onCancel: () {
          Get.back();
          onError(REQUEST_ERROR.NO_INTERNET);
          completer.complete(Res(isConnectError: true));
        },
      );
    } else {
      await interceptorRequest();

      _mergeMaps(defaultBody, body);
      _mergeMaps(defaultHeaders, headers);

      responseInfo = new ResponseInfo(
        uri: uri,
        method: method!,
        params: params,
        headers: defaultHeaders!,
        body: defaultBody!,
      );

      final res = await _handleFetch(
        method: method,
        uri: uri,
        timeout: timeout ?? defaultTimeout,
        onTimeout: onTimeout ?? onError,
        headers: defaultHeaders!,
        body: defaultBody!,
        images: images!,
      );

      completer.complete(res);
    }

    return await completer.future;
  }

  Future<Uri> _getUrl(String url, Map<String, dynamic> params) async {
    Uri? uriParsed = Uri.tryParse(url);

    // if url is path, using base url
    if (!uriParsed!.hasScheme) {
      uriParsed = Uri.tryParse(baseUrl!);
      uriParsed = uriParsed!.resolve(url);
    }

    // convert params has value is int, list, object to string
    params.forEach((key, value) {
      if (value is List || value is Map) {
        params[key] = json.encode(value);
      } else if (value is int) {
        params[key] = value.toString();
      }
    });

    uriParsed = uriParsed.replace(queryParameters: params);

    return uriParsed;
  }

  Future<Res> _handleFetch({
    String? method,
    Uri? uri,
    int? timeout,
    Function(REQUEST_ERROR)? onTimeout,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    List<File>? images,
  }) async {
    Completer completer = new Completer<Res>();

    try {
      var request;
      if (images != null && images.length != 0) {
        for (var file in images) {
          request = http.MultipartRequest(
            method!,
            uri!,
          );
          request.files.add(
            http.MultipartFile(
              'image',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split("/").last,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.fields.addAll(body);
        }
      } else {
        request = http.Request(method!, uri!);
        body!.addAll(defaultBody!);
        request.body = json.encode(body);
      }
      //request = http.Request(method, uri);
      headers!.addAll(defaultHeaders!);
      request.headers.addAll(headers);
      http.StreamedResponse res = await request
          .send()
          .timeout(Duration(seconds: timeout!), onTimeout: () async {
        _currentTimeRetry++;

        if (_currentTimeRetry >= maxTimeRetry!) {
          _currentTimeRetry = 0;
          final response = Res(
            httpCode: null,
            body: null,
            isMap: null,
            isConnectError: true,
          );

          onTimeout!(REQUEST_ERROR.TIMEOUT);

          confirmErrorConnect(
            onConfirm: () async {
              Get.back();
              completer.complete(await _handleFetch(
                method: method,
                uri: uri,
                timeout: timeout,
                onTimeout: onTimeout,
                headers: headers,
                body: body,
              ));
            },
            onCancel: () async {
              Get.back();
              completer.complete(await _handleResponse(response));
            },
          );
        } else {
          var nextTimeRequest = await _handleFetch(
            method: method,
            uri: uri,
            timeout: timeout,
            onTimeout: onTimeout,
            headers: headers,
            body: body,
          );

          completer.complete(nextTimeRequest);
        }

        return null;
      });

      String responseBodyString = await res.stream.bytesToString();
      dynamic resultBody;
      Res response = Res(
        httpCode: res.statusCode,
        isConnectError: false,
        isResponseError: res.statusCode != 200,
      );

      responseInfo!.response = responseBodyString;

      try {
        resultBody = json.decode(responseBodyString);
        response.isMap = true;
      } catch (e) {
        response.isMap = false;
        resultBody = responseBodyString;
      }

      response.body = resultBody;
      completer.complete(await _handleResponse(response));
    } catch (e) {
      print(e);
    }
    return await completer.future;
  }

  Future<Res> _handleResponse(Res response) async {
    bool isProduction = Foundation.kReleaseMode;

    if (enableDebugTool && !isProduction) {
      try {
        await http.post(
          Uri.parse(serverDebugTool + ':31331/add-response'),
          body: {
            'url': responseInfo!.uri.toString(),
            'method': responseInfo!.method,
            'headers': json.encode(responseInfo!.headers),
            'body': json.encode(responseInfo!.body),
            'params': json.encode(responseInfo!.params),
            'response': response.body is String
                ? response.body
                : json.encode(response.body),
          },
        );
      } catch (e) {
        print('please run http service tool');
      }
    }

    if (showDebug && !isProduction) {
      print('''\n
        =========== HTTP REQUEST ===========
PATH:      [${responseInfo!.method}] -> ${responseInfo!.uri!.path}
HEADER:    ${responseInfo!.headers}
BODY:      ${responseInfo!.body}
PARAMS:    ${responseInfo!.params}
RESPONSE:  ${response.body}
''');
      print('====================================\n');
    }

    return await interceptorResponse(response);
  }

  _mergeMaps(l, r) {
    if (r != null) {
      try {
        l.addAll(r);
      } catch (e) {
        print(e);
        print('merge failed');
      }
    }
  }

  void confirmErrorConnect({Function? onConfirm, Function? onCancel}) {
    Get.defaultDialog(
      title: 'Network error',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Can\'t connect to server, please try again!'),
      ),
      textCancel: 'Close',
      textConfirm: 'try again',
      confirmTextColor: Colors.white,
      onConfirm: (){
        onConfirm;
      },
      onCancel: (){
        onCancel;
      },
    );
  }
}

class Res {
  int? httpCode;
  dynamic body;
  bool isConnectError;
  bool isResponseError;
  bool? isMap;

  Res({
    this.httpCode,
    this.body,
    this.isConnectError = false,
    this.isResponseError = false,
    this.isMap = false,
  });
}

class ResponseInfo {
  final Uri? uri;
  final String? method;
  final Map<String, String>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? params;

  String? response;

  ResponseInfo({
    this.uri,
    this.method,
    this.headers,
    this.body,
    this.params,
  });
}
