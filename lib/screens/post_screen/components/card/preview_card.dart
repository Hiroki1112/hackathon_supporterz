import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
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
      child: SingleChildScrollView(
        child: Container(
          // TextFormFirldは一行あたり25らしい
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              MarkdownBody(
                data: widget.rawText,
                selectable: true,
                onTapLink: (val, val2, val3) {
                  launch(val2 ?? '');
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
      ),
    );
  }
}
