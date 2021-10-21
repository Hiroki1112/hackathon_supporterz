import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;

class DetailBodyCard extends StatelessWidget {
  const DetailBodyCard({
    Key? key,
    required this.bodyText,
  }) : super(key: key);
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    // TODO テキストの長さによってウィジェットの高さを可変にしたい
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkShadow,
            spreadRadius: 1.0,
            blurRadius: 3.0,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
            await _loadHTML(
              bodyText,
              _controller,
            );
          },
        ),
      ),
    );
  }

  Future _loadHTML(String rawText, WebViewController controller) async {
    String previewHTML = '<body>' +
        md.markdownToHtml(rawText.replaceAll('\\n', '\n')) +
        '</body>';
    // iOSの場合、メタタグを付けないとテキストが小さくなるため、
    // Headerにメタタグを追加する
    String header =
        '<head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>';
    previewHTML += header;
    controller.loadUrl(
      Uri.dataFromString(
        previewHTML,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}
