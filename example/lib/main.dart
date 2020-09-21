/*
 * @Description: example
 * @Author: ekibun
 * @Date: 2020-08-08 08:16:51
 * @LastEditors: ekibun
 * @LastEditTime: 2020-09-21 22:47:10
 */
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_iconv/flutter_iconv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_qjs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(brightness: Brightness.dark, elevation: 0),
        backgroundColor: Colors.grey[300],
        primaryColorBrightness: Brightness.dark,
      ),
      routes: {
        'home': (BuildContext context) => TestPage(),
      },
      initialRoute: 'home',
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String resp;

  TextEditingController _encoding = TextEditingController(text: "gbk");

  TextEditingController _controller = TextEditingController(text: "你好");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iconv test"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FlatButton(
                      child: Text("convert"),
                      onPressed: () async {
                        try {
                          resp = convert(utf8.encode(_controller.text), to: _encoding.text).toString();
                        } catch (e) {
                          resp = e.toString();
                        }
                        setState(() {});
                      }),
                  SizedBox(
                      child: TextField(
                        controller: _encoding,
                        decoration: null,
                      ),
                      width: 100),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey.withOpacity(0.1),
              constraints: BoxConstraints(minHeight: 200),
              child: TextField(
                  autofocus: true,
                  controller: _controller,
                  decoration: null,
                  expands: true,
                  maxLines: null),
            ),
            SizedBox(height: 16),
            Text("result:"),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.green.withOpacity(0.05),
              constraints: BoxConstraints(minHeight: 100),
              child: Text(resp ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
