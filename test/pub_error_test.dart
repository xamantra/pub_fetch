import 'package:pub_fetch/src/index.dart';
import 'package:test/test.dart';

void main() {
  test('api.search(...)', () async {
    try {
      await PubAPI().search('');
    } on dynamic catch (e) {
      expect(e, isA<PubError>());
      expect(e.toString() != null, true);
      expect(
        e.toString().contains('Search query is required when searching.'),
        true,
      );
    }
  });
}
