/// Real world search queries.
final List<String> queries = [
  'state management',
  'fancy appbar',
  'dialogs',
  'custom time picker',
  'calendar library',
  'encryption',
  'security',
  'fancy buttons',
  'formatter',
  'json',
  'html',
  'xml',
];

String randomQuery() {
  return (queries..shuffle()).first;
}
