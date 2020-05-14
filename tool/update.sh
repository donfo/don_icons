#!/usr/bin/env bash
if [ -e ./icons.json ];
then 
echo "Custom icons.json found, using local data only."

dart ./tool/generate_font.dart ./icons.json
dart ./tool/generate_example.dart ./icons.json
dartfmt -w ./lib/font_awesome_flutter.dart
dartfmt -w ./example/lib/icons.dart

else
echo "Updating icons to newest version."
pushd lib/fonts/

curl -L -o iconfont.ttf "https://at.alicdn.com/t/font_1818548_mxi10nekbu.ttf"

popd

curl -o /tmp/icons.json "https://at.alicdn.com/t/font_1818548_mxi10nekbu.json"

dart ./tool/generate_font.dart /tmp/icons.json
dart ./tool/generate_example.dart /tmp/icons.json
dartfmt -w ./lib/don_icons.dart
dartfmt -w ./example/lib/icons.dart

rm /tmp/icons.json
fi
