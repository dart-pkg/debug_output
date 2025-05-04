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

String _toPrintable(dynamic x, String? type) {
  if (type != null) {
    type = type.toLowerCase();
  }
  try {
    return switch (type) {
      'flatjson' => text_serializer.toJson(x),
      'flat_json' => text_serializer.toJson(x),
      'json' => text_serializer.toJson(x, '  '),
      'yaml' => '[YAML]\n${text_serializer.toYaml(x)}[/YAML]',
      _ => (x is String) ? '`$x`' : '$x',
    };
  } catch (_) {
    return (x is String) ? '`$x`' : '$x';
  }
}

String echo(dynamic x, {String? title, bool silent = false, String? type}) {
  String printable = _toPrintable(x, type);
  String output;
  if (title == null) {
    output = printable;
  } else {
    output = '$title ==> $printable';
  }
  output = _adjustTextNewlines(output);
  if (!silent) {
    print(output);
  }
  return '$output\n';
}

String dump(dynamic x, {String? title, bool silent = false, String? type}) {
  String printable = _toPrintable(x, type);
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
    output = '[$mode] $lineInfo\n$printable';
  } else {
    output = '[$mode] $lineInfo\n$title ==> $printable';
  }
  output = _adjustTextNewlines(output);
  if (!silent) {
    print(output);
  }
  return '$output\n';
}
