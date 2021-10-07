import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon_supporterz/screens/my_page/profile_edit.dart';
import 'package:hackathon_supporterz/screens/post_screen/post_screen.dart';
import 'package:hackathon_supporterz/widgets/appbar/my_appbar.dart';
import 'package:hackathon_supporterz/widgets/tiles/post_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
                    await _launchInBrowser(widget.twitterLink);
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
                    await _launchInBrowser(widget.githubLink);
                    print("Pressed");
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
