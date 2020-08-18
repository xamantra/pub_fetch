import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

import 'index.dart';

/// Http service for fetching pub.dev pages.
class PubHttp extends PubHttpDocs {
  /// Http service for fetching pub.dev pages.
  PubHttp({
    int connectTimeout,
    int receiveTimeout,
    int sendTimeout,
  })  : _connectTimeout = connectTimeout,
        _receiveTimeout = receiveTimeout,
        _sendTimeout = sendTimeout;
  final int _connectTimeout;
  final int _receiveTimeout;
  final int _sendTimeout;

  void _initDio() {
    if (dio != null) return;
    dio = Dio(
      BaseOptions(
        responseType: ResponseType.plain,
        connectTimeout: _connectTimeout ?? 10000,
        receiveTimeout: _receiveTimeout ?? 10000,
        sendTimeout: _sendTimeout ?? 10000,
      ),
    );
  }

  Future<HtmlDocument> getHtml([String pubPath]) async {
    _initDio();
    var result = await dio.get('$host${pubPath ?? ""}');
    var html = parseHtmlDocument(result.data);
    return html;
  }

  Future<HtmlDocument> searchPackage({
    @required String query,
    int page = 1,
    PackageType packageType = PackageType.any,
    List<FlutterPlatform> flutterPlatforms,
    List<DartRuntime> dartRuntimes,
    PackageSort sortBy = PackageSort.relevance,
  }) async {
    if (query == null || query.isEmpty) {
      throw PubError('Search query is required when searching.');
    }
    _initDio();
    var type = '';
    switch (packageType ?? PackageType.any) {
      case PackageType.dart:
        type = '/dart';
        break;
      case PackageType.flutter:
        type = '/flutter';
        break;
      default:
        break;
    }
    var platforms = groupFlutterPlatforms(flutterPlatforms);
    var runtimes = groupDartRuntimes(dartRuntimes);
    var sort = getSortParam(sortBy);
    var result = await dio.get('$host$type/packages?q=$query&page=$page$platforms$runtimes$sort');
    var html = parseHtmlDocument(result.data);
    return html;
  }
}
