import 'index.dart';

/// The wrapper for pub.dev scraper methods.
class PubAPI {
  /// The wrapper for pub.dev scraper methods.
  PubAPI({
    this.connectTimeout,
    this.receiveTimeout,
    this.sendTimeout,
  });

  /// Timeout in milliseconds for opening url.
  /// [Dio] will throw the [DioError] with [DioErrorType.CONNECT_TIMEOUT] type
  ///  when time out.
  final int connectTimeout;

  ///  Timeout in milliseconds for receiving data.
  ///  [Dio] will throw the [DioError] with [DioErrorType.RECEIVE_TIMEOUT] type
  ///  when time out.
  ///
  /// [0] meanings no timeout limit.
  final int receiveTimeout;

  /// Timeout in milliseconds for sending data.
  /// [Dio] will throw the [DioError] with [DioErrorType.SEND_TIMEOUT] type
  ///  when time out.
  final int sendTimeout;

  PubHttp _service;

  void _initService() {
    if (_service != null) return;
    _service = PubHttp(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Get `pub.dev` homepage data. The homepage features popular packages.
  Future<PubHomepage> homepage() async {
    _initService();
    var html = await _service.getHtml();
    var flutterFavorites = getHomepagePackages(html, flutterFavoritesSelector);
    var mostPopularPackages = getHomepagePackages(html, mostPopularSelector);
    var topFlutterPackages = getHomepagePackages(html, topFlutterSelector);
    var topDartPackages = getHomepagePackages(html, topDartSelector);
    return PubHomepage(
      flutterFavorites: flutterFavorites,
      mostPopularPackages: mostPopularPackages,
      topFlutterPackages: topFlutterPackages,
      topDartPackages: topDartPackages,
    );
  }

  /// Search packages.
  Future<PubPackageList> search(String query) async {
    _initService();
    var html = await _service.searchPackage(query: query);
    var packages = getPackages(html, pkgItem);
    var totalPackagesCount = getPackagesCount(html, packageListingTotalItems);
    var result = PubPackageList(
      searchQuery: query,
      currentPage: 1,
      totalPackagesCount: totalPackagesCount,
      packages: packages,
    );
    return result;
  }
}
