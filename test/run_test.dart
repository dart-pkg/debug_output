import 'package:test/test.dart';
import 'package:debug_output/debug_output.dart';

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
        result,
        equals(r'''
{name: Joe, url: null, ids: [10, 20, 30, null], desc: This is
a multiline
text, enabled: true}
'''),
      );
      result = echo(testData, type: 'flatJson');
      expect(
        result,
        equals(r'''
{"name":"Joe","url":null,"ids":[10,20,30,null],"desc":"This is\na multiline\ntext","enabled":true}
'''),
      );
      result = echo(testData, type: 'json');
      expect(
        result,
        equals(r'''
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
'''),
      );
      result = echo(testData, type: 'yaml');
      expect(
        result,
        equals(r'''
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
'''),
      );
      result = dump(testData);
      expect(
        result,
        equals(r'''
[DEBUG] @ main.<anonymous closure>.<anonymous closure> (file:///D:/home11/pub/debug_output/test/run_test.dart:82:16)
{name: Joe, url: null, ids: [10, 20, 30, null], desc: This is
a multiline
text, enabled: true}
'''),
      );
    });
  });
}
