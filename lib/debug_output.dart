import 'dart:core';
import 'dart:convert' as dart_convert;
import 'package:text_serializer/text_serializer.dart' as text_serializer;

bool get _isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

List<String> _textToLines(String s) {
  const splitter = dart_convert.LineSplitter();
  final $lines = splitter.convert(s);
  return $lines;
}

/// Replace non-unix new lines in a string to unix newlines
String _adjustTextNewlines(String s) {
  s = s.replaceAll('\r\n', '\n');
  s = s.replaceAll('\r', '\n');
  return s;
}

String echo(dynamic x, {String? title, bool silent = false, String? type}) {
  String json = switch (type) {
    'json' => text_serializer.toJson(x, '  '),
    'yaml' => '[YAML]\n${text_serializer.toYaml(x)}[/YAML]',
    _ => (x is String) ? '`$x`' : '$x',
  };
  String output;
  if (title == null) {
    output = json;
  } else {
    output = '$title ==> $json';
  }
  output = _adjustTextNewlines(output);
  if (!silent) {
    print(output);
  }
  return '$output\n';
}

String dump(dynamic x, {String? title, bool silent = false, String? type}) {
  String json = switch (type) {
    'json' => text_serializer.toJson(x, '  '),
    'yaml' => '[YAML]\n${text_serializer.toYaml(x)}[/YAML]',
    _ => (x is String) ? '`$x`' : '$x',
  };
  final lines = _textToLines(StackTrace.current.toString());
  String line = '';
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('debug_output/debug_output.dart')) {
      line = lines[i + 1];
      break;
    }
  }
  if (line.startsWith('#')) {
    final reg = RegExp(r'#[0-9]+[ ]+');
    line = line.replaceFirst(reg, '');
  }
  final lineInfo = '@ $line';
  String mode = _isInDebugMode ? 'DEBUG' : 'RELEASE';
  String output;
  if (title == null) {
    output = '[$mode] $lineInfo\n$json';
  } else {
    output = '[$mode] $lineInfo\n$title ==> $json';
  }
  output = _adjustTextNewlines(output);
  if (!silent) {
    print(output);
  }
  return '$output\n';
}
