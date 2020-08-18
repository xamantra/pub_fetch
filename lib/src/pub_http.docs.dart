import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart';

/// Docs for [`PubHttp`].
abstract class PubHttpDocs {
  /// Http client use for sending http requests and receiving responses.
  Dio dio;

  /// Get the `HtmlDocument` from a certain pub.dev page.
  ///
  /// Defaults to root page (homepage) if not specified.
  Future<HtmlDocument> getHtml([String pubPath]);

  /// Get the `HtmlDocument` of pub.dev search results.
  ///
  /// The parameter `name` must NOT be null or empty.
  Future<HtmlDocument> searchPackage({
    @required String query,
    int page = 1,
  });
}
