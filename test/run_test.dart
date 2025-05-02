import 'package:test/test.dart';
import 'package:debug_output/debug_output.dart';
import 'package:std/std.dart' as std_std;

final testData = {
  'name': 'Joe',
  'url': null,
  'ids': [10, 20, 30, null],
  'desc': 'This is\na multiline\ntext',
  'enabled': true,
};

main() {
  group('Run', () {
    test('run1', () {
      echo(testData);
      dump(testData);
      echo(testData, title: 'testData');
      dump(testData, title: 'testData', type: 'json');
      echo(testData, title: 'testData', type: 'yaml');
      dump(testData, title: 'testData', type: 'yaml');
      dump(null, title: 'null', type: 'yaml');
      dump(123, title: 'integer', type: 'yaml');
      dump('A string', title: 'string', type: 'yaml');
      dump(['a', 'b', 'c'], title: 'list', type: 'yaml');
    });
    test('run2', () {
      String result;
      result = echo(testData);
      expect(
        result ==
            r'''
{name: Joe, url: null, ids: [10, 20, 30, null], desc: This is
a multiline
text, enabled: true}
''',
        isTrue,
      );
      result = echo(testData, type: 'json');
      expect(
        result ==
            r'''
{
  "name": "Joe",
  "url": null,
  "ids": [
    10,
    20,
    30,
    null
  ],
  "desc": "This is\na multiline\ntext",
  "enabled": true
}
''',
        isTrue,
      );
      result = echo(testData, type: 'yaml');
      expect(
        result ==
            r'''
[YAML]
name: Joe
url:
ids:
  - 10
  - 20
  - 30
  - null
desc: |-
  This is
  a multiline
  text
enabled: true
[/YAML]
''',
        isTrue,
      );
      result = dump(testData);
      expect(
        result ==
            std_std.pathExpand(r'''
[DEBUG] @ main.<anonymous closure>.<anonymous closure> (file:///$HOME/pub/debug_output/test/run_test.dart:79:16)
{name: Joe, url: null, ids: [10, 20, 30, null], desc: This is
a multiline
text, enabled: true}
'''),
        isTrue,
      );
    });
  });
}
