import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'index.dart';

/// `pub.dev` package list page.
///
/// Used in search or featured list.
@immutable
class PubPackageList extends Equatable {
  /// Returns non-null string value
  /// if this package list is from a search page.
  final String searchQuery;

  /// The parameter used for this package
  /// list to fetch is stored for pagination.
  final PubPackageListParams params;

  /// Current page number for pagination.
  final int currentPage;

  /// Total number of packages.
  final int totalPackagesCount;

  /// The packages in this current page.
  ///
  /// Max: `10`.
  final List<PubPackage> packages;

  /// Total number of pages for pagination.
  int get totalPageCount {
    var pageCount = (totalPackagesCount / 10).round();
    if ((pageCount * 10) < totalPackagesCount) {
      pageCount += 1;
    }
    return pageCount;
  }

  /// `pub.dev` package list page.
  ///
  /// Used in search or featured list.
  PubPackageList({
    @required this.searchQuery,
    @required this.currentPage,
    @required this.totalPackagesCount,
    @required this.packages,
    @required this.params,
  });

  /// Convert this data into JSON.
  Map<String, dynamic> toJson() {
    return {
      'searchQuery': searchQuery,
      'currentPage': currentPage,
      'totalPackagesCount': totalPackagesCount,
      'packages': packages?.map((x) => x?.toJson())?.toList(),
      'params': params?.toJson(),
    };
  }

  /// Parse JSON data and convert to type `PubPackageList`.
  factory PubPackageList.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return PubPackageList(
      searchQuery: map['searchQuery'],
      currentPage: map['currentPage'],
      totalPackagesCount: map['totalPackagesCount'],
      packages: List<PubPackage>.from(
        map['packages']?.map((x) => PubPackage.fromJson(x)),
      ),
      params: PubPackageListParams.fromJson(map['params']),
    );
  }

  /// Convert this data into raw string JSON.
  ///
  /// Useful for saving in local storage in front-end apps.
  String toRawJson() => json.encode(toJson());

  /// Parse raw string JSON data and convert to type `PubPackageList`.
  ///
  /// Useful for retrieving saved data from local storage
  /// in front-end apps.
  factory PubPackageList.fromRawJson(String source) {
    return PubPackageList.fromJson(json.decode(source));
  }

  @override
  List<Object> get props => [
        searchQuery,
        currentPage,
        totalPackagesCount,
        packages,
        totalPageCount,
        params,
      ];

  @override
  bool get stringify => true;
}
