<!--
 * @Description: readme
 * @Author: ekibun
 * @Date: 2020-09-21 19:39:30
 * @LastEditors: ekibun
 * @LastEditTime: 2020-09-21 22:27:42
-->
# flutter_iconv

iconv library for flutter.

## Getting Started

This project is a [iconv](https://www.gnu.org/software/libiconv/) library for Flutter.

Use this plugin with utf8codec

```Dart
var list = convert(utf8.encode("你好"), to: "gbk");
expect(utf8.decode(convert(list, from: "gbk")), "你好");
```
