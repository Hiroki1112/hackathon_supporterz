import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';

class FirebaseHelper {
  static Future<QuerySnapshot<Map<String, dynamic>>> getKeywordSearchResult(
      String title) async {
    var db = FirebaseFirestore.instance;
    // stringを2-gramに変換
    List<String> title2gram = AppHelper.get2gram(title);

    // 変換したものを元にタイトルを検索するクエリを実装
    var query = db.collection('api').doc('v1').collection('posts').limit(20);
    title2gram.forEach((key) {
      query = query.where('title2gram.' + key, isEqualTo: true);
    });

    // 取得したデータをList<Map<String, dynamic>>型に変換する

    return await query.get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getTagSearchResult(
      String tag) async {
    var db = FirebaseFirestore.instance;

    // 変換したものを元にタイトルを検索するクエリを実装
    var query = db
        .collection('api')
        .doc('v1')
        .collection('posts')
        .limit(20)
        .where('techTag', arrayContains: tag);

    return await query.get();
  }
}
