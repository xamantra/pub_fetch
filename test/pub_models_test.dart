import 'package:pub_api/src/index.dart';
import 'package:test/test.dart';

import 'queries.dart';

void main() {
  test('models.PubPackage', () async {
    var homepage = await PubAPI().homepage();
    var package = homepage.flutterFavorites.first;
    var json = package.toRawJson();
    var parsedPackage = PubHomepagePackage.fromRawJson(json);
    expect(json != null, true);
    expect(package == parsedPackage, true);
    expect(package.hashCode == parsedPackage.hashCode, true);
    expect(package.toString() == parsedPackage.toString(), true);
  });

  test('models.PubHomepage', () async {
    var homepage = await PubAPI().homepage();
    var json = homepage.toRawJson();
    var parsedHomepage = PubHomepage.fromRawJson(json);
    expect(json != null, true);
    expect(homepage == parsedHomepage, true);
    expect(homepage.hashCode == parsedHomepage.hashCode, true);
    expect(homepage.toString() == parsedHomepage.toString(), true);
  });

  test('models.PubPackageList', () async {
    var pubPackageList = await PubAPI().search(randomQuery());
    var json = pubPackageList.toRawJson();
    var parsedPubPackageList = PubPackageList.fromRawJson(json);
    expect(json != null, true);
    expect(pubPackageList == parsedPubPackageList, true);
    expect(pubPackageList.hashCode == pubPackageList.hashCode, true);
    expect(pubPackageList.toString() == pubPackageList.toString(), true);
  });

  test('models.PubPackage', () async {
    var pubPackageList = await PubAPI().search(randomQuery());
    var package = pubPackageList.packages.last;
    var json = package.toRawJson();
    var parsedPackage = PubPackage.fromRawJson(json);
    expect(json != null, true);
    expect(package == parsedPackage, true);
    expect(package.hashCode == package.hashCode, true);
    expect(package.toString() == package.toString(), true);
  });
}
