import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:webview_flutter/webview_flutter.dart';

class PreviewCard extends StatefulWidget {
  const PreviewCard({
    Key? key,
    required this.rawText,
  }) : super(key: key);
  final String rawText;

  @override
  _PreviewCardState createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  late final WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        // TextFormFirldは一行あたり25らしい
        height: 250,
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
                _controller = webViewController;
                await _loadHTML();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.purple.withOpacity(0.9),
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: Text(
                    'Preview',
                    style: TextStyle(
                      color: AppTheme.white,
                    ),
                  ),
                )
              ],
            )
          ],
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
