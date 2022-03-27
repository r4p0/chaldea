import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

const _buildDir = 'build/web';

class _FileInfo {
  final String fn;
  final File file;
  late final String initHash;
  late String content;
  late String newHash;

  _FileInfo(this.fn) : file = File('$_buildDir/$fn') {
    final _bytes = file.readAsBytesSync();
    newHash = initHash = md5.convert(_bytes).toString();
    content = utf8.decode(_bytes);
  }

  String updateHash() {
    return newHash = md5.convert(utf8.encode(content)).toString();
  }

  void save() {
    file.writeAsStringSync(content);
  }
}

void main() {
  // if any library uses differ loading... wtf

  final mainJs = _FileInfo('main.dart.js'),
      indexHtml = _FileInfo('index.html'),
      jsMap = _FileInfo('main.dart.js.map'),
      sw = _FileInfo('flutter_service_worker.js');

  print('[patch-web] patching "${mainJs.fn}"');
  int patched = 0;
  mainJs.content = mainJs.content.replaceAllMapped(
    RegExp(r'"https://fonts\.googleapis\.com|"https://fonts\.gstatic\.com'),
    (m) {
      final host = m.group(0)!;
      if (host == '"https://fonts.googleapis.com') {
        patched++;
        return '(window.isCNHost?"https://fonts.font.im":"https://fonts.googleapis.com")+"';
      } else if (host == '"https://fonts.gstatic.com') {
        patched++;
        return '(window.isCNHost?"https://fonts.gstatic.font.im":"https://fonts.gstatic.com")+"';
      } else {
        throw 'unknown host: <$host>';
      }
    },
  );
  mainJs.updateHash();
  print('[patch-web] patched $patched google fonts code lines.');

  final newMainJsFn = 'main.dart.${mainJs.newHash.substring(0, 8)}.js';

  for (final file in [
    indexHtml,
    jsMap,
    sw,
  ]) {
    print('Replacing "main.dart.js" to "$newMainJsFn" in file "${file.fn}"');
    file.content = file.content.replaceAll('main.dart.js', newMainJsFn);
    file.updateHash();
  }

  sw.content = sw.content
      .replaceAllMapped(RegExp(r'"([^"]+)":\s*"([0-9a-f]{32})"'), (match) {
    final fn = match.group(1)!;
    final oldHash = match.group(2)!;
    if (fn == 'index.html' || fn == '/') {
      print(
          'Updating hash "${fn.padRight(21)}": $oldHash -> ${indexHtml.newHash}');
      assert(oldHash == indexHtml.initHash);
      return '"$fn": "${indexHtml.newHash}"';
    } else if (fn == newMainJsFn) {
      print(
          'Updating hash "${fn.padRight(21)}": $oldHash -> ${mainJs.newHash}');
      assert(oldHash == mainJs.initHash);
      return '"$fn": "${mainJs.newHash}"';
    }
    return match.group(0)!;
  });
  indexHtml.save();
  mainJs.save();
  jsMap.save();
  mainJs.file.renameSync('$_buildDir/$newMainJsFn');
  sw.save();
  // File('build/web/flutter_sw2.js').writeAsStringSync(sw.content);
}
