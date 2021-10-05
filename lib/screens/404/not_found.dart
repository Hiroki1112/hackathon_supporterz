import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/screens/home/home_screen.dart';
import 'package:hackathon_supporterz/util/config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// アクセスしたページが見つからなかった時に返却するクラス
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // モバイルの場合は表示(true)にする
        automaticallyImplyLeading: !kIsWeb,
        title: const Text('Supporterz'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          // web用のレイアウト
          return Center(
            child: Container(
              width: 600,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    'お探しのページは見つかりませんでした。',
                    style: Config.h1,
                  ),
                  Image.asset(
                    'images/undraw_page_not_found.png',
                    width: 600,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popAndPushNamed(HomeScreen.routeName);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text('ホームに戻る'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        // モバイル用のレイアウト( 使うことはおそらくない)
        return Column(
          children: [
            Column(
              children: [
                const Text(
                  'お探しのページは見つかりませんでした。',
                  style: Config.h1,
                ),
                Image.asset(
                  'images/undraw_page_not_found.png',
                  width: 600,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popAndPushNamed(HomeScreen.routeName);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text('ホームに戻る'),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
