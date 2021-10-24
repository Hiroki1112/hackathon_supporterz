import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jiffy/util/app_theme.dart';
import 'package:jiffy/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;

class DetailPlanText extends StatelessWidget {
  const DetailPlanText({
    Key? key,
    required this.planeText,
  }) : super(key: key);

  final String planeText;

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: webWidth,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
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
          child: Column(
            children: [
              MarkdownBody(
                data: planeText,
                selectable: true,
                onTapLink: (val, val2, val3) {
                  launch(val2 ?? '');
                },
              ),
            ],
          ),
        ),
        // Container(padding: const EdgeInsets.all(10), child: Text(planeText)),
      ),
    );
  }

  // Future _loadHTML(String rawText, WebViewController controller) async {
  //   String previewHTML = '<body>' +
  //       md.markdownToHtml(rawText.replaceAll('\\n', '\n')) +
  //       '</body>';
  //   // iOSの場合、メタタグを付けないとテキストが小さくなるため、
  //   // Headerにメタタグを追加する
  //   String header =
  //       '<head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>';
  //   previewHTML += header;
  //   controller.loadUrl(
  //     Uri.dataFromString(
  //       previewHTML,
  //       mimeType: 'text/html',
  //       encoding: Encoding.getByName('utf-8'),
  //     ).toString(),
  //   );
  // }
}
