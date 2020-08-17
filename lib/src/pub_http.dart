import 'package:dio/dio.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

import 'index.dart';

/// Http service for fetching pub.dev pages.
class PubHttp {
  /// Http client use for sending http requests and receiving responses.
  final Dio dio = Dio(
    BaseOptions(
      responseType: ResponseType.plain,
    ),
  );

  /// Get the `HtmlDocument` from a certain pub.dev page.
  ///
  /// Defaults to root page (homepage) if not specified.
  Future<HtmlDocument> getHtml([String pubPath]) async {
    var result = await dio.get('$host${pubPath ?? ""}');
    var html = parseHtmlDocument(result.data);
    return html;
  }
}
