/// The base url of `pub.dev`.
const String host = 'https://pub.dev';

/* HTML Selectors */

/// Homepage `Flutter Favorites` html items selector.
const String flutterFavoritesSelector = '.home-block-ff .mini-list-item';

/// Homepage `Most Popular` html items selector.
const String mostPopularSelector = '.home-block-mp .mini-list-item';

/// Homepage `Top Flutter` html items selector.
const String topFlutterSelector = '.home-block-tf .mini-list-item';

/// Homepage `Top Dart` html items selector.
const String topDartSelector = '.home-block-td .mini-list-item';

/// Homepage `package name` selector.
const String miniNameSelector = '.mini-list-item .mini-list-item-title';

/// Homepage `package description` selector.
const String miniDescSelector = '.mini-list-item .mini-list-item-description';

/// Homepage `package publisher name` selector.
const String miniPubSelector = '.mini-list-item-publisher .publisher-link';

/// Total results count in search or in package listing.
const String packageListingTotalItems = '.listing-info-count > span.count';

/// pub.dev package listing html `package item` selector.
const String pkgItem = '.packages-item';

/// pub.dev package listing html package item `title` selector.
const String pkgTitle = '.packages-title > a';

/// pub.dev package listing html package item `description` selector.
const String pkgDescription = '.packages-description';

/// pub.dev package listing html package item `version` selector.
const String pkgVersion = '.packages-metadata > span:nth-child(1) > a';

/// pub.dev package listing html package item `publisher domain` selector.
const String pkgPublisher = '.packages-metadata > span:nth-child(2) > a';

/// pub.dev package listing html package item `date published` selector.
const String pkgPublished = '.packages-metadata > span:nth-child(1) > span';

/// pub.dev package listing html package item `platform tags` selector.
const String pkgTags = '.-pub-tag-badge span';

/// pub.dev package listing html package item `likes` selector.
const String pkgLikes = '.packages-score-like .packages-score-value-number';

/// pub.dev package listing html package item `pub points` selector.
const String pkgPoints = '.packages-score-health .packages-score-value-number';

/// pub.dev package listing html package item `popularity` selector.
// ignore: lines_longer_than_80_chars
const String pkgPopularity = '.packages-score-popularity .packages-score-value-number';

/// pub.dev package listing html package item `flutter favorite` selector.
const String pkgFlutterFavorite = '.packages-metadata > .package-badge';

/* HTML Selectors */
