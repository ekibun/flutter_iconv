/*
 * @Description: 
 * @Author: ekibun
 * @Date: 2020-09-06 13:02:46
 * @LastEditors: ekibun
 * @LastEditTime: 2020-09-21 22:29:21
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter_iconv/flutter_iconv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('make', () async {
    final utf8Encoding = Encoding.getByName('utf-8');
    final cmakePath =
        "C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe";
    final buildDir = "./build";
    var result = Process.runSync(
      cmakePath,
      ['-S', './', '-B', buildDir],
      workingDirectory: 'test',
      stdoutEncoding: utf8Encoding,
      stderrEncoding: utf8Encoding,
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    expect(result.exitCode, 0);

    result = Process.runSync(
      cmakePath,
      ['--build', buildDir, '--verbose'],
      workingDirectory: 'test',
      stdoutEncoding: utf8Encoding,
      stderrEncoding: utf8Encoding,
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    expect(result.exitCode, 0);
  });
  test('convert', () async {
    var list = convert(utf8.encode("你好"), to: "gbk");
    expect(utf8.decode(convert(list, from: "gbk")), "你好");
  });
}
