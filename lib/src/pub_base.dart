import 'package:dio/dio.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

import 'index.dart';

class _HttpService {
  final Dio dio = Dio(
    BaseOptions(
      responseType: ResponseType.plain,
    ),
  );

  Future<HtmlDocument> getHtml([String pubPath]) async {
    var result = await dio.get('$host${pubPath ?? ""}');
    var html = parseHtmlDocument(result.data);
    return html;
  }
}

final _service = _HttpService();

List<PubPackage> _getHomepagePackages(
  HtmlDocument html,
  String sectionSelector,
) {
  var flutterFavoriteItems = html.querySelectorAll(sectionSelector);
  var flutterFavorites = <PubPackage>[];
  for (var item in flutterFavoriteItems) {
    var name = item.querySelector(miniNameSelector)?.text;
    var url = item.querySelector(miniNameSelector)?.getAttribute('href');
    var description = item.querySelector(miniDescSelector)?.text;
    var publisher = item.querySelector(miniPubSelector)?.text;
    flutterFavorites.add(
      PubPackage(
        name: name,
        url: url,
        description: description,
        publisher: publisher,
      ),
    );
  }
  return flutterFavorites;
}

/// Get `pub.dev` homepage data. The homepage features popular packages.
Future<PubHomepage> homepage() async {
  var html = await _service.getHtml();
  var flutterFavorites = _getHomepagePackages(html, flutterFavoritesSelector);
  var mostPopularPackages = _getHomepagePackages(html, mostPopularSelector);
  var topFlutterPackages = _getHomepagePackages(html, topFlutterSelector);
  var topDartPackages = _getHomepagePackages(html, topDartSelector);
  return PubHomepage(
    flutterFavorites: flutterFavorites,
    mostPopularPackages: mostPopularPackages,
    topFlutterPackages: topFlutterPackages,
    topDartPackages: topDartPackages,
  );
}
