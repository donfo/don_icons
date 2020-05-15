import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) {
  var file = File(arguments.first);
  if (!file.existsSync()) {
    print('Cannot find the file "${arguments.first}".');
  }

  var content = file.readAsStringSync();
  Map<String, dynamic> iconfont = json.decode(content);
  List<dynamic> icons = iconfont['glyphs'];
  Map<String, String> iconDefinitions = {};
  List<String> iconsDon = [];

  icons.forEach((icon) {
    var iconName = icon['font_class'].replaceAll('-', '_');
    var unicode = icon['unicode'];
    iconDefinitions[iconName] = generateIconDefinition(iconName, unicode);
    iconsDon.add('\'$iconName\': DonIcons.$iconName,');
  });

  List<String> generatedOutput = [
    'library don_icons;',
    '',
    "import 'package:flutter/widgets.dart';",
    '',
    '''
    class IconDataDon extends IconData {
      const IconDataDon(int codePoint) : super(codePoint, fontFamily: 'Iconfont', fontPackage: 'don_icons');
    }
    ''',
  ];

  generatedOutput.addAll([
    '',
    '// THIS FILE IS AUTOMATICALLY GENERATED!',
    '',
    'class DonIcons {',
  ]);

  generatedOutput.addAll(iconDefinitions.values);

  generatedOutput.add('}');

  generatedOutput.addAll([
    '',
    'const Map<String, IconData> DonIconsMap = <String, IconData>{',
  ]);

  generatedOutput.addAll(iconsDon);

  generatedOutput.add('};');

  File output = File('lib/don_icons.dart');
  output.writeAsStringSync(generatedOutput.join('\n'));
}

String generateIconDefinition(String iconName, String unicode) {
  return 'static const IconData $iconName = const IconDataDon(0x$unicode);';
}
