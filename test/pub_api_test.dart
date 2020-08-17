import 'package:pub_api/src/index.dart';
import 'package:test/test.dart';

import 'queries.dart';

void main() {
  test('api.homepage()', () async {
    var homepage = await PubAPI().homepage();
    expect(homepage != null, true);
    expect(homepage, isA<PubHomepage>());
    expect(validHomepage(homepage), true);
    for (var flutterFavorite in homepage.flutterFavorites) {
      expect(validHomepagePackage(flutterFavorite), true);
    }
    for (var mostPopular in homepage.mostPopularPackages) {
      expect(validHomepagePackage(mostPopular), true);
    }
    for (var topFlutter in homepage.topFlutterPackages) {
      expect(validHomepagePackage(topFlutter), true);
    }
    for (var topDart in homepage.topDartPackages) {
      expect(validHomepagePackage(topDart), true);
    }
  });

  test('api.search(...)', () async {
    var result = await PubAPI().search(randomQuery());
    expect(result != null, true);
    expect(result, isA<PubPackageList>());
    expect(validPackageList(result), true);
    for (var package in result.packages) {
      expect(validPackage(package), true);
    }
  });
}
