import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/models/post.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/constants.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:webviewx/webviewx.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBodyCard extends StatefulWidget {
  const DetailBodyCard({
    Key? key,
    required this.bodyText,
  }) : super(key: key);
  final String bodyText;
  @override
  _DetailBodyCard createState() => _DetailBodyCard();
}

class _DetailBodyCard extends State<DetailBodyCard> {
  @override
  Widget build(BuildContext context) {
    //late WebViewXController _controller;
    late WebViewXController _webviewController;
    // TODO テキストの長さによってウィジェットの高さを可変にしたい
    return Container(
      width: webWidth,
      padding: const EdgeInsets.all(10),
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
        // width: 600,
        height: MediaQuery.of(context).size.height,
        child: MarkdownBody(
          data: widget.bodyText,
          selectable: true,
          onTapLink: (val, val2, val3) {
            launch(val2 ?? '');
          },
        ),
      ),
    );
  }

  _loadHTML(String rawText) {
    // iOSの場合、メタタグを付けないとテキストが小さくなるため、
    // Headerにメタタグを追加する

    String previewHTML =
        '<head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>';
    previewHTML += '<body>' +
        md.markdownToHtml(rawText.replaceAll('\\n', '\n')) +
        '</body>';
    return previewHTML;
  }
}
