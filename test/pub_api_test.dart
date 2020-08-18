import 'package:pub_api/src/index.dart';
import 'package:test/test.dart';

import 'queries.dart';

void main() {
  // Repeat test 10 times
  for (var i = 0; i < 10; i++) {
    test('[${i + 1}] api.homepage()', () async {
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
  }

  // Repeat test for all query available
  var shuffledQueries = queries..shuffle();
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.search("$query")', () async {
      print('Testing with query "$query"');
      var result = await PubAPI().search(query);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = validPackage(package);
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    });
  }

  // Repeat test for all query available
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.searchFlutter("$query")', () async {
      print('Testing with query "$query"');
      var result = await PubAPI().searchFlutter(query);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = package.flutterSupport;
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    });
  }

  // Repeat test for all query available
  for (var i = 0; i < shuffledQueries.length; i++) {
    var query = shuffledQueries[i];
    test('[${i + 1}] api.searchDart("$query")', () async {
      print('Testing with query "$query"');
      var result = await PubAPI().searchDart(query);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = package.dartSupport;
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    });
  }
}
