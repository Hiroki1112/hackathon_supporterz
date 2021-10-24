import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:webview_flutter/webview_flutter.dart';

class BodyCard extends StatefulWidget {
  const BodyCard({
    Key? key,
    required this.rawText,
  }) : super(key: key);
  final String rawText;

  @override
  _BodyCardState createState() => _BodyCardState();
}

class _BodyCardState extends State<BodyCard> {
  late final WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkShadow,
            spreadRadius: 1.0,
            blurRadius: 3.0,
            offset: const Offset(1, 2),
          ),
        ],
        color: AppTheme.white,
      ),
      child: Container(
        // TextFormFirldは一行あたり25らしい
        height: 500,
        padding: const EdgeInsets.all(10),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
            await _loadHTML();
          },
        ),
      ),
    );
  }

  Future _loadHTML() async {
    String previewHTML =
        '<body>' + md.markdownToHtml(widget.rawText) + '</body>';
    // iOSの場合、メタタグを付けないとテキストが小さくなるため、
    // Headerにメタタグを追加する
    String header =
        '<head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>';
    previewHTML += header;
    _controller.loadUrl(
      Uri.dataFromString(
        previewHTML,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}
