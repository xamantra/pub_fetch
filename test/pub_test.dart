import 'package:pub/src/index.dart';
import 'package:pub/src/index.dart' as pub;
import 'package:test/test.dart';

void main() {
  test('homepage', () async {
    var homepage = await pub.homepage();
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
