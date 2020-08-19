import 'package:pub_api/src/index.dart';
import 'package:test/test.dart';

import 'queries.dart';

const timeout = Timeout(Duration(seconds: 3600));

void main() {
  test('internals.groupFlutterPlatforms(...)', () {
    var result1 = groupFlutterPlatforms([
      FlutterPlatform.android,
      FlutterPlatform.ios,
    ]);
    expect(result1, '&platform=android+ios');

    var result2 = groupFlutterPlatforms([
      FlutterPlatform.android,
      FlutterPlatform.ios,
      FlutterPlatform.web,
    ]);
    expect(result2, '&platform=android+ios+web');

    var result3 = groupFlutterPlatforms([
      FlutterPlatform.ios,
      FlutterPlatform.web,
      FlutterPlatform.ios,
    ]);
    expect(result3, '&platform=ios+web');
  });

  test('internals.groupDartRuntimes(...)', () {
    var result1 = groupDartRuntimes([
      DartRuntime.native,
      DartRuntime.js,
    ]);
    expect(result1, '&runtime=native+js');

    var result2 = groupDartRuntimes([DartRuntime.native]);
    expect(result2, '&runtime=native');

    var result3 = groupDartRuntimes([
      DartRuntime.js,
      DartRuntime.native,
      DartRuntime.native,
    ]);
    expect(result3, '&runtime=js+native');
  });

  test('internals.getSortParam(...)', () {
    for (var sort in PackageSort.values) {
      var result = getSortParam(sort);
      switch (sort) {
        case PackageSort.relevance:
          expect(result, '');
          break;
        case PackageSort.overallScore:
          expect(result, '&sort=top');
          break;
        case PackageSort.recentlyUpdated:
          expect(result, '&sort=updated');
          break;
        case PackageSort.newestPackage:
          expect(result, '&sort=created');
          break;
        case PackageSort.mostLikes:
          expect(result, '&sort=like');
          break;
        case PackageSort.mostPubPoints:
          expect(result, '&sort=points');
          break;
        case PackageSort.popularity:
          expect(result, '&sort=popularity');
          break;
      }
    }
  });

  test('api.homepage()', () async {
    for (var i = 0; i < 10; i++) {
      print('[${i + 1}] api.homepage()');
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
    }
  }, timeout: timeout);

  test('api.search(...)', () async {
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
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
    }
  }, timeout: timeout);

  test('api.nextPage(...)', () async {
    var api = PubAPI();
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
      print('Testing with query "$query"');
      var current = await api.search(query);
      var result = await api.nextPage(current);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(result.currentPage, 2);
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var valid = validPackage(package);
        if (!valid) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(valid, true);
      }
    }
  }, timeout: timeout);

  test('api.searchFlutter(...)', () async {
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
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
    }
  }, timeout: timeout);

  test('api.searchFlutter(..., [sortBy])', () async {
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
      for (var sortBy in PackageSort.values) {
        print('Testing with query "$query", [$sortBy]');
        var result = await PubAPI().searchFlutter(query, sortBy: sortBy);
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
      }
    }
  }, timeout: timeout);

  test('api.searchFlutter(..., [platforms])', () async {
    var platforms = [
      FlutterPlatform.android,
      FlutterPlatform.ios,
      FlutterPlatform.web,
    ];
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
      print('Platform search "$query": "${groupFlutterPlatforms(platforms)}"');
      var result = await PubAPI().searchFlutter(query, platforms: platforms);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var androidSupport = package.flutterAndroidSupport;
        var iOSSupport = package.flutterIOSSupport;
        var webSupport = package.flutterWebSupport;
        var fullySupported = androidSupport && iOSSupport && webSupport;
        if (!fullySupported) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(fullySupported, true);
      }
    }
  }, timeout: timeout);

  test('api.searchDart(...)', () async {
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
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
    }
  }, timeout: timeout);

  test('api.searchDart(..., [sortBy])', () async {
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
      for (var sortBy in PackageSort.values) {
        print('Testing with query "$query", [$sortBy]');
        var result = await PubAPI().searchDart(query, sortBy: sortBy);
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
      }
    }
  }, timeout: timeout);

  test('api.searchDart(..., [runtimes])', () async {
    var runtimes = [
      DartRuntime.native,
      DartRuntime.js,
    ];
    var shuffledQueries = queries..shuffle();
    for (var i = 0; i < shuffledQueries.length; i++) {
      var query = shuffledQueries[i];
      print('Testing runtime search: "${groupDartRuntimes(runtimes)}"');
      var result = await PubAPI().searchDart(query, dartRuntimes: runtimes);
      expect(result != null, true);
      expect(result, isA<PubPackageList>());
      expect(validPackageList(result), true);
      for (var package in result.packages) {
        var nativeSupport = package.dartNativeSupport;
        var jsSupport = package.dartJSSupport;
        var fullySupported = nativeSupport && jsSupport;
        if (!fullySupported) {
          print('INVALID PACKAGE (test will fail): $package');
        }
        expect(fullySupported, true);
      }
    }
  }, timeout: timeout);
}
