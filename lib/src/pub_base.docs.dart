import 'index.dart';

/// Docs for [PubAPI].
abstract class PubAPIDocs {
  /// Timeout in milliseconds for opening url.
  /// [Dio] will throw the [DioError] with [DioErrorType.CONNECT_TIMEOUT] type
  ///  when time out.
  int get connectTimeout;

  ///  Timeout in milliseconds for receiving data.
  ///  [Dio] will throw the [DioError] with [DioErrorType.RECEIVE_TIMEOUT] type
  ///  when time out.
  ///
  /// [0] meanings no timeout limit.
  int get receiveTimeout;

  /// Timeout in milliseconds for sending data.
  /// [Dio] will throw the [DioError] with [DioErrorType.SEND_TIMEOUT] type
  ///  when time out.
  int get sendTimeout;

  /// Get `pub.dev` homepage data. The homepage features popular packages.
  void homepage();

  /// Search packages compatible with any SDKs.
  Future<PubPackageList> search(String query);

  /// Search packages compatible with `Flutter` SDKs.
  Future<PubPackageList> searchFlutter(String query);

  /// Search packages compatible with `Dart` SDKs.
  Future<PubPackageList> searchDart(String query);
}
