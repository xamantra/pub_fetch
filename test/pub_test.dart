import 'package:pub_api/src/index.dart';
import 'package:pub_api/src/index.dart' as pub;
import 'package:test/test.dart';

void main() {
  test('api.homepage()', () async {
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

  test('models.PubPackage', () {
    var dummyPackage = PubPackage(
      name: 'dummy_package',
      url: 'dummy_package',
      description: 'dummy_package',
      publisher: 'dummy_package',
    );
    var json = dummyPackage.toRawJson();
    var parsedPackage = PubPackage.fromRawJson(json);
    expect(json != null, true);
    expect(dummyPackage == parsedPackage, true);
    expect(dummyPackage.hashCode == parsedPackage.hashCode, true);
    expect(dummyPackage.toString() == parsedPackage.toString(), true);
  });

  test('models.PubHomepage', () {
    var dummyPackage = PubPackage(
      name: 'dummy_package',
      url: 'dummy_package',
      description: 'dummy_package',
      publisher: 'dummy_package',
    );
    var dummyHomepage = PubHomepage(
      flutterFavorites: [dummyPackage],
      mostPopularPackages: [dummyPackage],
      topFlutterPackages: [dummyPackage],
      topDartPackages: [dummyPackage],
    );
    var json = dummyHomepage.toRawJson();
    var parsedHomepage = PubHomepage.fromRawJson(json);
    expect(json != null, true);
    expect(dummyHomepage == parsedHomepage, true);
    expect(dummyHomepage.hashCode == parsedHomepage.hashCode, true);
    expect(dummyHomepage.toString() == parsedHomepage.toString(), true);
  });
}
