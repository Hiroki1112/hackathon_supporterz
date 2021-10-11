import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';

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

  ///  タグ追加時に使用する
  static Future<List<Tag>> getTagListByKeyword(String keyword) async {
    var db = FirebaseFirestore.instance;
    // ignore: prefer_typing_uninitialized_variables
    Query<Map<String, dynamic>> query;

    if (keyword == '') {
      query = db.collection('api').doc('v1').collection('tags').limit(9);
    } else {
      List<String> keyword2gram = AppHelper.get2gram(keyword);
      print(keyword2gram);
      // 変換したものを元にタイトルを検索するクエリを実装
      query = db.collection('api').doc('v1').collection('tags').limit(9);

      keyword2gram.forEach((element) {
        query = query.where('tag2gram.' + element, isEqualTo: true);
      });
    }

    List<Tag> recommendTags = [];
    var response = await query.get();

    if (response.docs.isNotEmpty) {
      for (var element in response.docs) {
        Map data = element.data();
        recommendTags.add(
          Tag(tag: element.data()['tag'], url: data['url']),
        );
      }
    }

    return recommendTags;
  }

  ///  タグ追加時に使用する
  /*
  static Future<void> addNewTag() async {
    var db = FirebaseFirestore.instance;

    // 現在のタグを取得する
    var query = await db.collection('api').doc('v1').collection('tags').get();

    Future.forEach(query.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> element) async {
      Map<String, dynamic> newData = element.data();
      newData['tag2gram'] =
          AppHelper.get2gramMap(element.data()['tag'].toString().toLowerCase());
      await db
          .collection('api')
          .doc('v1')
          .collection('tags')
          .doc(element.id)
          .update(
            newData,
          );
    });
  }*/
}
