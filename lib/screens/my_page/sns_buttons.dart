import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class SNSButtons extends StatefulWidget {
  const SNSButtons({
    Key? key,
    required this.twitterLink,
    required this.githubLink,
  }) : super(key: key);
  final String twitterLink;
  final String githubLink;

  @override
  _SNSButtonsState createState() => _SNSButtonsState();
}

class _SNSButtonsState extends State<SNSButtons> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
      ),
      child: Row(
        children: [
          widget.twitterLink != ''
              ? IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: FaIcon(
                    FontAwesomeIcons.twitter,
                    color: HexColor('00ACEE'),
                    size: 30,
                  ),
                  onPressed: () async {
                    await _launchInBrowser(
                        'https://twitter.com/' + widget.twitterLink);
                    print("Pressed");
                  },
                )
              : Container(),
          widget.githubLink != ''
              ? IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: FaIcon(
                    FontAwesomeIcons.github,
                    color: HexColor('171515'),
                    size: 30,
                  ),
                  onPressed: () async {
                    await _launchInBrowser(
                        'https://github.com/' + widget.githubLink);
                    print("Pressed");
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
