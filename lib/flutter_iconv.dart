/*
 * @Description: 
 * @Author: ekibun
 * @Date: 2020-09-21 20:11:37
 * @LastEditors: ekibun
 * @LastEditTime: 2020-09-21 22:14:45
 */
import 'dart:ffi';

import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

final DynamicLibrary iconvLib = Platform.environment['FLUTTER_TEST'] == 'true'
    ? (Platform.isWindows
        ? DynamicLibrary.open("test/build/Debug/flutter_iconv.dll")
        : DynamicLibrary.process())
    : (Platform.isWindows
        ? DynamicLibrary.open("flutter_iconv_plugin.dll")
        : Platform.isAndroid
            ? DynamicLibrary.open("libiconv.so")
            : DynamicLibrary.process());

/// const char *convert(char *from, char *to, int32_t fatal, char *str)
final Pointer<Utf8> Function(
  Pointer<Utf8> from,
  Pointer<Utf8> to,
  int fatal,
  Pointer<Uint8> str,
) _convert = iconvLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Pointer<Utf8>,
      Pointer<Utf8>,
      Int32,
      Pointer<Uint8>,
    )>>("convert")
    .asFunction();

/// void freeChar(char *str)
final void Function(
  Pointer str,
) _freeChar = iconvLib
    .lookup<
        NativeFunction<
            Void Function(
      Pointer,
    )>>("freeChar")
    .asFunction();

Uint8List convert(Uint8List str, {String from, String to, bool fatal}) {
  var ptr = allocate<Uint8>(count: str.length + 1);
  var byteList = ptr.asTypedList(str.length + 1);
  byteList.setAll(0, str);
  byteList[str.length] = 0;
  var utf8from = Utf8.toUtf8(from ?? "utf-8");
  var utf8to = Utf8.toUtf8(to ?? "utf-8");
  var retStr = _convert(utf8from, utf8to, fatal == true ? 1 : 0, ptr);
  var length = Utf8.strlen(retStr);
  var ret = Uint8List.fromList(retStr.cast<Uint8>().asTypedList(length));
  free(ptr);
  free(utf8from);
  free(utf8to);
  _freeChar(retStr);
  return ret;
}
